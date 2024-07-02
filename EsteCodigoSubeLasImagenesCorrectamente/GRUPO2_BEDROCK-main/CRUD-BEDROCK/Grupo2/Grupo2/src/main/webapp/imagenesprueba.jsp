<%@ page import="com.example.grupo2.daos.EventosDao" %>
<%@ page import="com.example.grupo2.Beans.Eventos" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Eventos</title>
</head>
<body>
<h1>Lista de Eventos</h1>
<ul>
    <%
        EventosDao eventosDAO = new EventosDao();
        ArrayList<Eventos> listaeventos = eventosDAO.listarEventos();
        for (Eventos evento : listaeventos) {
    %>
    <li>
        <h2><%= evento.getNombre() %></h2>
        <img src="<%= request.getContextPath() %>/imagenEvento?id=<%= evento.getIdEvento() %>" alt="Imagen del evento">
    </li>
    <%
        }
    %>
</ul>
</body>
</html>
