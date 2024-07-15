package com.example.grupo2.Servlet;

import com.example.grupo2.daos.RestablecerDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;

@WebServlet(name = "RestablecerClave", value = "/RestablecerClave")
public class RestablecerClave extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        RestablecerDao restablecerDao = new RestablecerDao();
        System.out.println("correo");

        String email;
        String contra;
        String recontra;
        String codigo;
        String verificador;
        switch (action) {
            case "validar" -> {
                email = request.getParameter("modalEmail");
                System.out.println(email);
                int buscador = restablecerDao.buscarCorreo(email);
                System.out.println(buscador);
                if (buscador == 0) {
                    session.setAttribute("invalid_correo", "error");
                    response.sendRedirect(request.getContextPath() + "/LoginServlet");
                } else {
                    codigo = "";
                    String[] nums = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
                    for (int j = 0; j < 11; j++) {
                        codigo += nums[(int) Math.round(Math.random() * 9)];
                    }
                    restablecerDao.enviarCodigo(email, codigo);
                    session.setAttribute("id", codigo);
                    session.setAttribute("email", email);
                    session.setAttribute("invalid_id", "null");
                    session.setAttribute("invalid_repeat", "null");
                    session.setAttribute("invalid_pass", "null");
                    RequestDispatcher view = request.getRequestDispatcher("EstablecerNuevaCont.jsp");
                    view.forward(request, response);
                }
            }
            case "nuevo" -> {
                email = request.getParameter("InputEmail");
                System.out.println(email);
                request.setAttribute("primer_registro", restablecerDao.obtenerCorreo(email));
                RequestDispatcher view = request.getRequestDispatcher("EstablecerNuevaCont.jsp");
                view.forward(request, response);
            }
            case "restablecer" -> {
                email = request.getParameter("correo");
                verificador = request.getParameter("verificador");
                codigo = request.getParameter("codigo");
                contra = request.getParameter("pass");
                recontra = request.getParameter("pass2");
                if (!(verificador.equals(codigo))) {
                    session.setAttribute("invalid_id", "error");
                    RequestDispatcher view =request.getRequestDispatcher("EstablecerNuevaCont.jsp");
                    view.forward(request,response);
                } else {
                    if (!(contra.equals(recontra))) {
                        session.setAttribute("invalid_repeat", "error");
                        RequestDispatcher view =request.getRequestDispatcher("EstablecerNuevaCont.jsp");
                        view.forward(request,response);
                    }
                    else{
                        restablecerDao.cambiarcontra(email,contra);
                        restablecerDao.crearCredencialesContraNueva(email,contra);
                        response.sendRedirect(request.getContextPath() + "/LoginServlet");
                    }
                }
            }
            case "actualizar" ->{
                email = request.getParameter("InputEmail");
                contra = request.getParameter("InputPassword");
                restablecerDao.cambiarcontra(email,contra);
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
            }
        }
    }
}
