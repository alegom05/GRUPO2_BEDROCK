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

        switch (action) {
            case "listarin" -> {
                String id = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidenciasDeUnUsuario(id);
                request.setAttribute("lista",listaIncidencias);
                RequestDispatcher view =request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request,response);

            }
            case "listarev" -> {
                ArrayList<Evento> listaEventos = eventoDao.listarEventos();
                request.setAttribute("lista",listaEventos);
                RequestDispatcher view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventos.jsp");
                view.forward(request,response);
            }
            case "listarve" -> {
                ArrayList<Usuario> listaUsuario = usuarioDao.listarUsuarios();
                request.setAttribute("lista",listaUsuario);
                RequestDispatcher view =request.getRequestDispatcher("/CoordinadorasJSPS/VecinoSanmi.jsp");
                view.forward(request,response);
            }
            case "crearin" -> {
                RequestDispatcher view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidencia.jsp");
                view.forward(request, response);

            }
            case "formCrear" -> {
                RequestDispatcher view = request.getRequestDispatcher("/AdministradorJSPS/nuevoSerenazgo-Admin.jsp");
                view.forward(request, response);
            }
            case "editar" -> {
                /*int id = Integer.parseInt(request.getParameter("id"));
                Usuario serenazgo = serenazgosDao.buscarPorId(id);
                if (serenazgo != null) {
                    request.setAttribute("serenazgo", serenazgo);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AdministradorJSPS/editarSerenazgo-Admin.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Serenazgos");
                }*/
            }
            //JSPS
            case "paginaPrincipal" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaPrincipal.jsp");

            }
            case "Eventos" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaEventos.jsp");
            }
            case "reportarIncidencia" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ReportarIncidencia.jsp");
            }
            case "listarIncidencias" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ListaDeIncidencias.jsp");
            }
            case "calendario" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/Calendario.jsp");
            }
            case "historialEventos" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/HistorialDeEventos.jsp");
            }
            case "listarVecinos" -> {
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/VecinoSanmi.jsp");
            }
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();
        IncidenciaDao incidenciaDao = new IncidenciaDao();

        switch (action) {
            case "agregar" -> {
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String dni = request.getParameter("dni");
                String nacimiento = request.getParameter("nacimiento");
                String numtelefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");
                String tipo = request.getParameter("tipo");
                String turnoSerenazgo = request.getParameter("turno");
                String correo_pucp = request.getParameter("correo");
                String contrasenia = request.getParameter("contrasenia");

                serenazgosDao.crearSerenazgos(nombre, apellido, dni, nacimiento, numtelefono, direccion, tipo, turnoSerenazgo, correo_pucp, contrasenia);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }
            case "actualizar" -> {
                Usuario serenazgo = leerParametrosRequest(request);
                serenazgosDao.actualizar(serenazgo);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }
            case "borrar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.eliminarSerenazgo(id);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }

            case "crearIn" ->{
                String nombreIncidencia = request.getParameter("nombreIncidencia");
                String lugar = request.getParameter("lugarIncidencia");
                String referencia = request.getParameter("referencia");
                String descripcionIncidencia = request.getParameter("descripcion");
                String phoneNumber = request.getParameter("contacto");
                boolean ambulancia = Boolean.parseBoolean(request.getParameter("ambulancia"));

                Part filePart = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream inputStream=filePart.getInputStream();
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
                nuevaIncidencia.setFotoIncidencia(inputStream);
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
                response.sendRedirect(request.getContextPath() + "/Coordis?a=listarin&idUsuario" + idUsuario);


            }


        }
    }
    public Usuario leerParametrosRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String tipo = request.getParameter("tipo");
        String turno = request.getParameter("turno");
        String correo = request.getParameter("correo");
        String contrasenia = request.getParameter("contrasenia");

        Usuario serenazgo = new Usuario();
        serenazgo.setId(id);
        serenazgo.setNumtelefono(telefono);
        serenazgo.setDireccion(direccion);
        serenazgo.setTipo(tipo);
        serenazgo.setTurnoSerenazgo(turno);
        serenazgo.setCorreo(correo);
        serenazgo.setClave(contrasenia);

        return serenazgo;
    }

}
