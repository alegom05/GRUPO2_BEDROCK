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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles de Incidencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Detalles de Incidencia</h2>
    <div class="card">
        <div class="card-header">
            <h4>Incidencia: <%= incidencia.getNombreIncidencia() %></h4>
        </div>
        <div class="card-body">
            <p><strong>Tipo de Incidencia:</strong> <%= incidencia.getTipoIncidencia() %></p>
            <p><strong>Fecha:</strong> <%= incidencia.getFechaIncidencia() %></p>
            <p><strong>Lugar:</strong> <%= incidencia.getLugar() %></p>
            <p><strong>Descripción:</strong> <%= incidencia.getDescripcion() %></p>
            <p><strong>Estado:</strong> <%= incidencia.getEstadoIncidencia() %></p>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/Incidencias?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="btn btn-secondary mt-4">Volver a la lista de incidencias</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

