<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page import="com.example.grupo2.daos.EventoDao" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%
    // Retrieve event ID from request parameter
    String eventId = request.getParameter("id");
    EventoDao eventoDao = new EventoDao();
    Evento evento = eventoDao.obtenerEventoPorId(eventId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/VecinosJSPS/style-Vecino.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior" style="overflow-x: hidden">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" >
            <h4 class="main-logo-size" style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="DetallesUsuario.html">
                <img src="../logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%></h2>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/logos-Vecino/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>

    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/VecinoIndexServlet" class="nav-link">Municipalidad</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EventoServlet?action=eventos" class="nav-link">Eventos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=formCrear" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=lista3&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EventoServlet?action=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="HistorialDeEventos.jsp" class="nav-link">Historial De Eventos</a>
            </li>
        </ul>
    </nav>
</div>

<div id="container-evento-det" style="max-width: 80%; margin: 0 auto; margin-top: 70px;">
    <div class="row mt-3">
        <div class="col-md-6 mb-3">
            <div class="contenedor mt-4 text-center" style="max-width: 600px; margin: 0 auto;">
                <h1><%= evento.getNombre() %></h1>
            </div>
            <div class="contenedor mt-4" >
                <img src="<%=request.getContextPath()%>/imagenEvento?id=<%= evento.getIdEvento() %>" alt="Evento" id="imagen_detallada" class="img-fluid mx-auto" style="max-width: 100%;">
            </div>
        </div>

        <div class="col-md-6 d-flex align-items-center">
            <div>
                <div class="">
                    <div class="elemento_texto_evento">
                        <h4>Detalles del evento:</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4><%= evento.getDescripcion() %></h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Encargado: <%= evento.getNombreProfesor() %></h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Vacantes Disponibles: <%= evento.getVacantes() %></h4>
                    </div>
                    <div class="row w-75 align-items-center">
                        <div class="col-md-6 pr-md-0">
                            <h4>Frecuencia: <%= evento.getFrecuencia() %></h4>
                        </div>
                    </div>
                    <div class="row w-75 align-items-center">
                        <div class="col-md-6 pr-md-0 w-25">
                            <img src="${pageContext.request.contextPath}/imagenes_eventos-Vecino/lugar.png" class="img-thumbnail w-75" alt="fecha">
                        </div>
                        <div class="col-md-6 pr-md-0 w-75">
                            <h4>Lugar: <%= evento.getLugar() %></h4>
                        </div>
                    </div>
                    <div class="row w-75 align-items-center">
                        <div class="col-md-6 pr-md-0 w-25">
                            <img src="${pageContext.request.contextPath}/imagenes_eventos-Vecino/fecha.png" class="img-thumbnail w-75" alt="fecha">
                        </div>
                        <div class="col-md-6 pr-md-0 w-75">
                            <h4>Fecha inicial: <%= evento.getFechaInicial() %></h4>
                        </div>
                    </div>
                    <div class="row w-75 align-items-center">
                        <div class="col-md-6 pr-md-0 w-25">
                            <img src="${pageContext.request.contextPath}/imagenes_eventos-Vecino/hora.png" class="img-thumbnail w-75" alt="hora">
                        </div>
                        <div class="col-md-6 pr-md-0 w-75">
                            <h4>Hora: <%= evento.getHora() %></h4>
                        </div>
                    </div>

                </div>
                <div class="elemento_texto_evento d-flex mt-1">
                    <a href="<%= request.getContextPath() %>/Inscribirse?id=<%= evento.getIdEvento() %>" class="btn btn-mas-grande"><h7>Inscribirse</h7></a>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
