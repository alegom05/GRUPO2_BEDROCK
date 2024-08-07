<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="style-Vecino.css" rel="stylesheet">
        <title>Formulario de Incidencia</title>
    </head>
    <body >
        <div class="ParteSuperior">
            <div class="row">
                <div class="col-md-3 d-flex justify-content-start align-items-center">
                    <img src="../logos-Vecino/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
                    <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
                </div>
                <div class="col-md-9 d-flex align-items-center justify-content-end">
                    <a href="<%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=<%=usuarioSesion.getId()%>">
                        <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
                    </a>
                    <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Alexander Velez</h2>
                    <a href="logIN.html">
                        <img src="../logos-Vecino/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
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
                        <a href="HistorialDeEventos.jsp" class="nav-link">Historial De Eventos</a>
                    </li>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="contenedor-v2">
            <div class="contenedor"><h2 class="labelFormulario contenedor mt-3">Formulario de Incidencia</h2></div>
            <div class="contenedor mt-3 mb-1 ms-4">
                <form class="row align-items-start needs-validation" novalidate>
                    <div class="col">
                        <div class="row">
                            <div class="mb-3">
                                <label for="nombreIncidencia" class="form-label">Nombre de la Incidencia: </label>
                                <input type="text" id="nombreIncidencia" class="form-control" placeholder="" required>
                                <div class="valid-feedback">
                                    Todo correcto
                                </div>
                                <div class="invalid-feedback">
                                    Es necesario poner el nombre de la incidencia
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="mb-3">
                                <label for="lugarIncidencia" class="form-label">Lugar</label>
                                <input type="text" id="lugarIncidencia" class="form-control" placeholder="" required>
                                <div class="valid-feedback">
                                    Todo correcto
                                </div>
                                <div class="invalid-feedback">
                                    Es necesario poner el lugar donde ocurrió el lugar
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="mb-3">
                                <label for="referencia" class="form-label">Referencia</label>
                                <input type="text" id="referencia" class="form-control" placeholder="" required>
                                <div class="valid-feedback">
                                    Todo correcto
                                </div>
                                <div class="invalid-feedback">
                                    Es necesario poner la referencia del lugar del suceso
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="mb-3">
                                <label for="tipo" class="form-label" style=" margin-right: 15px;">Tipo de Incidencia:</label>
                                <select id="tipo" name="tipo" required>
                                    <option value="accidente">Accidente</option>
                                    <option value="alteración_del_orden">Alteracion del orden público</option>
                                    <option value="robo">Robo agravado</option>
                                    <option value="emergencia_medica">Emergencia Médica</option>
                                    <!-- Agrega más opciones según necesites -->
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="mb-3">
                                <label for="contacto" class="form-label">Contacto (opcional): </label>
                                <input type="text" id="contacto" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="row">
                            <div class="mb-3">
                                <label for="ambulancia" class="form-label" style=" margin-right: 15px;">¿Requiere Ambulancia?</label>
                                <select id="ambulancia" name="ambulancia" required>
                                    <option value="si">Sí</option>
                                    <option value="no">No</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col me-4">
                        <div class="row mb-3">
                            <label for="imagen" class="form-label">Subir Imagen:</label>
                            <input type="file" id="imagen" class="form-control" accept="image/*">
                        </div>
                        <div class="row mb-3">
                            <label for="descripcion" class="form-label">Descripción:</label>
                            <textarea id="descripcion" class="form-control" rows="10" placeholder="Escribe una descripción detallada aquí..." required style="resize: none;"></textarea>
                            <div class="valid-feedback">
                                Todo correcto
                            </div>
                            <div class="invalid-feedback">
                                Es necesario proporcionar una descripción.
                            </div>
                        </div>
                    </div>
                    <div>
                        <button type="submit" class="btn btn-primary" id="boton">Confirmar</button>
                    </div>
                </form>
                <div id="successMessage" class="text-success text-center mt-2" style="display: none; margin-right: 10px;"></div>
            </div>
        </div>
        <script>
            (() => {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                const forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        event.preventDefault(); // Evitar la recarga de la página
                        if (!form.checkValidity()) {
                            event.stopPropagation()
                        } else {
                            const successMessage = document.getElementById('successMessage');
                            successMessage.textContent = 'El formulario se ha enviado correctamente.';
                            successMessage.style.display = 'block';
                            setTimeout(() => {
                                successMessage.style.display = 'none';
                            }, 3000); // El mensaje se ocultará después de 2 segundos (5000 milisegundos)
                        }
                        form.classList.add('was-validated');
                    }, false)
                })
            })()
            function mostrarMensaje(mensaje, tipo) {
                const mensajeDiv = document.getElementById('mensaje');
                mensajeDiv.textContent = mensaje;

                if (tipo === 'error') {
                    mensajeDiv.classList.add('error');
                } else {
                    mensajeDiv.classList.remove('error');
                }

                mensajeDiv.style.display = 'block';

                setTimeout(() => {
                    mensajeDiv.style.display = 'none';
                }, 3000);
            }

            // Validar que solo se ingresen letras en los campos de nombre y apellido
            document.addEventListener("input", function(event) {
                if (event.target && event.target.id && (event.target.id.startsWith("nombreIncidencia"))) {
                    event.target.value = event.target.value.replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ\s]/g, "");
                }
            });

            // Validar que solo se ingresen números en el campo de DNI
            document.addEventListener("input", function(event) {
                if (event.target && event.target.id && event.target.id.startsWith("contacto")) {
                    let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
                    if (value.length > 9) {
                        value = value.slice(0, 9); // Limitar a 8 dígitos
                    }
                    event.target.value = value;
                }
            });


        </script>
    </body>
</html>
