<%@ page import="com.example.grupo2.Beans.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 00:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuarioSerenazgo");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Actualizar información</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/SerenazgoJSPS/style-Serenazgo.css" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail">
            <h4 class="textoDeParteSuperiorIzquierda">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h4 class="textoDeParteSuperiorDerecha"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%></h4>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado" style="font-family: Roboto,serif">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/SerenazgoIndexServlet" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=estadisticalizar" class="nav-link"> Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Usuario?action=actualizarS&id=<%= usuarioSesion.getId() %>" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/IncidenciaServlet" class="nav-link">Incidencias</a>
            </li>
        </ul>
    </nav>
</div>

<div class="container">
    <h4 class="labelFormulario">Actualizar información</h4>
    <form class="row align-items-start" method="post" action="<%=request.getContextPath()%>/Usuario?action=actualizarSe">
        <div class="mb-3">
            <input type="hidden" class="form-control" name="serenazgoId" value="<%=usuarioSesion.getId()%>">
        </div>
        <div class="col">
            <fieldset disabled>

                <div class="mb-3">

                    <label for="disabledTextInput" class="form-label">Nombre</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= usuario.getNombre()%>">

                    <label for="disabledTextInput" class="form-label">Fecha de nacimiento</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuario.getFechaNacimiento()%>">

                    <label for="disabledTextInput" class="form-label">Tipo</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuario.getTipo()%>">

                </div>
            </fieldset>

            <div class="mb-3">

                <button type="submit" class="btn gradient-custom-3" id="btnEnvio">Guardar</button>


            </div>
        </div>

        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput" class="form-label">Apellido</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuario.getApellido()%>">

                <label for="disabledTextInput" class="form-label">Dirección</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuario.getDireccion()%>">


            </fieldset>

            <div class="mb-3" style="margin-top: 10px;">
                <label for="numTelefono" class="form-label">Teléfono</label>
                <input type="text" id="numTelefono" class="form-control" name="numTelefono" value="<%=usuario.getNumtelefono()%>">


            </div>


        </div>
        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput" class="form-label">DNI</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuario.getDni()%>">

                <label for="disabledTextInput" class="form-label">Turno</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuario.getTurnoSerenazgo()%>">

                <label for="disabledTextInput" class="form-label">Contraseña</label>

            </fieldset>
            <div class="mb-3" >
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="*************" aria-describedby="button-addon2"  disabled>
                    <a href="cambiarContra-Serenazgo.jsp" class="btn btn-outline-secondary" type="button" id="button-addon2" > <img src="${pageContext.request.contextPath}/assets/icons/pencil.svg"></a>
                </div>

            </div>
        </div>
    </form>

</div>

</body>
</html>
