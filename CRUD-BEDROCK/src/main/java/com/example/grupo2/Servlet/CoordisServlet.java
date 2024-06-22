package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.EventoDao;
import com.example.grupo2.daos.IncidenciaDao;
import com.example.grupo2.daos.SerenazgosDao;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

@WebServlet(name = "Coordis", value = "/Coordis")
public class CoordisServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Incidencia incidencia = new Incidencia();
        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        EventoDao eventoDao = new EventoDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {
            case "listarin":
                String id = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidenciasDeUnUsuario(id);
                request.setAttribute("lista",listaIncidencias);
                view =request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request,response);
                break;

            case "listarev":
                ArrayList<Evento> listaEventos = eventoDao.listarEventos();
                request.setAttribute("lista",listaEventos);
                view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventos.jsp");
                view.forward(request,response);
                break;
            case "listarve":
                ArrayList<Usuario> listaUsuario = usuarioDao.listarUsuarios();
                request.setAttribute("lista",listaUsuario);
                view =request.getRequestDispatcher("/CoordinadorasJSPS/VecinoSanmi.jsp");
                view.forward(request,response);
                break;
            case "formCrearInci":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidencia.jsp");
                view.forward(request, response);
                break;
            //JSPS
            case "paginaPrincipal":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaPrincipal.jsp");
                break;
            case "Eventos":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaEventos.jsp");
                break;
            case "reportarIncidencia":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ReportarIncidencia.jsp");
                break;
            case "listarIncidencias":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                break;
            case "calendario":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/Calendario.jsp");
                break;
            case "historialEventos":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/HistorialDeEventos.jsp");
                break;
            case "listarVecinos":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/VecinoSanmi.jsp");
                break;
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        RequestDispatcher view;

        switch (action) {

            case "crearInci":
                String nombreIncidencia = request.getParameter("nombreIncidencia");
                String lugar = request.getParameter("lugarIncidencia");
                String referencia = request.getParameter("referencia");
                String descripcionIncidencia = request.getParameter("descripcion");
                String phoneNumber = request.getParameter("contacto");
                boolean ambulancia = Boolean.parseBoolean(request.getParameter("ambulancia"));

                Part filePart = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream foto = null;
                if (filePart != null && filePart.getSize() > 0) {
                    foto = filePart.getInputStream(); // Lee el contenido del archivo como un InputStream
                }

                String tipoIncidencia = request.getParameter("tipo");
                System.out.println(tipoIncidencia);
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

                Incidencia nuevaIncidencia = new Incidencia();

                nuevaIncidencia.setNombreIncidencia(nombreIncidencia);
                nuevaIncidencia.setLugar(lugar);
                nuevaIncidencia.setReferencia(referencia);
                nuevaIncidencia.setDescripcion(descripcionIncidencia);
                nuevaIncidencia.setContacto(phoneNumber);
                nuevaIncidencia.setRequiereAmbulancia(ambulancia);
                nuevaIncidencia.setFotoIncidencia(foto);
                nuevaIncidencia.setIdTipoIncidencia(tipoIncidencia);
                nuevaIncidencia.setIdUsuario(idUsuario);

                incidenciaDao.crearIncidencia(nuevaIncidencia);
                System.out.println(nuevaIncidencia.getNombreIncidencia());
                System.out.println(nuevaIncidencia.getLugar());
                System.out.println(nuevaIncidencia.getReferencia());
                System.out.println(nuevaIncidencia.getDescripcion());
                System.out.println(nuevaIncidencia.getContacto());
                System.out.println(nuevaIncidencia.getIdTipoIncidencia());
                System.out.println(nuevaIncidencia.getIdUsuario());
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=listaCoordi&idCoordi=" + idUsuario);

                break;




        }
    }


}
