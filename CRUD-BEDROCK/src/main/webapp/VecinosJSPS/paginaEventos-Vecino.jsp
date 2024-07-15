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
<%
    HttpSession currentSession = request.getSession();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/VecinosJSPS/style-Vecino.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior" style="overflow-x: hidden">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 class="main-logo-size" style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="javascript:void(0)" onclick="detallesUsuario('<%=usuarioSesion.getId()%>')">
                <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
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
                <a href="${pageContext.request.contextPath}/EventoServlet?action=listarEventoFiltrado" class="nav-link">Eventos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=formCrear" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0)" onclick="listaIncidencias('<%=usuarioSesion.getId()%>')" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0)" onclick="verCalendario('<%=usuarioSesion.getId()%>')" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0)" onclick="historialEventos('<%=usuarioSesion.getId()%>')" class="nav-link">Historial De Eventos</a>
            </li>
        </ul>
    </nav>
</div>

<div class="contenedor imagen-container mt-4" style="overflow-x: hidden">
    <div class="row mt-4">
        <div class="col">
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" aria-haspopup="true" aria-expanded="false">
                    Filtrar
                </button>
                <div class="dropdown-content" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado&filtro=Deporte">Eventos Deportivos</a>
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado&filtro=Cultura">Eventos Culturales</a>
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado&filtro=Popular">Eventos Más Populares</a>
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado&filtro=Vigentes">Eventos Disponibles</a>
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado&filtro=Pasados">Eventos No Disponibles</a>
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado">Quitar Filtros</a>
                </div>
            </div>
        </div>
        <div class="col">
            <nav aria-label="Page navigation" class="no_colocar_fondo mb-3">
                <ul class="pagination justify-content-end">
                    <%
                        int totalPages = (int) request.getAttribute("totalPages");
                        int currentPage = (int) request.getAttribute("currentPage");
                        String filtro = (String) request.getAttribute("filtro");
                        String filtroParam = filtro != null && !filtro.isEmpty() ? "&filtro=" + filtro : "";
                        if (currentPage > 1) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="<%=request.getContextPath()%>/EventoServlet?action=listarEventoFiltrado&page=<%= currentPage - 1 %><%= filtroParam %>" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <%
                        }
                        for (int i = 1; i <= totalPages; i++) {
                    %>
                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <a class="page-link" href="<%= request.getContextPath() %>/EventoServlet?action=listarEventoFiltrado&page=<%= i %><%= filtroParam %>"><%= i %></a>
                    </li>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="<%= request.getContextPath() %>/EventoServlet?action=listarEventoFiltrado&page=<%= currentPage + 1 %><%= filtroParam %>" aria-label="Next">
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
            ArrayList<Evento> listaeventos = (ArrayList<Evento>) request.getAttribute("listaEventos");
            for (Evento evento : listaeventos) {
        %>
        <div class="col-md-4 custom-cartanz-2">
            <a href="${pageContext.request.contextPath}/EventoServlet?action=evento_detallados&ideven=<%= evento.getIdEvento() %>&idusu=<%=usuarioSesion.getId()%>" class="card-link">                <div class="card shadow">
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
    <!-- Modal de inscripción exitosa -->
    <div class="modal fade" id="inscripcionModal" tabindex="-1" aria-labelledby="inscripcionModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="inscripcionModalLabel">Inscripción Exitosa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Te has inscrito correctamente!!!
                    <% if (currentSession.getAttribute("numAcompanantes") != null) { %>
                    <p>Número de acompañantes: <%= currentSession.getAttribute("numAcompanantes") %></p>
                    <% } %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Aceptar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Script de Bootstrap -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Mostrar el modal si la inscripción fue exitosa
    <%
        if (currentSession.getAttribute("inscripcionExitosa") != null && (int) currentSession.getAttribute("inscripcionExitosa") == 1) {
    %>
    var inscripcionModal = new bootstrap.Modal(document.getElementById('inscripcionModal'), {
        keyboard: false
    });
    inscripcionModal.show();
    <%
        currentSession.removeAttribute("inscripcionExitosa");
        currentSession.removeAttribute("numAcompanantes");
    }
    %>
</script>
    <script>
        //listaincidencias//
        function detallesUsuario(id) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%=request.getContextPath()%>/VecinoIndexServlet?action=editar';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'id';
            input.value = id;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
        //listaincidencias//
        function listaIncidencias(id) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%=request.getContextPath()%>/IncidenciaServlet?action=lista3';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'idUsuario';
            input.value = id;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
        //vercalendario//
        function verCalendario(id) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%=request.getContextPath()%>/EventoServlet?action=calendario';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'idUsuario';
            input.value = id;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
        //historail eventos//
        function historialEventos(id) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%=request.getContextPath()%>/EventoServlet?action=listaEventosVecino';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'idUsuario';
            input.value = id;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>

