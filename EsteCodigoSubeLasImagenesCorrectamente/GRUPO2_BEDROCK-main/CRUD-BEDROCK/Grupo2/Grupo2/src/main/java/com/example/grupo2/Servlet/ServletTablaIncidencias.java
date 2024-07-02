package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.TablaIncidencias;
import com.example.grupo2.daos.TablaIncidenciasDao;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name="ServletTablaIncidencias", value={"/listaIncidencias","/ServletTablaIncidencias"})
public class ServletTablaIncidencias extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        TablaIncidenciasDao tablaIncidenciasDao = new TablaIncidenciasDao();
        ArrayList<TablaIncidencias> listarIncidencias = tablaIncidenciasDao.listarIncidencias();

        request.setAttribute("lista", listarIncidencias);

        RequestDispatcher view = request.getRequestDispatcher("tablaIncidencias-Serenazgo.jsp");
        view.forward(request,response);


        }

    }



