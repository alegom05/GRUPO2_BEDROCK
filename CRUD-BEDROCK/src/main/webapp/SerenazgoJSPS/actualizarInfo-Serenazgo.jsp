<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 00:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Actualizar información</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style-Serenazgo.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="../assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h4 style="margin-top: 10px; margin-right: 40px; text-align: right; "><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%></h4>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="../assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="paginaPrincipal-Serenazgo.jsp" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=estadisticalizar" class="nav-link"> Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="actualizarInfo-Serenazgo.jsp" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/IncidenciaServlet" class="nav-link">Incidencias</a>
            </li>
        </ul>
    </nav>
</div>

<div class="container">
    <h4 class="labelFormulario">Actualizar información</h4>
    <form class="row align-items-start">
        <div class="col">
            <fieldset disabled>

                <div class="mb-3">

                    <label for="disabledTextInput" class="form-label">Nombre</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= usuarioSesion.getNombre()%>">

                    <label for="disabledTextInput" class="form-label">Fecha de nacimiento</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getFechaNacimiento()%>">

                    <label for="disabledTextInput" class="form-label">Tipo</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getTipo()%>">

                </div>
            </fieldset>

            <div class="mb-3">

                <button type="submit" class="btn gradient-custom-3" id="btnEnvio">Guardar</button>


            </div>
        </div>

        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput" class="form-label">Apellido</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getApellido()%>">

                <label for="disabledTextInput" class="form-label">Dirección</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getDireccion()%>">


            </fieldset>

            <div class="mb-3" style="margin-top: 10px;">
                <label for="enabledTextInput" class="form-label">Teléfono</label>
                <input type="text" id="enabledTextInput" class="form-control" value="<%=usuarioSesion.getNumtelefono()%>">


            </div>


        </div>
        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput" class="form-label">DNI</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getDni()%>">

                <label for="disabledTextInput" class="form-label">Turno</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getTurnoSerenazgo()%>">

                <label for="disabledTextInput" class="form-label">Contraseña</label>

            </fieldset>
            <div class="mb-3" >
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="*************" aria-describedby="button-addon2"  disabled>
                    <a href="cambiarContra-Serenazgo.jsp" class="btn btn-outline-secondary" type="button" id="button-addon2" > <img src="../assets/icons/pencil.svg"></a>
                </div>

            </div>
        </div>

    </form>

</div>

</body>
</html>
