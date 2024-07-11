<%--
  Created by IntelliJ IDEA.
  User: alexm
  Date: 6/25/2024
  Time: 1:29 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%
    Incidencia incidencia = (Incidencia) request.getAttribute("incidencia");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--> <!--con esto se habilita para que sea apto tanto en el buscador edge como chrome-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior" style="overflow-x: hidden">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br>Rol: <%=usuarioSesion.getRol()%></h2>
            <a href="logIN.html">
                <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/CoordinadoraIndexServlet" class="nav-link">Municipalidad</a>
            </li>

            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Coordis?action=formCrearIncidencia" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listaEventos" class="nav-link">Historial De Eventos</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listarve" class="nav-link">Lista de Vecinos</a>
            </li>
        </ul>
    </nav>
</div>
<div class="contenedor mt-4 text-center">
    <h2>Detalles de incidencia</h2>
</div>
<div id="container-evento-det" style="max-width: 80%; margin: 0 auto; margin-top: 70px;">
    <div class="row mt-3">

        <div class="col-md-6 mb-3 text-center">
            <div class="contenedor mt-4 text-center" style="max-width: 600px; margin: 0 auto; font-family:Cambria ,Garamond;">
                <% if (incidencia != null) { %>
                <h1><%= incidencia.getNombreIncidencia() %></h1>

                <div class="contenedor mt-4" >
                    <img src="<%= request.getContextPath()%>/imagenIncidencia?id=<%= incidencia.getIdIncidencia()%>" alt="Incidencia" id="imagen_detallada" class="img-fluid mx-auto">
                </div>
            </div>
        </div>
        <div class="col-md-6 d-flex align-items-center">
            <div >
                <div class="mt-5">
                    <div  class="elemento_texto_evento ajustar">
                        <h4><strong>Descripción:</strong> <%= incidencia.getDescripcion() %></h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4><strong>Lugar:</strong> <%= incidencia.getLugar() %></h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4><strong>Fecha:</strong> <%= incidencia.getFechaIncidencia() %></h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4><strong>Tipo de Incidencia:</strong> <%= incidencia.getTipoIncidencia() %></h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4><strong>Estado:</strong> <%= incidencia.getEstadoIncidencia() %></h4>
                    </div>
                </div>
                <% } else { %>
                <p>Error: Incidencia no encontrada.</p>
                <% } %>

            </div>
        </div>
        <a href="${pageContext.request.contextPath}/Coordis?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="btn btn-secondary mt-4">Volver a la lista de incidencias</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
<!--  para implementar en el jsp para casos cuando por algun tipo de error no se puede obtener el detalle de esa incidencia en especifico
%
    if (incidencia != null) {
%>
<h4>Incidencia: %= incidencia.getNombreIncidencia() %></h4>
<div class="card-body">
    <p><strong>Tipo de Incidencia:</strong> %= incidencia.getTipoIncidencia() %></p>
    <p><strong>Fecha:</strong> %= incidencia.getFechaIncidencia() %></p>
    <p><strong>Lugar:</strong> %= incidencia.getLugar() %></p>
    <p><strong>Descripción:</strong> %= incidencia.getDescripcion() %></p>
    <p><strong>Estado:</strong> %= incidencia.getEstadoIncidencia() %></p>
</div>
%
    } else {
        out.println("<p>Error: Incidencia no encontrada.</p>");
    }
%>
-->


<!--<div class="" id="container-evento-det">
    <div class="row mt-4 mx-auto" style="width: 100%; height: 100%;">
        <div class="col-md-6 mb-3 ">
            <div class="contenedor mt-4 text-center">
                <h1> Fútbol juvenil</h1>
            </div>
            <div class="contenedor mt-4">
                <img src="./imagenes_eventos/deporte/evento2.jpg" alt="Evento" id="imagen_detallada" class="img-fluid mx-auto">
            </div>
        </div>

        <div class="col-md-6 d-flex align-items-center">
            <div>
                <div class="mt-10" >
                    <div class="elemento_texto_evento">
                        <h4>Lugar: Complejo deportivo Julio Melendez</h4>

                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Fecha: 01/10/2025</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Hora: 9:00 AM</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Coordinador: Roberto Rodriguez Argumedo</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Número de Vacantes Totales: 30</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Requisitos: Ninguno</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Descripción:</h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <h4>Un día de futbol para jovenes menores de 16 años.</h4>
                        <h4>Ven y aprende esta emocionante experiencia </h4>
                    </div>
                    <div class="elemento_texto_evento">
                        <a href="VecinosInscritos.html"><h4>Ver vecinos inscritos</h4></a>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>-->

</body>
</html>










