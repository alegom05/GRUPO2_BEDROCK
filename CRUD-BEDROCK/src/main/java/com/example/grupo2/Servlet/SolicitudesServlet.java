package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Solicitudes;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.SerenazgosDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

@WebServlet(name = "Solicitudes", value = "/Solicitudes")
public class SolicitudesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();
        switch (action) {
            case "listar" -> {
                ArrayList<Solicitudes> listaSolicitudes = serenazgosDao.obtenerSolicitudes();
                request.setAttribute("solicitudes", listaSolicitudes);
                RequestDispatcher view = request.getRequestDispatcher("/AdministradorJSPS/solicitudes-Admin.jsp");
                view.forward(request, response);
            }
            case "aprobar" -> {
                System.out.println("SolicitudesServlet: doGet iniciado");
                int idsolicitud = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.aprobarSolicitud(idsolicitud);
                response.sendRedirect(request.getContextPath() + "/Solicitudes");

            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();
        switch (action) {
            case "aprobar" -> {
                System.out.println("Iniciando proceso de aprobación...");
                int id = Integer.parseInt(request.getParameter("id"));
                String correo = request.getParameter("correo");
                System.out.println("Aprobando solicitud para ID: " + id + ", Correo: " + correo);
                serenazgosDao.aprobarSolicitud(id);
                new Thread(() -> enviarCorreo(correo)).start();
                response.setStatus(HttpServletResponse.SC_OK);
                // La redirección se maneja en el cliente
                }
            case "rechazar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.rechazarSolicitud(id);
                response.sendRedirect(request.getContextPath() + "/Solicitudes");
            }
        }
    }

    private void enviarCorreo(String correo) {
        System.out.println("Iniciando proceso de envío de correo a: " + correo);
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Añadir estas líneas para obtener más información de debug
        props.put("mail.debug", "true");
        props.put("mail.debug.auth", "true");

        try {
            System.out.println("Creando sesión de correo...");
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("asanmiguel2024@gmail.com", "vofcewndaxskxlfz");
                }
            });

            System.out.println("Creando mensaje...");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("asanmiguel2024@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            message.setSubject("Solicitud Aprobada");
            message.setText("Tu solicitud para ser Vecino de San Miguel ha sido aprobada.\n"
                    + "Ingresa al sistema con tu correo y la contraseña por defecto \"123456\".\n"
                    + "Atte.\nAdministración");

            System.out.println("Enviando mensaje...");
            Transport.send(message);

            System.out.println("Correo enviado exitosamente a: " + correo);
        } catch (MessagingException e) {
            System.err.println("Error al enviar el correo: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error inesperado: " + e.getMessage());
            e.printStackTrace();
        }
    }
}


