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
                String rol = request.getParameter("rol");
                System.out.println(rol);
                System.out.println(id);
                String correoDestino = request.getParameter("correo");
                System.out.println("Aprobando solicitud para ID: " + id + ", Correo: " + correoDestino);
                serenazgosDao.aprobarSolicitud(id);
                String contra;
                int idUsuario;

                idUsuario = serenazgosDao.buscarIdUsuario(id);
                serenazgosDao.ponerTipo(idUsuario);
                contra = "123456";
                System.out.println(idUsuario);
                serenazgosDao.colocarClave(idUsuario,contra);
                Usuario usuario = serenazgosDao.buscarPorId(idUsuario);
                String correo = usuario.getCorreo();
                String clave = usuario.getClave();
                System.out.println(correo);
                System.out.println(clave);
                serenazgosDao.crearCredenciales(correo, clave, idUsuario);

                String mensaje;
                System.out.println("rol"+rol);
                if ("VE".equals(rol)) {
                    mensaje = "Su solicitud para ser Coordinadora de San Miguel ha sido aprobada.\nAtte.\nAdministración";
                } else {
                    mensaje = "Su solicitud para ser Vecino de San Miguel ha sido aprobada.Ingresa al sistema con tu correo y la contraseña por defecto \"123456\".\nAtte.\nAdministración";
                }

                String asunto = "Solicitud Aprobada";
                new Thread(() -> enviarCorreo(correoDestino, asunto, mensaje)).start();
                response.setStatus(HttpServletResponse.SC_OK);
                // La redirección se maneja en el cliente
            }
            case "rechazar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                String correo = request.getParameter("correo");
                String motivo = request.getParameter("motivo");

                serenazgosDao.rechazarSolicitud(id);

                String mensaje = "Su solicitud ha sido rechazada por la siguiente razón: " + motivo + ".\nAtte.\nAdministración";
                String asunto = "Solicitud Rechazada";
                new Thread(() -> enviarCorreo(correo, asunto, mensaje)).start();

                response.setStatus(HttpServletResponse.SC_OK);

            }
        }
    }

    private void enviarCorreo(String destinatario, String asunto, String cuerpo) {
        System.out.println("Iniciando proceso de envío de correo a: " + destinatario);
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Añadir estas líneas para obtener más información de debug
        props.put("mail.debug", "true");
        props.put("mail.debug.auth", "true");

        final String username = "asanmiguel2024@gmail.com"; // Reemplaza con tu correo de Gmail
        final String password = "vofcewndaxskxlfz"; // Reemplaza con tu contraseña

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setText(cuerpo);

            Transport.send(message);

            System.out.println("Correo enviado exitosamente a " + destinatario);
        } catch (MessagingException e) {
            System.err.println("Error al enviar el correo: " + e.getMessage());
            e.printStackTrace();

        }
    }





}



