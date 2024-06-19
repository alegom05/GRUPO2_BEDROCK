<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>InfoUsuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="./index.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="./logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="DetallesUsuario.html">
                <img src="./logos/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Alexander Velez</h2>
            <a href="logIN.html">
                <img src="./logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/VecinoIndexServlet" class="nav-link">Municipalidad</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EventoServlet?action=eventos" class="nav-link">Eventos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=formCrear" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=lista3&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EventoServlet?action=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="HistorialDeEventos.jsp" class="nav-link">Historial De Eventos</a>
            </li>
        </ul>
    </nav>
</div>

<div class="contenedor-v2">
    <div class="contenedor">
        <h2 class="labelFormulario contenedor mt-3">Información de Usuario</h2>
    </div>
    <div class="contenedor mt-3 mb-1 ms-4">
        <form class="row align-items-start needs-validation" novalidate>
            <div class="col">
                <fieldset disabled>
                    <div>
                        <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">Nombre</label>
                        <input type="text" id="disabledTextInput" class="form-control" placeholder="Alexander">
                    </div>
                </fieldset>
                <div>
                    <label for="urbanizacionInput" class="form-label" style="margin-top: 10px;">Urbanización</label>
                    <div class="input-group">
                        <input type="text" id="urbanizacionInput" class="form-control" placeholder="Recidencial San Miguel" disabled>
                        <button class="btn btn-outline-secondary" type="button" onclick="enableField('urbanizacionInput')">
                            <img src="./logos/pencil.png" width="20" height="20">
                        </button>
                    </div>
                </div>
                <div>
                    <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">Contraseña</label>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="*************" aria-describedby="button-addon2" disabled>
                        <a href="changePsw.html" class="btn btn-outline-secondary" type="button" id="button-addon2">
                            <img src="./logos/pencil.png" width="20" height="20">
                        </a>
                    </div>
                </div>
            </div>
            <div class="col me-4">
                <fieldset disabled>
                    <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">Apellido</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="Velez Torres">
                </fieldset>
                <div>
                    <label for="direccionInput" class="form-label" style="margin-top: 10px;">Dirección</label>
                    <div class="input-group">
                        <input type="text" id="direccionInput" class="form-control" placeholder="Av. Lima 671, San Miguel 15086" disabled>
                        <button class="btn btn-outline-secondary" type="button" onclick="enableField('direccionInput')">
                            <img src="./logos/pencil.png" width="20" height="20">
                        </button>
                    </div>
                </div>
            </div>
            <div class="col me-4">
                <fieldset disabled>
                    <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">DNI</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="73216821">
                </fieldset>
                <div>
                    <label for="telefonoInput" class="form-label" style="margin-top: 10px;">Teléfono</label>
                    <div class="input-group">
                        <input type="text" id="telefonoInput" class="form-control" placeholder="" disabled oninput="validatePhoneInput(this)">
                        <button class="btn btn-outline-secondary" type="button" onclick="enableField('telefonoInput')">
                            <img src="./logos/pencil.png" width="20" height="20">
                        </button>
                    </div>
                </div>
            </div>
        </form>
        <button class="btn btn-primary mt-3" onclick="saveChanges()">Guardar Cambios</button>
        <div id="successMessage" class="text-success text-center mt-2" style="display: none; margin-right: 10px;"></div>
    </div>
</div>

<script>
    function enableField(fieldId) {
        document.getElementById(fieldId).disabled = false;
    }

    function validatePhoneInput(input) {
        input.value = input.value.replace(/[^0-9]/g, '').substring(0, 8);
    }

    function saveChanges() {
        // Aquí puedes agregar el código para guardar los cambios

        // Deshabilita los campos editados
        const fieldsToDisable = ['urbanizacionInput', 'direccionInput', 'telefonoInput'];
        fieldsToDisable.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (!field.disabled) {
                field.disabled = true;
            }
        });

        // Muestra el mensaje de éxito
        const successMessage = document.getElementById('successMessage');
        successMessage.textContent = '¡Cambios guardados exitosamente!';
        successMessage.style.display = 'block';

        // Oculta el mensaje de éxito después de 3 segundos
        setTimeout(() => {
            successMessage.style.display = 'none';
        }, 3000);
    }
</script>
</body>
</html>
