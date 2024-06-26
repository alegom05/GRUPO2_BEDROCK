<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="serenazgo" scope="request" type="com.example.grupo2.Beans.Usuario" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar serenazgo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/AdministradorJSPS/style-Admin.css" rel="stylesheet">
    <style>
    </style>
</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/Administrador/assets/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Administrador</h2>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/Administrador/assets/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail cerrar-sesion-img">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/AdminIndexServlet" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Solicitudes" class="nav-link">Administración de solicitudes</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Serenazgos" class="nav-link">Serenazgos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Profesores" class="nav-link">Lista de profesores</a>
            </li>

        </ul>
    </nav>
</div>

<div class="col">
    <div class="card-body p-md-5 mx-md-4">

        <form class="needs-validation" style="width: 100%; margin-left: 0%; margin-top: 3%;" action="<%=request.getContextPath()%>/Serenazgos?a=actualizar" method="POST" novalidate>
            <div class="container">
                <h2>Nuevo Serenazgo</h2>
                <input type="hidden" name="id" value="<%=serenazgo.getId()%>" />
                <div class="container" style="margin-top: 3%; ">
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombres: (*)</label>
                                <input type="text" name="nombre" id="nombre" value="<%=serenazgo.getNombre()%>" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellidos: (*)</label>
                                <input type="text" name="apellido" id="apellido" class="form-control" value="<%=serenazgo.getApellido()%>" aria-describedby="emailHelp" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="dni" class="form-label" >DNI: (*)</label>
                                <input type="tel" class="form-control" name="dni" id="dni" maxlength="8" minlength="8" value="<%=serenazgo.getDni()%>" readonly>
                            </div>
                        </div>
                        <div class="col">
                            <label for="nacimiento" class="form-label">Fecha de Nacimiento: (*)</label>
                            </br>
                            <input type="date"  name="nacimiento" id="nacimiento" class="form-control" aria-describedby="emailHelp" value="<%=serenazgo.getFecha_nacimiento()%>" readonly>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Número de Teléfono: (*)</label>
                                <input type="tel" class="form-control" name="telefono" id="telefono" maxlength="9" minlength="9" placeholder="Ej: 987654321" pattern="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" value="<%=serenazgo.getNumtelefono()%>" title="ingrese su número de teléfono" required>
                                <div class="invalid-feedback">Por favor ingresar número de teléfono.</div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label for="direccion" class="form-label">Dirección: (*)</label>
                                <input type="text" name="direccion" id="direccion" placeholder="Ej: Av. ... #XXXX" pattern="[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+\s[a-zA-Z0-9#ZáéíóúÁÉÍÓÚñÑ.]+(\s[a-zA-Z0-9#ZáéíóúÁÉÍÓÚñÑ.]+)?+(\s[a-zA-Z0-9#ZáéíóúÁÉÍÓÚñÑ.]+)?" value="<%=serenazgo.getDireccion()%>"class="form-control" aria-describedby="emailHelp" required>
                                <div class="invalid-feedback">Por favor ingresar dirección.</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <div class="mb-3">
                                    <label for="tipo" class="form-label">Tipo: (*)</label><br>
                                    <select id="tipo" name="tipo" class="form-select" required>
                                        <option value="En bicicleta" <%= "En bicicleta".equals(serenazgo.getTipo()) ? "selected" : "" %>>En bicicleta</option>
                                        <option value="Con canino" <%= "Con canino".equals(serenazgo.getTipo()) ? "selected" : "" %>>Con canino</option>
                                        <option value="A pie" <%= "A pie".equals(serenazgo.getTipo()) ? "selected" : "" %>>A pie</option>
                                        <option value="Con vehículo" <%= "Con vehículo".equals(serenazgo.getTipo()) ? "selected" : "" %>>Con vehículo</option>
                                    </select>
                                    <div class="invalid-feedback">Por favor escoja una opción.</div>

                                </div>

                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label for="turno" class="form-label">Turno: (*)</label><br>
                                <select id="turno" name="turno" class="form-select" required>
                                    <option value="Mañana" <%= "Mañana".equals(serenazgo != null ? serenazgo.getTurnoSerenazgo() : "") ? "selected" : "" %>>Mañana</option>
                                    <option value="Tarde" <%= "Tarde".equals(serenazgo != null ? serenazgo.getTurnoSerenazgo() : "") ? "selected" : "" %>>Tarde</option>
                                    <option value="Noche" <%= "Noche".equals(serenazgo != null ? serenazgo.getTurnoSerenazgo() : "") ? "selected" : "" %>>Noche</option>
                                </select>
                                <div class="invalid-feedback">Por favor escoja una opción.</div>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="correo" class="form-label">Correo: (*)</label>
                                <input type="text" name="correo" id="correo" placeholder="Ej: ejemplo@gmail.com" value="<%=serenazgo.getCorreo()%>" class="form-control" aria-describedby="emailHelp" required>
                                <div class="invalid-feedback">Por favor ingresar correo.</div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label class="form-label">Contraseña: (*)</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="*************" aria-describedby="button-addon2"  disabled>
                                    <button onclick="setSerenazgoClave('<%= serenazgo.getClave() %>')" class="btn btn-outline-secondary" type="button" id="button-addon2" data-bs-toggle="modal" data-bs-target="#passwordModal">
                                     <img src="${pageContext.request.contextPath}/Administrador/assets/icons/pencil.svg">
                                        </button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn btn-primary" style="width: 280px;">Actualizar</button>
            </div>
        </form>
    </div>
</div>

    <!-- Modal -->
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="passwordModalLabel">Cambiar Contraseña</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="changePasswordForm" method="POST" action="<%=request.getContextPath()%>/Serenazgos?a=cambiarContrasenia&id=<%=serenazgo.getId()%>">
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
<!-- Incluir los archivos JavaScript de Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
    document.querySelector('.form-login').addEventListener('submit', function(event) {
        event.preventDefault(); // Evitar el envío del formulario
        window.location.href = 'serenazgos.html';
    });
</script>
<script>
    var forms = document.querySelectorAll('.needs-validation');

    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    });
    // Validar que solo se ingresen letras en los campos de nombre y apellidos
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id === "nombre") {
            event.target.value = event.target.value.replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ\s]/g, "");
        } else if (event.target && event.target.id === "apellidos") {
            event.target.value = event.target.value.replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ\s]/g, "");
        }
    });

    // Validar que solo se ingresen números en el campo de DNI
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id === "dni") {
            let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
            if (value.length > 8) {
                value = value.slice(0, 8); // Limitar a 8 dígitos
            }
            event.target.value = value;
        }
    });
    // Validar que solo se ingresen números en el campo de teléfono
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id === "telefono") {
            let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
            if (value.length > 9) {
                value = value.slice(0, 9); // Limitar a 9 dígitos
            }
            event.target.value = value;
        }
    });
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id === "direccion") {
            let pattern = /^[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+\s[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+(\s[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+)?(\s[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+)?$/;
            let value = event.target.value;
            if (!pattern.test(value)) {
                event.target.setCustomValidity("La dirección no cumple con el formato requerido.");
            } else {
                event.target.setCustomValidity("");
            }
        }
    });
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id === "correo") {
            let pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Patrón de correo
            if (!pattern.test(event.target.value)) {
                event.target.setCustomValidity("Por favor, ingrese un correo válido.");
            } else {
                event.target.setCustomValidity("");
            }
        }
    });
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id === "contrasenia") {
            // Permitir letras, números y caracteres especiales específicos
            event.target.value = event.target.value.replace(/[^a-zA-Z0-9!@#$%^&*]/g, "");
        }
    });
    let currentPassword = '';

    function setSerenazgoClave(clave) {
        currentPassword = clave;
    }

    document.addEventListener('DOMContentLoaded', function () {
        var passwordModal = document.getElementById('passwordModal');

        // Evento que se dispara cuando el modal se oculta
        passwordModal.addEventListener('hidden.bs.modal', function () {
            // Limpiar los campos de entrada de contraseña
            document.getElementById('oldPassword').value = '';
            document.getElementById('newPassword').value = '';
            document.getElementById('confirmNewPassword').value = '';
        });

    document.getElementById("changePasswordForm").addEventListener("submit", function(event) {
        event.preventDefault();

        const oldPasswordInput = document.getElementById("oldPassword");
        const newPasswordInput = document.getElementById("newPassword");
        const confirmNewPasswordInput = document.getElementById("confirmNewPassword");

        const oldPassword = oldPasswordInput.value;
        const newPassword = newPasswordInput.value;
        const confirmNewPassword = confirmNewPasswordInput.value;

        // Verificar que la contraseña antigua sea correcta
        if (oldPassword !== currentPassword) {
            Swal.fire({
                title: 'Error',
                text: 'La contraseña antigua es incorrecta.',
                icon: 'error',
                confirmButtonText: 'Aceptar'
            });
            return;
        }

        // Verificar que la nueva contraseña no sea igual a la antigua
        if (newPassword === oldPassword) {
            Swal.fire({
                title: 'Error',
                text: 'La nueva contraseña no puede ser igual a la antigua.',
                icon: 'error',
                confirmButtonText: 'Aceptar'
            });
            return;
        }

        // Verificar que la confirmación de la nueva contraseña coincida con la nueva contraseña
        if (newPassword !== confirmNewPassword) {
            Swal.fire({
                title: 'Error',
                text: 'La confirmación de la nueva contraseña no coincide.',
                icon: 'error',
                confirmButtonText: 'Aceptar'
            });
            return;
        }

        // Aquí puedes agregar la lógica para manejar el cambio de contraseña
        this.submit();
    });
    });



</script>
    <!-- Incluir SweetAlert desde un CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>