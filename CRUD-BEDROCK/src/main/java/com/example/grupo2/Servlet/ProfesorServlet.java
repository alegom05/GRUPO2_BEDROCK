package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Profesores;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.ProfesoresDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "Profesores", value = "/Profesores")
public class ProfesorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        ProfesoresDao profesoresDao = new ProfesoresDao();
        switch (action) {
            case "listar" -> {
                ArrayList<Profesores> listaProfesores = profesoresDao.obtenerProfesores();
                request.setAttribute("profesores",listaProfesores);
                RequestDispatcher view =request.getRequestDispatcher("/AdministradorJSPS/profesores-Admin.jsp");
                view.forward(request,response);
            }
            case "formCrear" -> {
                RequestDispatcher view = request.getRequestDispatcher("/AdministradorJSPS/nuevoProfesor-Admin.jsp");
                view.forward(request, response);
            }
            case "editar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Profesores prof = profesoresDao.buscarPorIdProf(id);
                if (prof != null) {
                    request.setAttribute("profesores", prof);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AdministradorJSPS/editarProfesor-Admin.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Profesores");
                }
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        ProfesoresDao profesoresDao = new ProfesoresDao();
        switch (action) {
            case "agregar" -> {
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String curso = request.getParameter("curso");
                profesoresDao.crearProfesores(nombre, apellido, curso);
                response.sendRedirect(request.getContextPath() + "/Profesores");
            }
            case "actualizar" -> {
                Profesores serenazgo = leerParametrosRequest(request);
                profesoresDao.actualizar(serenazgo);
                response.sendRedirect(request.getContextPath() + "/Profesores");
            }
            case "borrar" -> {
                String id = request.getParameter("id");
                profesoresDao.eliminarProfesor(id);
                response.sendRedirect(request.getContextPath() + "/Profesores");
            }
        }
    }
    public Profesores leerParametrosRequest(HttpServletRequest request) {
        String id = request.getParameter("id");
        String curso = request.getParameter("curso");

        Profesores prof = new Profesores();
        prof.setId(id);
        prof.setCurso(curso);


        return prof;
    }
}
