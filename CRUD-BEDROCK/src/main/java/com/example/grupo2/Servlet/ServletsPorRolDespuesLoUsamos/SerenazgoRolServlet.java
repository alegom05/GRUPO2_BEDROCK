package com.example.grupo2.Servlet.ServletsPorRolDespuesLoUsamos;

import com.example.grupo2.Beans.*;
import com.example.grupo2.daos.EventoDao;
import com.example.grupo2.daos.IncidenciaDao;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@MultipartConfig
@WebServlet(name = "Sereno", value = "/Sereno")
public class SerenazgoRolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        EventoDao eventoDao = new EventoDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {

            //Pestaña Dashboard ***
            case "estadisticalizarIncidencias":
                CantidadIncidencias cantidadIncidencias = incidenciaDao.hallarCantidadIncidencias();
                IncidenciasPorMes incidenciasPorMes = incidenciaDao.hallarIncidenciasPorMes();
                ArrayList<Incidencia> listaIncidencias2 = incidenciaDao.listarIncidencias();
                request.setAttribute("cantidad", cantidadIncidencias);
                request.setAttribute("porMes", incidenciasPorMes);
                request.setAttribute("listaIncidencias", listaIncidencias2);


                view = request.getRequestDispatcher("/SerenazgoJSPS/dashboard-Serenazgo.jsp");
                view.forward(request, response);
                break;
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

            //Pestaña Incidencias***
            case "listaIncidencias":
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidencias();
                request.setAttribute("lista", listaIncidencias);

                view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);
                break;
            //Vista Detallar Incidencia
            case "detallarIncidencia":
                String id2 = request.getParameter("id");
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id2)) != null) {
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id2));
                    if (incidencia != null) {
                        request.setAttribute("incidencia", incidencia);

                        String estado = incidencia.getEstadoIncidencia();
                        request.setAttribute("mostrarEvaluar", "Nueva".equals(estado));
                        request.setAttribute("mostrarVerEvaluacion", "En proceso".equals(estado));
                        request.setAttribute("mostrarFalsaAlarma", "Nueva".equals(estado) || "En proceso".equals(estado));
                        request.setAttribute("mostrarCerrar", "En proceso".equals(estado));

                        view = request.getRequestDispatcher("/SerenazgoJSPS/detallesIncidencia-Serenazgo.jsp");
                        request.getSession().setAttribute("incidenciaParaExportar", incidencia);

                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                } else {
                    response.sendRedirect("error.jsp");
                }
                view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);
                break;

            case "verFotoIncidencia":
                String incidenciaId = request.getParameter("id");
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                String DB_URL = "jdbc:mysql://localhost:3306/basededatos3?serverTimezone=America/Lima";
                String DB_USER = "root";
                String DB_PASSWORD = "root";

                try {
                    // Registrar el driver de MySQL
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Obtener la conexión a la base de datos
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Consulta para obtener la imagen del evento
                    String sql = "SELECT foto FROM incidencia WHERE idIncidenciaReportada = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, incidenciaId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        Blob blob = rs.getBlob("foto");
                        if (blob != null) {
                            byte[] bytes = blob.getBytes(1, (int) blob.length());

                            response.setContentType("image/jpeg"); // Ajusta el tipo de contenido según el tipo de imagen
                            OutputStream os = response.getOutputStream();
                            os.write(bytes);
                            os.flush();
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND); // Imagen no encontrada
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    throw new ServletException("Error accediendo a la base de datos", e);
                } finally {
                    // Cerrar la conexión
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }

                break;


        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {
            case "borrar":
                String id = request.getParameter("id");
                String descripcion = request.getParameter("descripcion");
                if (id != null && descripcion != null) {
                    incidenciaDao.borrarIncidencia(id, descripcion);
                }
                response.sendRedirect(request.getContextPath() + "/Sereno?action=listaIncidencias");

                break;
            case "falsaAlarma":
                String idIncidencia = request.getParameter("idIncidencia");
                if (idIncidencia != null) {
                    incidenciaDao.editarEstadoFalsaAlarma(idIncidencia);
                    response.sendRedirect(request.getContextPath() + "/Sereno?action=listaIncidencias");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;

            case "incidenciaCerrada":
                String idIncidencia2 = request.getParameter("idIncidencia");
                if (idIncidencia2 != null) {
                    incidenciaDao.editarEstadoCerrado(idIncidencia2);
                    response.sendRedirect(request.getContextPath() + "/Sereno?action=listaIncidencias");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;
            //Vista Evaluar Incidencia
            case "evaluar":
                String criticidad = request.getParameter("criticidad");
                boolean requiereBomberos = Boolean.parseBoolean(request.getParameter("requiereBomberos"));
                boolean requierePolicia = Boolean.parseBoolean(request.getParameter("requierePolicia"));
                boolean requiereAmbulancia = Boolean.parseBoolean(request.getParameter("requiereAmbulancia"));
                String personalRefuerzo = request.getParameter("personalRefuerzo");
                String descripcionSolucion = request.getParameter("descripcionSolucion");
                String idIncidenciaEvaluacion = request.getParameter("id");

                Incidencia incidencia = new Incidencia();

                incidencia.setCriticidad(criticidad);
                incidencia.setRequiereBomberos(requiereBomberos);
                incidencia.setRequierePolicia(requierePolicia);
                incidencia.setRequiereAmbulancia(requiereAmbulancia);
                incidencia.setPersonalRefuerzo(personalRefuerzo);
                incidencia.setDescripcionSolucion(descripcionSolucion);
                incidencia.setIdIncidencia(Integer.parseInt(idIncidenciaEvaluacion));


                incidenciaDao.evaluarIncidencias(incidencia);
                response.sendRedirect(request.getContextPath() + "/Sereno?action=listaIncidencias");

                break;

            case "actualizarSe":
                String serenazgoId = request.getParameter("serenazgoId");
                String celular = request.getParameter("numTelefono");

                Usuario usuario = new Usuario();
                usuario.setId(Integer.parseInt(serenazgoId));
                usuario.setNumtelefono(celular);

                usuarioDao.actualizarCelular(usuario);
                response.sendRedirect(request.getContextPath() + "/Usuario?action=actualizarS&id=" + serenazgoId) ;

                break;
        }
    }
}
