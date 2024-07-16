package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CoordinadoraIndexServlet", value = "/CoordinadoraIndexServlet")
public class CoordinadoraIndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") == null ? "PagPrincipal" : request.getParameter("action");
        UsuarioDao userDao = new UsuarioDao();
        switch (action) {
            case "PagPrincipal":
                requestDispatcher = request.getRequestDispatcher("/CoordinadorasJSPS/PaginaPrincipal.jsp");
                requestDispatcher.forward(request,response);
            break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Usuario user = userDao.buscarPorId(id);
                if (user != null) {
                    request.getSession().setAttribute("coordiId", id);
                    request.setAttribute("usuarioSesion", user);
                    requestDispatcher = request.getRequestDispatcher("/CoordinadorasJSPS/detalleDeUsuarioCoordi.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/CoordinadoraIndexServlet");
                }
            break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");
        UsuarioDao userDao = new UsuarioDao();
        doGet(request,response);
        switch (action){
            case "actualizar":
                int id = (int) request.getSession().getAttribute("coordiId");
                Usuario user = leerParametrosRequest(request);
                user.setId(id);
                userDao.actualizar(user);
                response.sendRedirect(request.getContextPath() + "/CoordinadoraIndexServlet");
                break;
            /*case "cambiarContrasena":
                int id = Integer.parseInt(request.getParameter("id"));
                String clave = request.getParameter("clave");
                break;*/



        }

    }
    public Usuario leerParametrosRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String urbanizacion = request.getParameter("urbanizacionInput");
        String direccion = request.getParameter("direccionInput");
        String telefono = request.getParameter("telefonoInput");
        String contrasenia = request.getParameter("contrasenia");

        Usuario user = new Usuario();
        user.setId(id);
        user.setUrbanizacion(urbanizacion);
        user.setNumtelefono(telefono);
        user.setDireccion(direccion);
        user.setClave(contrasenia);

        return user;
    }
}
