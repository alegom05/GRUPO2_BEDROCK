<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page import="com.example.grupo2.Beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%  Evento evento = (Evento) request.getAttribute("evento");%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Evento</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
</head>
<body style="height: 100vh; margin: 0;">
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" >
            <h4 class="main-logo-size" style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="DetallesUsuario.html">
                <img src="../logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <h3 style="margin-top: 10px; margin-right: 40px; text-align: right;"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br>Rol: <%=usuarioSesion.getRol()%></h3>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/logos-Vecino/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=paginaPrincipal" class="nav-link">Municipalidad</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=Eventos" class="nav-link">Eventos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Coordis?a=crearin" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=listarin&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=listarev" class="nav-link">Historial De Eventos</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=listarve" class="nav-link">Lista de Vecinos</a>
            </li>
        </ul>
    </nav>
</div>
<div id="container-evento-det" style="max-width: 80%; margin: 0 auto; margin-top: 70px;">
    <div class="row mt-3">
        <div class="contenedor mt-4 text-center">
            <h1>Crear Evento</h1>
        </div>
        <form class="row align-items-start needs-validation" novalidate>
            <div class="col-md-6 mb-3">
                <div class="contenedor mt-4 text-center">
                    <img src="./imagenes_eventos/deporte/evento1.jpg" alt="Evento" id="imagen_detallada" class="img-fluid mx-auto">
                    <div class="mt-3">
                        <label for="uploadImage" class="btn btn-primary">
                            <i class="bi bi-upload"></i> Subir Imagen
                        </label>
                        <input type="file" id="uploadImage" name="uploadImage" class="d-none" accept="image/*" required>
                        <div class="invalid-feedback">Es necesario subir una imagen para el evento.</div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 d-flex align-items-center">
                <div>
                    <div class="mt-2">
                        <div class="mb-2">
                            <label for="nombre">Nombre del Evento</label>
                            <input type="text" class="form-control" id="nombre" name="nombre"  required>
                            <div class="invalid-feedback">Es necesario poner el nombre del evento.</div>
                        </div>
                        <div class="mb-2">
                            <label for="descripcion">Detalles</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                            <div class="invalid-feedback">Es necesario poner los detalles del evento.</div>
                        </div>
                        <div class="mb-2">
                            <label for="lugar">Lugar</label>
                            <input type="text" class="form-control" id="lugar" name="lugar"  required>
                            <div class="invalid-feedback">Es necesario poner el lugar del evento.</div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="encargado">Encargado</label>
                                <input type="text" class="form-control" id="encargado" name="encargado"  required>
                                <div class="invalid-feedback">Es necesario poner el encargado del evento.</div>
                            </div>
                            <div class="col-md-auto">
                                <div class="mb-2">
                                    <label for="vacantes">Número de Vacantes</label>
                                    <input type="number" class="form-control" id="vacantes" name="vacantes" min="1"  required>
                                    <div class="invalid-feedback">Es necesario poner el número de vacantes.</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="fechaInicial">Fecha Inicio</label>
                                <input type="date" class="form-control" id="fechaInicial" name="fechaInicial"  required>
                                <div class="invalid-feedback">Es necesario poner la fecha de inicio.</div>
                            </div>
                            <div class="col">
                                <label for="fechaFinal">Fecha Fin</label>
                                <input type="date" class="form-control" id="fechaFinal" name="fechaFinal"  required>
                                <div class="invalid-feedback">Es necesario poner la fecha de fin.</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="hora">Hora</label>
                                <input type="time" class="form-control" id="hora" name="hora"  required>
                                <div class="invalid-feedback">Es necesario poner la hora del evento.</div>
                            </div>
                            <div class="col">
                                <label for="frecuencia">Frecuencia</label>
                                <select class="form-control" id="frecuencia" required>
                                    <option value="">Seleccione</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                                <div class="invalid-feedback">Es necesario seleccionar la frecuencia del evento.</div>
                            </div>
                        </div>
                        <div class="row-md-auto mt-3">
                            <label for="diasSemana">Días de la semana</label>
                            <div class="row">
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="lunes">
                                    <label class="form-check-label" for="lunes">Lunes</label>
                                </div>
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="martes">
                                    <label class="form-check-label" for="martes">Martes</label>
                                </div>
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="miercoles">
                                    <label class="form-check-label" for="miercoles">Miércoles</label>
                                </div>
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="jueves">
                                    <label class="form-check-label" for="jueves">Jueves</label>
                                </div>
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="viernes">
                                    <label class="form-check-label" for="viernes">Viernes</label>
                                </div>
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="sabado">
                                    <label class="form-check-label" for="sabado">Sábado</label>
                                </div>
                                <div class="form-check col">
                                    <input class="form-check-input" type="checkbox" id="domingo">
                                    <label class="form-check-label" for="domingo">Domingo</label>
                                </div>
                            </div>
                        </div>
                        <div class="d-grid gap-2 mt-3">
                            <button type="submit" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal" disabled>
                                Guardar
                            </button>
                            <a href="PaginaEventos.html" class="btn btn-secondary">Volver</a>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="alert alert-success mt-3 d-none" id="successMessage">Evento registrado con éxito.</div>
                                <div class="alert alert-danger mt-3 d-none" id="errorMessage">Error al registrar el evento. Por favor, inténtelo de nuevo.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Modal de confirmación -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">¿Está seguro de crear el evento?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Por favor, confirme si desea crear este evento.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="confirmButton">Confirmar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Validación de formulario
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            // Obtener todos los formularios a los que queremos aplicar estilos de validación Bootstrap personalizados
            var forms = document.getElementsByClassName('needs-validation');
            // Bucle sobre ellos y evitar el envío
            var validation = Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    } else {
                        event.preventDefault(); // Evitar el envío real del formulario
                        document.getElementById("successMessage").classList.remove("d-none");
                        document.getElementById("errorMessage").classList.add("d-none");
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Lógica del modal de confirmación
    document.getElementById('confirmButton').addEventListener('click', function () {
        // Aquí se puede redirigir a la página deseada después de confirmar
        window.location.href = "${pageContext.request.contextPath}/Coordis?a=listarev";
    });

    // Lógica de carga de imagen
    document.getElementById('uploadImage').addEventListener('change', function(event) {
        const [file] = event.target.files;
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('imagen_detallada').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Lógica para activar el botón de guardar después de que se completen todos los campos del formulario
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('form');
        const submitButton = form.querySelector('button[type="submit"]');
        const inputs = form.querySelectorAll('input, textarea, select');

        function checkFormValidity() {
            let isValid = true;
            inputs.forEach(function (input) {
                if (!input.checkValidity()) {
                    isValid = false;
                }
            });
            submitButton.disabled = !isValid;
        }

        inputs.forEach(function (input) {
            input.addEventListener('input', checkFormValidity);
        });

        form.addEventListener('submit', function (event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            } else {
                event.preventDefault(); // Evitar el envío real del formulario
                document.getElementById("successMessage").classList.remove("d-none");
                document.getElementById("errorMessage").classList.add("d-none");
            }
            form.classList.add('was-validated');
        });

        checkFormValidity(); // Comprobar la validez inicial del formulario
    });
</script>
</body>
</html>

