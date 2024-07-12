package com.example.grupo2.Servlet;

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
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;


@MultipartConfig
@WebServlet(name = "Coordis", value = "/Coordis")
public class CoordisRolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        EventoDao eventoDao = new EventoDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {
            //Este case será para el listado de eventos de coordinadora
            case "listaEventos":
                ArrayList<Evento> listaEventos2 = eventoDao.listarEventosParaCoordi();
                request.setAttribute("listaEventos",listaEventos2);

                view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventosNew.jsp");
                view.forward(request,response);
                break;

            //Case para crear eventos de coordinadoras
            case "formCrearEventos":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view.forward(request, response);
                break;

            //Case para editar eventos de coordinadoras
            case "editarEventos":
                String id= request.getParameter("id");
                Evento evento = eventoDao.obtenerEventoPorId(id);
                if (evento != null) {
                    request.setAttribute("evento", evento);
                    request.getRequestDispatcher("/CoordinadorasJSPS/ModificarEvento.jsp").forward(request,response);

                } else {
                    response.sendRedirect(request.getContextPath() + "/EventoServlet");
                }
                break;

            //Case para elminar eventos
            case "deleteEventos":
                String ide= request.getParameter("id");
                Evento eventoo= eventoDao.obtenerEventoPorId(ide);
                if(eventoo!=null){
                    try{
                        eventoDao.borrarEvento(ide);
                    }catch (SQLException e){
                        System.out.println("Log:exception"+e.getMessage());

                    }
                }
                response.sendRedirect(request.getContextPath()+"/EventoServlet");
                break;

            //Este caso servirá para cuando la coordinadora desea revisar los detalles de alguno de sus eventos creados
            case "detallarParaCoordi":
                String idCoordi = request.getParameter("id");
                if(eventoDao.obtenerEventoPorId(idCoordi) != null){
                    Evento evento2 = eventoDao.obtenerEventoPorId(idCoordi);
                    if (evento2 != null) {
                        request.setAttribute("evento", evento2);

                        String estado = evento2.getEstadoEvento();
                        request.setAttribute("mostrarGuardar","Pronto".equals(estado));
                        request.setAttribute("mostrarIniciar", "Pronto".equals(estado));
                        request.setAttribute("mostrarCerrar","En curso".equals(estado));


                        view = request.getRequestDispatcher("/CoordinadorasJSPS/detallesEvento.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/HistorialDeEventosNew.jsp");
                view.forward(request, response);
                break;

            //Este case será para el listado de incidencias de coordinadora
            /*case "listaIncidencias":

                ArrayList<Incidencia> listaIncidencias2 = IncidenciaDao.listarIncidencias();
                request.setAttribute("lista2", listaIncidencias2);

                RequestDispatcher view2 = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view2.forward(request, response);
                break;*/

            case "detallarIncidencia":
                String id3 = request.getParameter("id");
                int idint = Integer.parseInt(id3);
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id3)) != null) {
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(idint);
                    request.setAttribute("incidencia", incidencia);
                    RequestDispatcher view1 = request.getRequestDispatcher("/CoordinadorasJSPS/detallesIncidencia.jsp");
                    view1.forward(request, response);
                }else {
                    System.out.println("Incidencia no encontrada para el ID: " + id3); // Log de incidencia no encontrada
                    //response.sendRedirect("error.jsp");
                }
                break;

            case "formCrearIncidencia":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidenciaVerisonPRUEBA.jsp");
                view.forward(request, response);
                break;

            //Para que la coordinadora visualice sus incidencias
            case "listaCoordi":
                String idCoordi2 = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidenciasCoordi = incidenciaDao.listarIncidenciasDeUnUsuario(idCoordi2);
                request.setAttribute("incidencia", listaIncidenciasCoordi);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request, response);
                break;




            //Pestaña Lista de vecinos ***
            case "listarve":
                ArrayList<Usuario> listaUsuario = usuarioDao.listarUsuarios();
                request.setAttribute("lista",listaUsuario);
                view =request.getRequestDispatcher("/CoordinadorasJSPS/VecinoSanmi.jsp");
                view.forward(request,response);
                break;
            //Pestaña Reportar incidencia ***
            /*case "formCrearInci":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidenciaVerisonPRUEBA.jsp");
                view.forward(request, response);
                break;*/
            //Pestaña Lista de incidencias -> Listar Coordis ***
            /*case "listaCoordi":
                String idCoordi = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidenciasCoordi = incidenciaDao.listarIncidenciasDeUnUsuario(idCoordi);
                request.setAttribute("incidencia", listaIncidenciasCoordi);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request, response);
                break;*/
            //Detalle de incidencia -> Detalles de una incidencia para Coordis
            /*case "detallar3":
                String id3 = request.getParameter("id");
                int idint = Integer.parseInt(id3);
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id3)) != null) {
                    Incidencia incidencia3 = incidenciaDao.obtenerIncidenciaPorId(idint);
                    request.setAttribute("incidencia", incidencia3);
                    RequestDispatcher view1 = request.getRequestDispatcher("/CoordinadorasJSPS/detallesIncidencia.jsp");
                    view1.forward(request, response);
                }else {
                    System.out.println("Incidencia no encontrada para el ID: " + id3); // Log de incidencia no encontrada
                    //response.sendRedirect("error.jsp");
                }
                break;*/
            //Pestaña Página Principal ***
            /*case "paginaPrincipal":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaPrincipal.jsp");
                break;*/
            /*case "reportarIncidencia":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ReportarIncidencia.jsp");
                break;*/
            /*case "listarIncidencias":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                break;*/
            //Pestaña Mira tu calendario ***
            case "calendario":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/Calendario.jsp");
                break;
            //Pestaña Historial de Eventos ***
            /*case "historialEventos":
                ArrayList<Evento> listaEventos = eventoDao.listarEventosCoordi2();
                request.setAttribute("listaEventos", listaEventos);
                view = request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventosNew.jsp");
                view.forward(request, response);
                break;*/
            //Vista Crear evento
            /*case "crearev":
                RequestDispatcher view22 = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view22.forward(request, response);
                break;*/
            /*case "detallarev":
                String id4 = request.getParameter("id");
                int idint4 = Integer.parseInt(id4);
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id4)) != null) {
                    Evento evento = eventoDao.obtenerEventoPorId(id4);
                    request.setAttribute("evento", evento);
                    RequestDispatcher view1 = request.getRequestDispatcher("/CoordinadorasJSPS/detallesEvento.jsp");
                    view1.forward(request, response);
                }else {
                    System.out.println("Incidencia no encontrada para el ID: " + id4); // Log de incidencia no encontrada
                    //response.sendRedirect("error.jsp");
                }
                break;*/
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        EventoDao eventoDao = new EventoDao();
        RequestDispatcher view;

        switch (action) {
            //Crear Evento
            case "crearEvento":

                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String lugar = request.getParameter("lugar");
                String encargado = request.getParameter("profesor");
                String vacantes = request.getParameter("vacantes");
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");

                String horaParam = request.getParameter("hora");

                String materiales= request.getParameter("materiales");
                String frecuencia= request.getParameter("frecuencia");

                String tipoEvento= request.getParameter("tipoEvento");

                Part filePart = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream foto = null;
                if (filePart != null && filePart.getSize() > 0) {
                    foto = filePart.getInputStream(); // Lee el contenido del archivo como un InputStream
                }
                System.out.println(nombre);
                System.out.println(descripcion);
                System.out.println(lugar);
                System.out.println(encargado);
                System.out.println(vacantes);
                System.out.println(fechaInicio);
                System.out.println(fechaFin);
                System.out.println(horaParam);
                System.out.println(materiales);
                System.out.println(frecuencia);
                System.out.println(tipoEvento);

                Evento evento1 = new Evento();

                try {
                    evento1.setNombre(nombre);
                    evento1.setDescripcion(descripcion);
                    evento1.setLugar(lugar);
                    evento1.setVacantes(Integer.parseInt(vacantes));
                    evento1.setFechaInicial(Date.valueOf(fechaInicio));
                    evento1.setFechaFinal(Date.valueOf(fechaFin));

                    // Validar y convertir la hora
                    if (horaParam != null && !horaParam.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                        long ms = sdf.parse(horaParam).getTime();
                        evento1.setHora(new Time(ms));
                    }

                    evento1.setMateriales(materiales);
                    evento1.setFrecuencia(Integer.parseInt(frecuencia));
                    evento1.setTipo(tipoEvento);
                    evento1.setFoto(foto);
                    evento1.setIdProfesor(4);

                    eventoDao.crearEvento(evento1);
                    response.sendRedirect(request.getContextPath() + "/Coordis?action=listaEventos");

                } catch (NumberFormatException e) {
                    // Manejo de errores de formato de número
                    request.setAttribute("errorMessage", "El número de vacantes y la frecuencia deben ser números enteros.");
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                } catch (IllegalArgumentException e) {
                    // Manejo de errores de formato de fecha
                    request.setAttribute("errorMessage", "Formato de fecha inválido: debe ser yyyy-MM-dd.");
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                } catch (ParseException e) {
                    // Manejo de errores de formato de hora
                    request.setAttribute("errorMessage", "Formato de hora inválido: debe ser HH:mm.");
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                }
                System.out.println(evento1.getNombre());
                System.out.println(evento1.getDescripcion());
                System.out.println(evento1.getLugar());
                System.out.println(evento1.getIdProfesor());
                System.out.println(evento1.getVacantes());
                System.out.println(evento1.getFechaInicial());
                System.out.println(evento1.getFechaFinal());
                System.out.println(evento1.getHora());
                System.out.println(evento1.getMateriales());
                System.out.println(evento1.getFrecuencia());
                System.out.println(evento1.getTipo());


                break;
            //Este case servirá para que coordi confirme que asistió al evento (por ahora solo podemos subir una foto,
            //se debe arreglar base de datos para solucionar eso)
            case "publicarFotosAsistencia":
                Part filePart2 = request.getPart("foto"); // Obtén la parte del archivo
                InputStream foto2 = null;
                if (filePart2 != null && filePart2.getSize() > 0) {
                    foto2 = filePart2.getInputStream(); // Lee el contenido del archivo como un InputStream
                }
                String idEventoAsistencia = request.getParameter("id");
                System.out.println("Id de evento:" + idEventoAsistencia);
                System.out.println("Codigo de foto supongo:" + foto2);

                Evento evento2 = new Evento();
                evento2.setFotoAsistenciaEvento(foto2);
                evento2.setIdEvento(Integer.parseInt(idEventoAsistencia));

                System.out.println("Id de evento ya seteado:" + evento2.getIdEvento());
                System.out.println("Codigo de foto supongo, ya seteado:" + evento2.getFotoAsistenciaEvento());

                eventoDao.publicarFotosAsistencia(evento2);
                eventoDao.editarEstadoEventoCuliminado(String.valueOf(evento2.getIdEvento()));

                System.out.println("Se envia a evento dao?");
                response.sendRedirect(request.getContextPath() + "/Coordis?action=listaEventos");

                break;

            case "modificar":
                /*
                String nombre2 = request.getParameter("nombre");
                String descripcion2 = request.getParameter("descripcion");
                String lugar2 = request.getParameter("lugar");
                String encargado2 = request.getParameter("encargado");
                String vacantes2 = request.getParameter("vacantes");
                String fechaInicio2 = request.getParameter("fechaInicial");
                String fechaFin2 = request.getParameter("fechaFinal");
                String hora2= request.getParameter("hora");

                boolean esValido2= true;

                if(esValido2){
                    Evento evento2= new Evento();
                    evento2.setNombre(nombre2);
                    evento2.setDescripcion(descripcion2);
                    evento2.setLugar(lugar2);
                    evento2.setIdProfesor(Integer.parseInt(encargado2));
                    evento2.setVacantes(Integer.parseInt(vacantes2));
                    evento2.setFechaInicial(Date.valueOf(fechaInicio2));
                    evento2.setFechaFinal(Date.valueOf(fechaFin2));
                    evento2.setHora(Time.valueOf(hora2));

                    eventoDao.modificarEvento(evento2);
                    response.sendRedirect(request.getContextPath() + "/EventoServlet");

                }else{
                    request.setAttribute("evento",eventoDao.obtenerEventoPorId());
                    request.getRequestDispatcher("CoordinadorasJSPS/ModificarEvento.jsp");
                }

                 */
                break;

            //Case que servirá para inciar el evento que ha creado la coordinadora, cambiará su parámetro de estado "pronto"
            // a un estado "en curso"
            case "eventoEnCurso":
                String idEvento = request.getParameter("idEvento");
                if (idEvento != null) {
                    eventoDao.editarEstadoEventoEnCurso(idEvento);
                    response.sendRedirect(request.getContextPath() + "/Coordis?action=listaEventos");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;

            //Case que servirá para culminar el evento que ha creado la coordinadora, cambiará su parámetro de estado "En curso"
            // a un estado "Culminado"
            case "eventoCulminado":
                String idEvento2 = request.getParameter("id");
                if (idEvento2 != null) {
                    eventoDao.editarEstadoEventoCuliminado(idEvento2);
                    response.sendRedirect(request.getContextPath() + "/Coordis?action=listaEventos");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;

            //Para que coordinadora cree su incidencia
            case "reportarIncidencia":
                String nombreIncidencia2 = request.getParameter("nombreIncidencia");
                String lugar2 = request.getParameter("lugarIncidencia");
                String referencia2 = request.getParameter("referencia");
                String descripcionIncidencia2 = request.getParameter("descripcion");
                String phoneNumber2 = request.getParameter("contacto");
                boolean ambulancia2 = Boolean.parseBoolean(request.getParameter("ambulancia"));

                Part filePart3 = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream foto3 = null;
                if (filePart3 != null && filePart3.getSize() > 0) {
                    foto3 = filePart3.getInputStream(); // Lee el contenido del archivo como un InputStream
                }

                String tipoIncidencia2 = request.getParameter("tipo");
                System.out.println(tipoIncidencia2);
                System.out.println(nombreIncidencia2);
                System.out.println(lugar2);
                System.out.println(referencia2);
                System.out.println(descripcionIncidencia2);
                System.out.println(phoneNumber2);
                System.out.println(ambulancia2);
                int idUsuario2 = Integer.parseInt(request.getParameter("idUsuario"));


                System.out.println(idUsuario2);

                Incidencia nuevaIncidencia2 = new Incidencia();

                nuevaIncidencia2.setNombreIncidencia(nombreIncidencia2);
                nuevaIncidencia2.setLugar(lugar2);
                nuevaIncidencia2.setReferencia(referencia2);
                nuevaIncidencia2.setDescripcion(descripcionIncidencia2);
                nuevaIncidencia2.setContacto(phoneNumber2);
                nuevaIncidencia2.setRequiereAmbulancia(ambulancia2);
                nuevaIncidencia2.setFotoIncidencia(foto3);
                nuevaIncidencia2.setIdTipoIncidencia(tipoIncidencia2);
                nuevaIncidencia2.setIdUsuario(idUsuario2);

                incidenciaDao.crearIncidencia(nuevaIncidencia2);
                System.out.println(nuevaIncidencia2.getNombreIncidencia());
                System.out.println(nuevaIncidencia2.getLugar());
                System.out.println(nuevaIncidencia2.getReferencia());
                System.out.println(nuevaIncidencia2.getDescripcion());
                System.out.println(nuevaIncidencia2.getContacto());
                System.out.println(nuevaIncidencia2.getIdTipoIncidencia());
                System.out.println(nuevaIncidencia2.getIdUsuario());
                response.sendRedirect(request.getContextPath() + "/Coordis?action=listaCoordi&idUsuario=" + idUsuario2);

                break;




        }
    }


}