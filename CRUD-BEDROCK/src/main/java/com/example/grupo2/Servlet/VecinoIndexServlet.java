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
