package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.LoginDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        String logout = request.getParameter("finish");
        if(logout == null){
            requestDispatcher = request.getRequestDispatcher("login.jsp");
            requestDispatcher.forward(request,response);

        }else{
            if(logout.equals("yes")){

                HttpSession session = request.getSession();
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/MenuSinLoginServlet");

            }else{

                requestDispatcher = request.getRequestDispatcher("login.jsp");
                requestDispatcher.forward(request,response);

            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LoginDao loginDao = new LoginDao();

        String correo = request.getParameter("email");
        String pass = request.getParameter("password1");
        System.out.println(correo);
        System.out.println(pass);
        Usuario usuario = loginDao.validarHash(correo, pass);
        HttpSession session = request.getSession();

        if (usuario != null) {
            if (usuario.isBanned()) {
                // El usuario está baneado
                session.setAttribute("indicador", "baneado");
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
            } else {
                // El usuario no está baneado, procede con el login normal
                session.setAttribute("usuarioSesion", usuario);
                session.setAttribute("rol", usuario.getRol());
                session.setMaxInactiveInterval(60 * 60);
                if ("VE".equals(usuario.getRol())) {
                    response.sendRedirect(request.getContextPath() + "/VecinoIndexServlet");
                } else if ("CO".equals(usuario.getRol())) {
                    response.sendRedirect(request.getContextPath() + "/CoordinadoraIndexServlet");
                } else if ("SE".equals(usuario.getRol())) {
                    response.sendRedirect(request.getContextPath() + "/SerenazgoIndexServlet");
                } else {
                    response.sendRedirect(request.getContextPath() + "/AdminIndexServlet");
                }
            }
        } else {
            // Credenciales inválidas
            session.setAttribute("indicador", "error");
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        }

    }
}
