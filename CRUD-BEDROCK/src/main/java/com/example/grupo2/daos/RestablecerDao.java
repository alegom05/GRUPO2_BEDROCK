package com.example.grupo2.daos;

import com.example.grupo2.Beans.Restablecer;

import javax.mail.*;
import javax.mail.internet.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;

public class RestablecerDao extends daoBase{


    public int buscarCorreo(String correo) {

        int buscador = 0;
        String sql = "SELECT correo FROM usuario WHERE correo = ?";
        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, correo);

            try (ResultSet rs = pstmt.executeQuery();) {

                if (rs.next()) {
                    buscador= 1;
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return buscador;
    }

    public void cambiarcontra(String email, String contrasenha) {


        String sql = "UPDATE usuario SET clave = ? WHERE correo = ?";

        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, contrasenha);
            pstmt.setString(2, email);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearCredencialesContraNueva(String correo, String clave) {

        String sql = "UPDATE credenciales SET claveHash = sha2(?,256) WHERE correo = ?;";

        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, clave);
            pstmt.setString(2, correo);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



    public ArrayList<Restablecer> obtenerCorreo(String email) {

        ArrayList<Restablecer> lista = new ArrayList<>();

        Restablecer restablecer = new Restablecer();
        restablecer.setCorreo(email);

        return lista;
    }

    public ArrayList<Restablecer> obtenerInfo(String email, String contra) {

        ArrayList<Restablecer> lista = new ArrayList<>();

        Restablecer restablecer = new Restablecer();
        restablecer.setCorreo(email);
        restablecer.setContra(contra);

        return lista;
    }
    public void enviarCodigo(String correoCliente, String codigo) {
        //Turn off Two Factor Authentication
        //Turn off less secure app
        final String sender = "asanmiguel2024@gmail.com"; // The sender email
        final String urpass = "vofcewndaxskxlfz"; //keep it secure
        Properties set = new Properties();
        //Set values to the property
        set.put("mail.smtp.starttls.enable", "true");
        set.put("mail.smtp.auth", "true");
        set.put("mail.smtp.host", "smtp.gmail.com");
        set.put("mail.smtp.port", "587");
        set.put("mail.smtp.ssl.trust","*");
        Session session = Session.getInstance(set,new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(sender, urpass);
            }});

        try {
            //email extends Java's Message Class, check out javax.mail.Message class to read more
            Message email = new MimeMessage(session);
            email.setFrom(new InternetAddress("asanmiguel2024@gmail.com")); //sender email address here
            email.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(correoCliente)); //Receiver email address here
            email.setSubject("Código de validación"); //Email Subject and message

            // creating first MimeBodyPart object
            BodyPart messageBodyPart1 = new MimeBodyPart();
            messageBodyPart1.setText("Este es su código de verificación"+" "+codigo);

            // creating MultiPart object
            Multipart multipartObject = new MimeMultipart();
            multipartObject.addBodyPart(messageBodyPart1);

            // set body of the email.
            email.setContent(multipartObject);

            Transport.send(email);
            System.out.println("Your email has successfully been sent!");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
