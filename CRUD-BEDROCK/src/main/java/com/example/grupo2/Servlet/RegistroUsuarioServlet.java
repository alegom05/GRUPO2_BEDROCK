package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.UsuarioDao;

import java.sql.SQLException;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;  //InternetAddress, MimeMessage

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



import java.util.ArrayList;

@WebServlet(name = "RegistroUsuarioServlet", urlPatterns = {"/register", "/RegistroUsuarioServlet"})
public class RegistroUsuarioServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí puedes redirigir a la página de registro si se accede directamente al servlet sin datos de registro
        response.sendRedirect(request.getContextPath() + "/RegistroUsuarios.jsp");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        // Recoger los datos del formulario
        String name = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String direccion = request.getParameter("direccion");
        String urbanizacion = request.getParameter("urbanizacion");
        String email = request.getParameter("email");

        // Crear el objeto Usuario y establecer el rol de prevecino (suponiendo que el rol de prevecino tiene el ID PV)
        Usuario usuario = new Usuario();
        usuario.setNombre(name);
        usuario.setApellido(apellidos);
        usuario.setDni(dni);
        usuario.setDireccion(direccion);
        usuario.setUrbanizacion(urbanizacion);
        usuario.setCorreo(email);
        usuario.setRol("PV"); // ID del rol de prevecino

        // Guardar el usuario en la base de datos
        UsuarioDao usuarioDAO = new UsuarioDao();
        try {
            usuarioDAO.saveUsuario(usuario);
            // Enviar el correo de confirmación
            sendWelcomeEmail(name, email);
            // Redirigir al formulario de registro para completar más datos
            response.sendRedirect(request.getContextPath() + "/ResgitroUsuarios.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error al registrar el usuario.");
            request.setAttribute("errorMessage", "Error al registrar el usuario.");
            requestDispatcher = request.getRequestDispatcher("error.jsp");
            requestDispatcher.forward(request, response);
            return;
        }


        // Responder al cliente
        response.setContentType("text/html");
        response.getWriter().println("Registro exitoso. Un correo ha sido enviado a " + email);
    }
    private void sendWelcomeEmail(String name, String email) {
        String host = "smtp.gmail.com";
        final String user = "asanmiguel2024@gmail.com"; // Correo del administrador de registros
        final String password = "vofcewndaxskxlfz";  // Contrasena del correo
//'final' es para que el valor de las variables no pueda cambiarse en ninguna parte del codigo

        // Configuración de propiedades para la conexión SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        // Obtener la sesión de correo
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            // Componer el mensaje
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Bienvenido a la página web");
            message.setText("Señor " + name + ", pronto le estaremos notificando su aceptación a la página web.");

            // Enviar el mensaje
            Transport.send(message);

            System.out.println("Correo enviado exitosamente...");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
