package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Historial;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.IncidenciaDao;
import com.example.grupo2.daos.SerenazgosDao;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "UsuarioServlet", value = {"/Usuario","/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;
        switch (action) {
            //Con este caso listaremos los datos del serenazgo, para eso necesitaremos su id, sabemos que una vez dentro de la cuenta
            //del respectivo rol obtenemos el id debido al login, entonces tendremos este dato en todas las vistas
            case "actualizarS":
                String id = request.getParameter("id");
                if(usuarioDao.listarPorId(Integer.parseInt(id)) != null){
                    Usuario usuario = usuarioDao.listarPorId(Integer.parseInt(id));
                    if (usuario != null) {
                        request.setAttribute("usuarioSerenazgo", usuario);

                        view = request.getRequestDispatcher("/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp");
                view.forward(request, response);
                break;

            //Este caso será utilizado para actulizar el número de teléfono del serenazgo auqnue eso se realizará exactamente
            //en el doPost, en el doGet solo redigiremos a la página correspondiente para llevar a cabo nuestra tarea.
            case "actualizarSe":
                view = request.getRequestDispatcher("/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp");
                view.forward(request, response);
                break;

            //Para que la coordi vea info de usuarios
            case "detallar":
                String idVeci= request.getParameter("id");
                ArrayList<Historial> historialVecino= usuarioDao.historialUsuario2(idVeci);
                request.setAttribute("historialVecino",historialVecino );

                if(usuarioDao.buscarPorId(Integer.parseInt(idVeci)) != null){
                    Usuario vecino = usuarioDao.buscarPorId(Integer.parseInt(idVeci));
                    if(vecino !=null){
                        request.setAttribute("vecino", vecino);
                        requestDispatcher  = request.getRequestDispatcher("/CoordinadorasJSPS/detallesVecino.jsp");
                        requestDispatcher.forward(request, response);
                    }else{
                        response.sendRedirect("error.jsp");
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }
            break;





        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;
        switch (action) {
            case "actualizarSe":
                String serenazgoId = request.getParameter("serenazgoId");
                String celular = request.getParameter("numTelefono");

                Usuario usuario = new Usuario();
                usuario.setId(Integer.parseInt(serenazgoId));
                usuario.setNumtelefono(celular);

                usuarioDao.actualizarCelular(usuario);
                response.sendRedirect(request.getContextPath() + "/Usuario?action=actualizarS&id=" + serenazgoId) ;

                break;

            //Para que la coordi reporte al vecino- historial de comportamiento
            case "reportar":
                String motivoReporte= request.getParameter("motivoReporte");
                String idUsuario= request.getParameter("idVecino");
                Usuario vecino = new Usuario();
                vecino.setId(Integer.parseInt(idUsuario));
                vecino.setMotivoReporte(motivoReporte);
                usuarioDao.reportarVecino(vecino);
                response.sendRedirect(request.getContextPath() + "/CoordinadoraIndexServlet");

                break;

        }
    }

}
