<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page import="com.example.grupo2.daos.EventoDao" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%
    // Retrieve event ID from request parameter
    String eventId = request.getParameter("id");
    EventoDao eventoDao = new EventoDao();
    Evento evento = eventoDao.obtenerEventoPorId(eventId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar información</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/VecinosJSPS/style-Vecino.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 class="main-logo-size" style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="${pageContext.request.contextPath}/VecinosJSPS/detallesUsuario-Vecino.jsp">
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
                <a href="<%=request.getContextPath()%>/EventoServlet?action=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/EventoServlet?action=listaEventosVecino&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Historial De Eventos</a>
            </li>
        </ul>
    </nav>
</div>
<div class="contenedor"><h2 class="labelFormulario contenedor mt-4">Inscripción a un evento</h2></div>
<div class="container mt-4 mb-4">
    <form method="POST" action="<%=request.getContextPath()%>/EventoServlet?action=inscribirse" class="row align-items-start needs-validation" novalidate>
        <h4 class="labelFormulario">Persona a inscribirse</h4>
        <div class="row">
            <input type="hidden" name="IDusuario" value="${IDusuario}">
            <input type="hidden" name="IDevento" value="${IDevento}">
            <div class="col">
                <div class="mb-3">
                    <label for="nombrePersona" class="form-label">Nombre</label>
                    <input type="text" id="nombrePersona" name="nombrePersona" class="form-control" placeholder="<%= usuarioSesion.getNombre() %>" value="<%= usuarioSesion.getNombre() %>" disabled>
                </div>
            </div>

            <div class="col">
                <div class="mb-3">
                    <label for="apellidoPersona" class="form-label">Apellido</label>
                    <input type="text" id="apellidoPersona" name="apellidoPersona" class="form-control" placeholder="<%= usuarioSesion.getApellido() %>" value="<%= usuarioSesion.getApellido() %>" disabled>
                </div>
            </div>
            <div class="col">
                <div class="mb-3">
                    <label for="dniPersona" class="form-label">DNI</label>
                    <input type="text" id="dniPersona" name="dniPersona" class="form-control" placeholder="<%= usuarioSesion.getDni() %>" value="<%= usuarioSesion.getDni() %>" disabled>
                </div>
            </div>
        </div>
        <div id="acompanantesContainer">
            <!-- Acompañante 1 -->
            <div class="mt-2">
                <h4 class="labelFormulario">Acompañante 1</h4>
                <div class="row align-items-start">
                    <div class="col">
                        <div class="mb-3">
                            <label for="nombreAcomp1" class="form-label">Nombre</label>
                            <input type="text" id="nombreAcomp1" name="nombreAcomp1" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col">
                        <div class="mb-3">
                            <label for="apellidoAcomp1" class="form-label">Apellido</label>
                            <input type="text" id="apellidoAcomp1" name="apellidoAcomp1" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col">
                        <div class="mb-3">
                            <label for="dniAcomp1" class="form-label">DNI</label>
                            <input type="text" id="dniAcomp1" name="dniAcomp1" class="form-control" placeholder="">
                        </div>
                    </div>
                </div>
            </div>
            <!-- Acompañante 2 -->
            <div class="mt-2">
                <h4 class="labelFormulario">Acompañante 2</h4>
                <div class="row align-items-start">
                    <div class="col">
                        <div class="mb-3">
                            <label for="nombreAcomp2" class="form-label">Nombre</label>
                            <input type="text" id="nombreAcomp2" name="nombreAcomp2" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col">
                        <div class="mb-3">
                            <label for="apellidoAcomp2" class="form-label">Apellido</label>
                            <input type="text" id="apellidoAcomp2" name="apellidoAcomp2" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col">
                        <div class="mb-3">
                            <label for="dniAcomp2" class="form-label">DNI</label>
                            <input type="text" id="dniAcomp2" name="dniAcomp2" class="form-control" placeholder="">
                        </div>
                    </div>
                </div>
            </div>
            <!-- Acompañante 3 -->
            <div class="mt-2">
                <h4 class="labelFormulario">Acompañante 3</h4>
                <div class="row align-items-start">
                    <div class="col">
                        <div class="mb-3">
                            <label for="nombreAcomp3" class="form-label">Nombre</label>
                            <input type="text" id="nombreAcomp3" name="nombreAcomp3" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col">
                        <div class="mb-3">
                            <label for="apellidoAcomp3" class="form-label">Apellido</label>
                            <input type="text" id="apellidoAcomp3" name="apellidoAcomp3" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col">
                        <div class="mb-3">
                            <label for="dniAcomp3" class="form-label">DNI</label>
                            <input type="text" id="dniAcomp3" name="dniAcomp3" class="form-control" placeholder="">
                        </div>
                    </div>
                </div>
            </div>
            <h6 class="labelFormulario">Nota: Recuerde que si va a agregar Acompañantes tiene que llenar todo el campo correspondiente o no se le registrará</h6>
        </div>

        <div>
            <button type="submit" class="btn btn-primary mt-3" id="boton">Confirmar</button>
            <button type="button" class="btn btn-primary mt-3" id="boton" onclick="window.history.back()">Volver</button>
        </div>
        <div id="successMessage" class="text-success text-center mt-2" style="display: none;"></div>
    </form>
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
                    event.preventDefault(); // Evita el envío si no es válido
                    event.stopPropagation()
                } else {
                    const successMessage = document.getElementById('successMessage');
                    successMessage.textContent = 'El formulario se ha enviado correctamente.';
                    successMessage.style.display = 'block';
                    setTimeout(() => {
                        successMessage.style.display = 'none';
                    }, 3000); // El mensaje se ocultará después de 3 segundos (3000 milisegundos)
                }
                form.classList.add('was-validated');
            }, false)
        })
    })()

    let numAcomp = 0;

    function editarPersona() {
        document.getElementById("nombrePersona").disabled = false;
        document.getElementById("apellidoPersona").disabled = false;
        document.getElementById("dniPersona").disabled = false;
        document.getElementById("nombrePersona").removeAttribute("placeholder");
        document.getElementById("apellidoPersona").removeAttribute("placeholder");
        document.getElementById("dniPersona").removeAttribute("placeholder");
    }

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
        if (event.target && event.target.id && (event.target.id.startsWith("nombre") || event.target.id.startsWith("apellido"))) {
            event.target.value = event.target.value.replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ\s]/g, "");
        }
    });

    // Validar que solo se ingresen números en el campo de DNI
    document.addEventListener("input", function(event) {
        if (event.target && event.target.id && event.target.id.startsWith("dni")) {
            let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
            if (value.length > 8) {
                value = value.slice(0, 8); // Limitar a 8 dígitos
            }
            event.target.value = value;
        }
    });
</script>



</body>
</html>
