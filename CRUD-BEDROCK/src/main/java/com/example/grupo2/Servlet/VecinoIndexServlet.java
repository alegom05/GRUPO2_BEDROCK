package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "VecinoIndexServlet", value = "/VecinoIndexServlet")
public class VecinoIndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") == null ? "pagPrincipal" : request.getParameter("action");
        UsuarioDao newVecinoDao = new UsuarioDao();

        switch (action) {
            case "pagPrincipal" -> {
                requestDispatcher = request.getRequestDispatcher("./VecinosJSPS/paginaPrincipalBeta-Vecino.jsp");
                requestDispatcher.forward(request,response);
            }
            case "editar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Usuario vecino = newVecinoDao.buscarPorId(id);
                if (vecino != null) {
                    request.setAttribute("usuarioSesion", vecino);
                    requestDispatcher = request.getRequestDispatcher("/VecinosJSPS/detallesUsuario-Vecino.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/VecinoIndexServlet");
                }
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");
        UsuarioDao userDao = new UsuarioDao();

        //cambio para que no se vean las ips, si hay conflicto es culpa de adrian :c
        doGet(request,response);

        switch (action) {
            case "actualizarDatos" -> {
                Usuario vecino = leerParametrosRequest(request);
                userDao.actualizar(vecino);
                response.sendRedirect(request.getContextPath() + "/VecinoIndexServlet");

            }
            case "cambiarContra" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                String clave = request.getParameter("clave");
            }
            case "cambiarContraVeci" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                System.out.println("el servelt");
                // Verificar que la contraseña antigua sea correcta
                Usuario vecino = userDao.buscarPorId(id);
                if (vecino != null && vecino.getClave().equals(oldPassword)) {
                    // Actualizar la contraseña
                    userDao.actualizarContrasenia(id, newPassword);
                    System.out.println("contraseña cambiada");
                    response.sendRedirect(request.getContextPath() + "/VecinoIndexServlet?a=editar&id=" + id);
                }else {
                // Redirigir con un mensaje de error
                request.setAttribute("error", "La contraseña antigua es incorrecta.");
                request.getRequestDispatcher("/ruta/del/formulario").forward(request, response);
                }
            }
            case "enviarSolicitud" -> {
                int id1 = Integer.parseInt(request.getParameter("id"));
                userDao.crearSolicitudCoordi(id1);
                System.out.println("procesando solicitud");
                response.sendRedirect(request.getContextPath() + "/VecinoIndexServlet?a=editar&id=" + id1);

            }

        }
    }
    public Usuario leerParametrosRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String urbanizacion = request.getParameter("urbanizacionInput");
        String direccion = request.getParameter("direccionInput");
        String telefono = request.getParameter("telefonoInput");
        String contrasenia = request.getParameter("contrasenia");

        Usuario vecino = new Usuario();
        vecino.setId(id);
        vecino.setUrbanizacion(urbanizacion);
        vecino.setNumtelefono(telefono);
        vecino.setDireccion(direccion);
        vecino.setClave(contrasenia);

        return vecino;
    }
}
