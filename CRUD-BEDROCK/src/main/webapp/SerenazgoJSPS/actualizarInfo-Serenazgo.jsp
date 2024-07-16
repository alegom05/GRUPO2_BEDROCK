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
                <a href="<%=request.getContextPath()%>/Sereno?action=estadisticalizarIncidencias" class="nav-link"> Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Sereno?action=actualizarS&id=<%= usuarioSesion.getId() %>" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Sereno?action=listaIncidencias" class="nav-link">Incidencias</a>
            </li>
        </ul>
    </nav>
</div>

<div class="container">
    <h4 class="labelFormulario">Actualizar información</h4>
    <form class="row align-items-start" method="post" action="<%=request.getContextPath()%>/Sereno?action=actualizarSe">
        <div class="mb-3">
            <input type="hidden" class="form-control" name="serenazgoId" value="<%=usuarioSesion.getId()%>">
        </div>
        <div class="col">
            <fieldset disabled>

                <div class="mb-3">

                    <label for="disabledTextInput1" class="form-label">Nombre</label>
                    <input type="text" id="disabledTextInput1" class="form-control" placeholder="<%= usuario.getNombre()%>">

                    <label for="disabledTextInput2" class="form-label">Fecha de nacimiento</label>
                    <input type="text" id="disabledTextInput2" class="form-control" placeholder="<%=usuario.getFechaNacimiento()%>">

                    <label for="disabledTextInput3" class="form-label">Tipo</label>
                    <input type="text" id="disabledTextInput3" class="form-control" placeholder="<%=usuario.getTipo()%>">

                </div>
            </fieldset>

            <div class="mb-3">

                <button type="submit" class="btn gradient-custom-3" id="btnEnvio">Guardar</button>


            </div>
        </div>

        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput4" class="form-label">Apellido</label>
                <input type="text" id="disabledTextInput4" class="form-control" placeholder="<%=usuario.getApellido()%>">

                <label for="disabledTextInput5" class="form-label">Dirección</label>
                <input type="text" id="disabledTextInput5" class="form-control" placeholder="<%=usuario.getDireccion()%>">


            </fieldset>

            <div class="mb-3" style="margin-top: 10px;">
                <label for="numTelefono" class="form-label">Teléfono</label>
                <input type="text" id="numTelefono" class="form-control" name="numTelefono" value="<%=usuario.getNumtelefono()%>">
                <div id="telefonoAdvertencia" class="form-text text-danger" style="display: none;">
                    Se debe ingresar un número de 9 dígitos.
                </div>

            </div>


        </div>
        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput6" class="form-label">DNI</label>
                <input type="text" id="disabledTextInput6" class="form-control" placeholder="<%=usuario.getDni()%>">

                <label for="disabledTextInput7" class="form-label">Turno</label>
                <input type="text" id="disabledTextInput7" class="form-control" placeholder="<%=usuario.getTurnoSerenazgo()%>">

                <label  class="form-label">Contraseña</label>

            </fieldset>
            <div class="mb-3" >
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="*************" aria-describedby="button-addon2" disabled >
                    <button   type="button" class="btn btn-outline-secondary"  data-bs-toggle="modal" data-bs-target="#passwordModal" > <img src="${pageContext.request.contextPath}/assets/icons/pencil.svg"></button>
                </div>
            </div>
        </div>
    </form>

    <!-- Modal para el cambio de contraseña-->
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="passwordModalLabel">Cambiar Contraseña</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="changePasswordForm" method="POST" action="<%=request.getContextPath()%>/Sereno?action=cambiarContrasenia&id=<%=usuarioSesion.getId()%>">
                        <div class="mb-3">
                            <label for="oldPassword" class="form-label">Contraseña antigua</label>
                            <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Nueva Contraseña</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Confirmar Nueva Contraseña</label>
                            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar cambios</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


</div>

<script>
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id && event.target.id.startsWith("numTelefono")) {
            let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
            if (value.length > 9) {
                value = value.slice(0, 9);
            }
            event.target.value = value;

            const btnEnvio = document.getElementById('btnEnvio');
            const telefonoAdvertencia = document.getElementById('telefonoAdvertencia');

            // Habilitar o deshabilitar el botón de envío según la longitud del número de teléfono
            if (value.length === 9) {
                btnEnvio.disabled = false;
                telefonoAdvertencia.style.display = 'none';
            } else {
                btnEnvio.disabled = true;
                telefonoAdvertencia.style.display = 'block';
            }
        }
    });

    // Inicialmente deshabilitar el botón si el campo de teléfono no tiene 9 cifras
    document.addEventListener("DOMContentLoaded", function() {
        const numTelefono = document.getElementById('numTelefono');
        const btnEnvio = document.getElementById('btnEnvio');
        const telefonoAdvertencia = document.getElementById('telefonoAdvertencia');

        if (numTelefono.value.length !== 9) {
            btnEnvio.disabled = true;
            telefonoAdvertencia.style.display = 'block';
        } else {
            telefonoAdvertencia.style.display = 'none';
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>




</body>
</html>
