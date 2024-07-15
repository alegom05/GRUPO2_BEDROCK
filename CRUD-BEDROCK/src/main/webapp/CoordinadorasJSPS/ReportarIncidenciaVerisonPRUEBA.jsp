<%@ page import="com.example.grupo2.Beans.Incidencia" %><%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%  Incidencia incidencia = (Incidencia) request.getAttribute("incidencia");%>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
    <title>Formulario de Incidencia</title>
</head>

<body >
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="javascript:void(0)" onclick="detallesUsuario('<%=usuarioSesion.getId()%>')">
                <!--href="%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=%=usuarioSesion.getId()%>"-->
                <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <div class="usuario-info" style="margin-right: 1.2rem">
                <%
                    String tipoUsuario = usuarioSesion.getTipo();
                    String rol = "Coordinadora de " + tipoUsuario.toLowerCase();
                %>
                <h3 style=" text-align: right;">
                    <%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br><%=rol%>
                </h3>
            </div>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/logos-Vecino/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/CoordinadoraIndexServlet" class="nav-link">Municipalidad</a>
            </li>

            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Coordis?action=formCrearIncidencia" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0)" onclick="listaIncidencias('<%=usuarioSesion.getId()%>')" class="nav-link">Lista de Incidencias</a>
            </li>

            <li class="nav-item">
                <a href="javascript:void(0)" onclick="historialEventos('<%=usuarioSesion.getTipo()%>')" class="nav-link">Historial De Eventos</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listarve" class="nav-link">Lista de Vecinos</a>
            </li>
        </ul>
    </nav>
</div>



<div class="contenedor-v2">
    <div class="contenedor"><h2 class="labelFormulario contenedor mt-3">Formulario de Incidencia</h2></div>
    <div class="contenedor mt-3 mb-1 ms-4">
        <form method="post" action="<%=request.getContextPath()%>/Coordis?action=reportarIncidencia" class="row align-items-start needs-validation" novalidate enctype="multipart/form-data">
            <div class="col">
                <div class="row">
                    <div class="mb-3">
                        <label for="nombreIncidencia" class="form-label">Nombre de la Incidencia: </label>
                        <input type="text" id="nombreIncidencia" name="nombreIncidencia" class="form-control" placeholder="" required>
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
                        <input type="text" id="lugarIncidencia" name="lugarIncidencia" class="form-control" placeholder="" required>
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
                        <input type="text" id="referencia" name="referencia" class="form-control" placeholder="" required>
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
                            <option value="AC">Accidente</option>
                            <option value="AL">Alteracion del orden público</option>
                            <option value="RO">Robo agravado</option>
                            <option value="EM">Emergencia Médica</option>
                            <option value="OT">Otro</option>
                            <!-- Agrega más opciones según necesites -->
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3">
                        <label for="contacto" class="form-label">Contacto (opcional): </label>
                        <input type="text" id="contacto" name="contacto" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3">
                        <label for="ambulancia" class="form-label" style=" margin-right: 15px;">¿Requiere Ambulancia?</label>
                        <select id="ambulancia" name="ambulancia" required>
                            <option value="true">Sí</option>
                            <option value="false">No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col me-4">
                <div class="row mb-3">
                    <label for="imagen" class="form-label">Subir Imagen:</label>
                    <input type="file" id="imagen" name="imagen" class="form-control" accept="image/*">
                </div>
                <div class="row mb-3">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" class="form-control" rows="10" placeholder="Escribe una descripción detallada aquí..." required style="resize: none;"></textarea>
                    <div class="valid-feedback">
                        Todo correcto
                    </div>
                    <div class="invalid-feedback">
                        Es necesario proporcionar una descripción.
                    </div>
                </div>
                <div class="mb-3">
                    <input type="hidden" class="form-control" id="idUsuario" name="idUsuario" value="<%=usuarioSesion.getId()%>">
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

                if (!form.checkValidity()) {
                    event.preventDefault(); // Evitar la recarga de la página
                    event.stopPropagation()
                }/* else {
                    const successMessage = document.getElementById('successMessage');
                    successMessage.textContent = 'El formulario se ha enviado correctamente.';
                    successMessage.style.display = 'block';
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000); // El mensaje se ocultará después de 2 segundos (5000 milisegundos)
                }*/
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
<script>
    function establecerIdParaEliminar(idEvento) {
        document.getElementById('eventoIdParaEliminar').value = idEvento;
    }

    function confirmarEliminacion() {
        const idEvento = document.getElementById('eventoIdParaEliminar').value;
        window.location.href = '<%= request.getContextPath() %>/Coordis?action=deleteEventos&id=' + idEvento;
    }
</script>
<script>
    //detalleUusario//
    function detallesUsuario(id) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '<%=request.getContextPath()%>/CoordinadoraIndexServlet?action=editar';

        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'id';
        input.value = id;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
    //listaincidencias//
    function listaIncidencias(id) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/Coordis?action=listaCoordi';

        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'idUsuario';
        input.value = id;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
    //vercalendario//
    function verCalendario(id) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/Coordis?action=calendario';

        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'idUsuario';
        input.value = id;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
    //historail eventos//
    function historialEventos(id) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/Coordis?action=listaEventos';

        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'tipoUsuario';
        input.value = id;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>