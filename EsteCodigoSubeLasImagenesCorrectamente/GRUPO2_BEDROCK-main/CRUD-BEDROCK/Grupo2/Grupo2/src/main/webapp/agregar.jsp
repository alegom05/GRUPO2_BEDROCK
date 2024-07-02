<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/06/2024
  Time: 12:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AgregarUsuario</title>
</head>
<body>
    <div>
        <h3>
            Agregar Nueva Imagen y evento
        </h3>
        <form action="EventosServlet" method="POST" enctype="multipart/form-data">
            <label>Nombre:</label>
            <input type="text" name="txtNom">
            <label>Foto:</label>
            <input type="file" name="fileFoto">
            <input type="submit" name="accion" value="Guardar">
            <input type="submit" name="accion" value="Regresar">
        </form>
    </div>
</body>
</html>
