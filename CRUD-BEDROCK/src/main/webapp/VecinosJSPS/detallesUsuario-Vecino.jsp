<%@ page import="com.example.grupo2.Beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="request" type="com.example.grupo2.Beans.Usuario"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JuntosPorSanMiguel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/VecinosJSPS/style-Vecino.css" rel="stylesheet">
    </head>
    <body>
        <div class="ParteSuperior" style="overflow-x: hidden">
            <div class="row">
                <div class="col-md-3 d-flex justify-content-start align-items-center">
                    <img src="${pageContext.request.contextPath}/logos-Vecino/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
                    <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
                </div>
                <div class="col-md-9 d-flex align-items-center justify-content-end">
                    <a href="<%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=<%=usuarioSesion.getId()%>">
                        <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
                    </a>
                    <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%></h2>
                    <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                        <img src="${pageContext.request.contextPath}/logos-Vecino/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
                    </a>
                </div>
            </div>
            <nav class="letra_botones_encabezado">
                <ul class="nav">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/VecinoIndexServlet" class="nav-link">Municipalidad</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/EventoServlet?action=listarEventoFiltrado" class="nav-link">Eventos</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=formCrear" class="nav-link">Reportar Incidencia</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=lista3&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/EventoServlet?action=calendario&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Mira Tu Calendario!</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/EventoServlet?action=listaEventosVecino&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Historial De Eventos</a>
                    </li>
                </ul>
            </nav>
        </div>

        <div class="contenedor-v2">
            <div class="contenedor">
                <h2 class="labelFormulario contenedor mt-3">Información de Usuario</h2>
            </div>
            <div class="contenedor mt-3 mb-1 ms-4">
                <div class="row">
                    <div class="col-md-4">
                        <fieldset disabled>
                            <div>
                                <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">Nombre</label>
                                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getNombre()%>">
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-4">
                        <fieldset disabled>
                            <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">Apellido</label>
                            <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getApellido()%>">
                        </fieldset>
                    </div>
                    <div class="col-md-4">
                        <fieldset disabled>
                            <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">DNI</label>
                            <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=usuarioSesion.getDni()%>">
                        </fieldset>
                    </div>


                </div>
                <form class="row align-items-start needs-validation" method="post" action="<%=request.getContextPath()%>/VecinoIndexServlet?action=actualizarDatos" novalidate>
                    <div>
                        <input type="hidden" name="id" class="form-control" value="<%=usuarioSesion.getId()%>">
                    </div>
                    <div class="col me-4">
                        <div>
                            <label for="urbanizacionInput" class="form-label" style="margin-top: 10px;">Urbanización</label>
                            <div class="input-group">
                                <input type="text" id="urbanizacionInput" class="form-control" name="urbanizacionInput" placeholder="<%=usuarioSesion.getUrbanizacion()%>" value="<%=usuarioSesion.getUrbanizacion()%>">
                                <button class="btn btn-outline-secondary" type="button" onclick="enableField('urbanizacionInput')">
                                    <img src="${pageContext.request.contextPath}/assets/icons/pencil.svg" width="20" height="20">
                                </button>
                            </div>
                        </div>
                        <div>
                            <label for="disabledTextInput" class="form-label" style="margin-top: 10px;">Contraseña</label>
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="************" aria-describedby="button-addon2" disabled>
                                <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#passwordModal">
                                    <img src="${pageContext.request.contextPath}/assets/icons/pencil.svg" width="20" height="20">
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col me-4">
                        <div>
                            <label for="direccionInput" class="form-label" style="margin-top: 10px;">Dirección</label>
                            <div class="input-group">
                                <input type="text" id="direccionInput" class="form-control" name="direccionInput" placeholder="<%=usuarioSesion.getDireccion()%>" value="<%=usuarioSesion.getDireccion()%>">
                                <button class="btn btn-outline-secondary" type="button" onclick="enableField('direccionInput')">
                                    <img src="${pageContext.request.contextPath}/assets/icons/pencil.svg" width="20" height="20">
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col me-4">
                        <div>
                            <label for="telefonoInput" class="form-label" style="margin-top: 10px;">Teléfono</label>
                            <div class="input-group">
                                <input type="text" id="telefonoInput" class="form-control" name="telefonoInput" placeholder="<%=usuarioSesion.getNumtelefono()%>" value="<%=usuarioSesion.getNumtelefono()%>" oninput="validatePhoneInput(this)">
                                <button class="btn btn-outline-secondary" type="button" onclick="enableField('telefonoInput')">
                                    <img src="${pageContext.request.contextPath}/assets/icons/pencil.svg" width="20" height="20">
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col text-center">
                            <button class="btn btn-primary mt-3" type="submit">Guardar Cambios</button>
                            <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#solicitudModal">
                                Solicitud de coordinadora
                            </button>

                        </div>
                    </div>
                </form>
                <div id="successMessage" class="text-success text-center mt-2" style="display: none; margin-right: 10px;"></div>
            </div>
        </div>
        <!-- Modal de solicitud de coordinadora -->
        <div class="modal fade" id="solicitudModal" tabindex="-1" aria-labelledby="solicitudModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="solicitudModalLabel">Confirmación de Solicitud</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form  method="POST" action="<%=request.getContextPath()%>/VecinoIndexServlet?action=enviarSolicitud&id=<%=usuarioSesion.getId()%>">
                            <div class="modal-body">
                                <p>Su solicitud será enviada al administrador de la página. ¿Está seguro que desea continuar?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Aceptar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para el cambio de contraseña-->
        <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="passwordModalLabel">Cambiar Contraseña</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="changePasswordForm" method="POST" action="<%=request.getContextPath()%>/VecinoIndexServlet?action=cambiarContraVeci&id=<%=usuarioSesion.getId()%>">
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script>
            document.getElementById('changePasswordForm').onsubmit = function(event) {
                var oldPassword = document.getElementById('oldPassword').value;
                var newPassword = document.getElementById('newPassword').value;
                var confirmNewPassword = document.getElementById('confirmNewPassword').value;

                // Validar que la nueva contraseña no sea la misma que la actual
                if (oldPassword === newPassword) {
                    alert('La nueva contraseña no puede ser la misma que la actual.');
                    event.preventDefault(); // Prevenir el envío del formulario
                    return false;
                }

                // Validar que la nueva contraseña coincida con la confirmación
                if (newPassword !== confirmNewPassword) {
                    alert('La confirmación de la nueva contraseña no coincide.');
                    event.preventDefault(); // Prevenir el envío del formulario
                    return false;
                }

                return true; // Permitir el envío del formulario
            };
        </script>
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

