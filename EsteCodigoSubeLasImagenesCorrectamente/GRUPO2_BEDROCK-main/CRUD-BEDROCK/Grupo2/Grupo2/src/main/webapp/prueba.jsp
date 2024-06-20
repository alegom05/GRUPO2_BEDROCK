<%@ page import="com.example.grupo2.Beans.Eventos" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ArrayList<Eventos> listaEventos = (ArrayList<Eventos>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<div>
    <form>
        <input type="submit" name="accion" value="Listar">
        <input type="submit" name="accion" value="Nuevo">
    </form>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Imagen</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (listaEventos != null) {
                for (Eventos eventos : listaEventos) {
        %>
        <tr>
            <td><%= eventos.getIdEvento() %></td>
            <td><%= eventos.getNombre() %></td>
            <td><img src="http://localhost:8080/Grupo2_war/imagenEvento?id=<%= eventos.getIdEvento() %>" alt="Imagen del evento"></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3">No hay eventos disponibles.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
