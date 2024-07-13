package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Usuario;

import com.example.grupo2.daos.ResgistroDao;
import com.example.grupo2.daos.UsuarioDao;

import java.sql.SQLException;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;  //InternetAddress, MimeMessage

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



import java.util.ArrayList;

@WebServlet(name = "RegistroUsuarioServlet", urlPatterns = {"/register", "/RegistroUsuarioServlet"})
public class RegistroUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "reiniciar" : request.getParameter("action");
        UsuarioDao usuariodao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {
            //para que el usuario se registre
            case "creacionform":
                view = request.getRequestDispatcher("/RegistroUsuarios.jsp");
                view.forward(request, response);
                break;
            case "reiniciar":
                view = request.getRequestDispatcher("/pagPrincipalSinLogin.jsp");
                view.forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        UsuarioDao usuariodao = new UsuarioDao();
        ResgistroDao registrodao = new ResgistroDao();
        RequestDispatcher view;
        switch (action) {
            case "envioregistro":
                // Recoger los datos del formulario
                String name = request.getParameter("nombre");
                String apellidos = request.getParameter("apellidos");
                String dni = request.getParameter("dni");
                String direccion = request.getParameter("direccion");
                String urbanizacion = request.getParameter("urbanizacion");
                String email = request.getParameter("email");

                if (email == null || email.isEmpty()) {
                    request.setAttribute("errorMessage", "El correo no puede estar vacío.");
                    view = request.getRequestDispatcher("/RegistroUsuarios.jsp");
                    view.forward(request, response);
                    return;
                }

                // Crear el objeto Usuario y establecer el rol de prevecino (suponiendo que el rol de prevecino tiene el ID PV)
                Usuario usuario = new Usuario();
                usuario.setNombre(name);
                usuario.setApellido(apellidos);
                usuario.setDni(dni);
                usuario.setDireccion(direccion);
                usuario.setUrbanizacion(urbanizacion);
                usuario.setCorreo(email);




                try {
                    if (usuariodao.esUsuarioPorCorreo(email)==1){ // Si el usuario ya existe, redirigir a una página de error o mostrar un mensaje de error
                        request.setAttribute("errorMessage", "El usuario ya existe.");
                        view = request.getRequestDispatcher("/RegistroUsuarios.jsp");
                        view.forward(request, response);
                    } else {
                        usuariodao.saveUsuario(usuario);
                        // Enviar correo de confirmación
                        boolean emailSent = sendWelcomeEmail(name, email);
                        // Redirigir a la página de éxito o a la página principal
                        //response.sendRedirect(request.getContextPath() + "/pagPrincipalSinLogin.jsp");
                        if (emailSent) {
                            String idUsuario = registrodao.obtenerIdUsuario(dni);
                            registrodao.crearSolicitudVecino(idUsuario);
                            view = request.getRequestDispatcher("/pagPrincipalSinLogin.jsp");
                        } else {
                            request.setAttribute("errorMessage", "Error al enviar el correo de confirmación.");
                            view = request.getRequestDispatcher("/error.jsp");
                        }
                        view.forward(request, response);
                        //response.sendRedirect(request.getContextPath() + "/MenuSinLoginServlet");
                    }

                } catch (SQLException e) {
                    e.printStackTrace();
                    /*response.getWriter().println("Error al registrar el usuario.");
                    request.setAttribute("errorMessage", "Error al registrar el usuario.");
                    view = request.getRequestDispatcher("error.jsp");
                    view.forward(request, response);*/
                    request.setAttribute("errorMessage", "Error al registrar el usuario.");
                    view = request.getRequestDispatcher("/error.jsp");
                    view.forward(request, response);
                    return;
                }
                // Responder al cliente
                //response.setContentType("text/html");
                //response.getWriter().println("Registro exitoso. Un correo ha sido enviado a " + email);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                break;
        }

    }
    private boolean sendWelcomeEmail(String name, String email) {
        String host = "smtp.gmail.com";
        final String user = "asanmiguel2024@gmail.com";
        final String password = "vofcewndaxskxlfz";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Bienvenido a la página web");
            message.setText("Señor " + name + ", pronto le estaremos notificando su aceptación a la página web.");

            Transport.send(message);
            System.out.println("Correo enviado exitosamente...");
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
