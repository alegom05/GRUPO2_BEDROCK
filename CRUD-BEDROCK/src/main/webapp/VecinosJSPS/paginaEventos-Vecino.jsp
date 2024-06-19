<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.grupo2.daos.EventoDao" %>
<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.Math" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style-Vecino.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="../logos-Vecino/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
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
                <a href="<%=request.getContextPath()%>/EventoServlet?action=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="HistorialDeEventos.jsp" class="nav-link">Historial De Eventos</a>
            </li>
        </ul>
    </nav>
</div>

<div class="contenedor imagen-container mt-4">
    <div class="row mt-4">
        <div class="col">
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" aria-haspopup="true" aria-expanded="false">
                    Filtrar
                </button>
                <div class="dropdown-content" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="EventosDeportivos.html">Eventos Deportivos</a>
                    <a class="dropdown-item" href="EventosCulturales.html">Eventos Culturales</a>
                    <a class="dropdown-item" href="EventosMasPopulares.html">Eventos Más Populares</a>
                    <a class="dropdown-item" href="paginaEventos-Vecino.jsp">Quitar Filtros</a>
                </div>
            </div>
        </div>
        <div class="col">
            <nav aria-label="Page navigation" class="no_colocar_fondo mb-3">
                <ul class="pagination justify-content-end">
                    <%
                        EventoDao eventosDAO = new EventoDao();
                        int pageSize = 6;
                        int totalEvents = eventosDAO.contarEventos();
                        int totalPages = (int) Math.ceil(totalEvents / (double) pageSize);
                        int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

                        if (currentPage > 1) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="paginaEventos-Vecino.jsp?page=<%= currentPage - 1 %>" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <%
                        }
                        for (int i = 1; i <= totalPages; i++) {
                    %>
                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <a class="page-link" href="paginaEventos-Vecino.jsp?page=<%= i %>"><%= i %></a>
                    </li>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="paginaEventos-Vecino.jsp?page=<%= currentPage + 1 %>" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>
    </div>

    <div class="row">
        <%
            ArrayList<Evento> listaeventos = eventosDAO.listarEventos_limitado(currentPage, pageSize);
            for (Evento evento : listaeventos) {
        %>
        <div class="col-md-4 custom-cartanz-2">
            <a href="<%= request.getContextPath() %>/EventosDetallado?id=<%= evento.getIdEvento() %>" class="card-link">
                <div class="card shadow">
                    <img src="<%= request.getContextPath() %>/imagenEvento?id=<%= evento.getIdEvento() %>" alt="Imagen del evento" class="card-img-top w-100">
                    <div class="card-body">
                        <h5 class="card-title"><%= evento.getNombre() %></h5>
                        <p class="card-text"><%= evento.getFechaFinal() %></p>
                    </div>
                </div>
            </a>
        </div>
        <%
            }
        %>
    </div>
</div>
<!-- Script de Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

