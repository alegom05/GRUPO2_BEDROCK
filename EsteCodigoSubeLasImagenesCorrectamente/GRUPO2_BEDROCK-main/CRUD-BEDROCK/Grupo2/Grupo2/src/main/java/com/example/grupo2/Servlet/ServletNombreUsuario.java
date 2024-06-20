package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.NombreUsuario;
import com.example.grupo2.daos.NombreUsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="ServletNombreUsuario", value="/ServletNombreUsuario")
public class ServletNombreUsuario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            NombreUsuarioDao nombreUsuarioDao = new NombreUsuarioDao();
            NombreUsuario nombreUsuario = nombreUsuarioDao.obtenerUsuarioPorId(Integer.parseInt(id));

            if (nombreUsuario != null) {
                request.setAttribute("nombreUsuario", nombreUsuario);
                RequestDispatcher view = request.getRequestDispatcher("paginaPrincipal-Serenazgo.jsp");
                view.forward(request, response);
            } else {
                response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre el nomnbre
            }
        } else {
            response.sendRedirect("error.jsp"); // Página de error en caso de que el ID sea nulo o vacío
        }
    }
}

