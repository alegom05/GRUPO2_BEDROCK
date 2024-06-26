<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25/06/2024
  Time: 20:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cambiar contraseña</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/VecinosJSPS/style2-Vecino.css" rel="stylesheet">
    </head>
    <body class="bodyForms">
        <div class="container" id="contenedorLOG">
            <h2>Cambiar Contraseña</h2>
            <form action="#" class="formulario-cambio-contrasena">
                <div class="mb-3">
                    <label for="old_password" class="form-label">Contraseña Antigua</label>
                    <input type="password" id="old_password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="new_password" class="form-label">Nueva Contraseña</label>
                    <input type="password" id="new_password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="confirm_password" class="form-label">Confirmar Nueva Contraseña</label>
                    <input type="password" id="confirm_password" class="form-control" required>
                </div>
                <div class="botones-cambio-contrasena">
                    <button type="submit" class="btn gradient-custom-3">Aceptar</button>
                    <a href="<%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=<%=usuarioSesion.getId()%>" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </body>

</html>

