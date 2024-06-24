<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 23/06/2024
  Time: 23:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Evento" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<% Evento evento = (Evento) request.getAttribute("evento");
    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior" style="overflow-x: hidden">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Gina Jimenez Villavicencio<br>Coordinadora de deporte </h2>
            <a href="logIN.html">
                <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?a=paginaPrincipal" class="nav-link">Municipalidad</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=paginaPrincipal" class="nav-link">Eventos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=formCrear2" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Incidencias?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
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
<!--<div id="container-frase" style="max-width: 80%; margin: 0 auto; margin-top: 70px; margin-bottom:10px">
    <h1>
        hola
    </h1>
</div>-->

<div id="container-evento-det" style="max-width: 80%; margin: 0 auto; margin-top: 70px;">

    <div class="row mt-3">

        <div class="contenedor mt-4 text-center">
            <h2>Detalles de evento</h2>
        </div>


        <div class="col-md-6 mb-3 ">

            <div class="contenedor mt-4">
                <img src="<%= request.getContextPath() %>/imagenEvento?id=<%= evento.getIdEvento() %>" alt="Evento" id="imagen_detallada" class="img-fluid mx-auto">

            </div>
        </div>

        <div class="col-md-6 d-flex align-items-center">
            <form>
                <div class="mt-2">
                    <div class="mb-2">
                        <label for="nombre">Nombre del Evento</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%=evento.getNombre()%>" required>
                    </div>
                    <div class="mb-2">
                        <label for="detalles">Descripción</label>
                        <textarea class="form-control" id="detalles" name="detalles" rows="3" required><%=evento.getDescripcion()%></textarea>
                    </div>
                    <div class="mb-2">
                        <label for="lugar">Lugar</label>
                        <input type="text" class="form-control" id="lugar" name="lugar" value="<%=evento.getLugar()%>>" required>
                    </div>


                    <div class="row">
                        <div class="col">
                            <label for="profesor">Encargado</label>
                            <input type="text" class="form-control" id="profesor" name="profesor" value="<%=evento.getNombreProfesor()%>">
                        </div>

                        <div class="col-md-auto">
                            <div class="mb-2">
                                <label for="vacantes">Número de Vacantes</label>
                                <input type="number" class="form-control" id="vacantes" name="vacantes" min="1" value="<%=evento.getVacantes()%>" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <label for="fechaInicio">Fecha Inicio</label>
                            <input type="date" class="form-control" id="fechaInicio" name="fechaInicio" value="<%=evento.getFechaInicial()%>" required>
                        </div>
                        <div class="col">
                            <label for="fechaFin">Fecha Fin</label>
                            <input type="date" class="form-control" id="fechaFin" name="fechaFin" value="<%=evento.getFechaFinal()%>" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <label for="hora">Hora</label>
                            <input type="time" class="form-control" id="hora" name="hora" value="<%=evento.getHora()%>" required>
                        </div>
                        <div class="col">
                            <label for="frecuenciaEvento">Frecuencia</label>
                            <select class="form-control" id="frecuenciaEvento">
                                <option value="1"<%= Integer.parseInt("1") == evento.getFrecuencia() ? "selected" : "" %>>1</option>
                                <option value="2"<%= Integer.parseInt("2") == evento.getFrecuencia() ? "selected" : "" %>>2</option>
                                <option value="3"<%= Integer.parseInt("3") == evento.getFrecuencia() ? "selected" : "" %>>3</option>
                                <option value="4"<%= Integer.parseInt("4") == evento.getFrecuencia() ? "selected" : "" %>>4</option>
                                <option value="5"<%= Integer.parseInt("5") == evento.getFrecuencia() ? "selected" : "" %>>5</option>
                            </select>
                        </div>
                    </div>

                    <div class="row-md-auto">
                        <label for="diasSemana">Días de la semana</label>
                        <div class="row">
                            <div class="form-check col">
                                <input class="form-check-input" type="checkbox" id="lunes" checked>
                                <label class="form-check-label" for="lunes">Lunes</label>
                            </div>
                            <div class="form-check col">
                                <input class="form-check-input" type="checkbox" id="martes">
                                <label class="form-check-label" for="martes">Martes</label>
                            </div>
                            <div class="form-check col">
                                <input class="form-check-input" type="checkbox" id="miercoles" checked>
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
                </div>

            </form>


        </div>
        <div class="container mt-4 text-center">
            <a href="" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">Guardar</a>
            <a href="" class="btn btn-primary" >Iniciar evento</a>
            <a href="" class="btn btn-primary" >Cerrar evento</a>
            <a href="" class="btn btn-primary" >Ver lista de participantes</a>
            <a href="${pageContext.request.contextPath}/Coordis?a=listarev" class="btn btn-primary ">Cancelar</a>
        </div>
    </div>

    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">Evento actualizado correctamente</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h5>Se actualizo el evento para los vecinos sanmiguelinos.</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn_letra_negrita" data-bs-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="nuevaModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Registrar Más Personas</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" placeholder="Ingrese el nombre">
                    </div>
                    <div class="mb-3">
                        <label for="dni" class="form-label">DNI:</label>
                        <input type="text" class="form-control" id="dni" placeholder="Ingrese el DNI">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn_letra_negrita" id="registrarPersona">Registrar</button>
                    <button type="button" class="btn btn-primary btn_letra_negrita" id="registrarOtraPersona">Registrar a otra persona</button>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="registroExitosoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Registro Exitoso</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>La persona ha sido registrada exitosamente.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="cerrarRegistroExitoso">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function soloLetras(event) {
            var inputValue = event.key;
            if (!/^[a-zA-Z\s]*$/.test(inputValue)) {
                event.preventDefault();
            }
        }
        function soloNumeros(event) {
            var inputValue = event.key;
            var dniValue = document.getElementById('dni').value;
            if (!/^\d$/.test(inputValue) || dniValue.length >= 8) {
                event.preventDefault();
            }
        }

        document.getElementById('nombre').addEventListener('keypress', soloLetras);
        document.getElementById('dni').addEventListener('keypress', soloNumeros);

        function abrirModal() {
            var modal = new bootstrap.Modal(document.getElementById('nuevaModal'));
            modal.show();
        }

        document.getElementById('abrirNuevaModal').addEventListener('click', abrirModal);

        document.getElementById('registrarPersona').addEventListener('click', function() {
            var nombre = document.getElementById('nombre').value;
            var dni = document.getElementById('dni').value;

            var nombreRegex = /^[a-zA-Z\s]*$/;
            var dniRegex = /^\d{1,8}$/;

            if (nombre.trim() === '' || dni.trim() === '') {
                alert('Por favor, complete todos los campos.');
            } else if (!nombreRegex.test(nombre)) {
                alert('El nombre solo puede contener letras y espacios.');
            } else if (!dniRegex.test(dni)) {
                alert('El DNI debe contener solo números y tener un máximo de 8 dígitos.');
            } else {
                console.log('Nombre:', nombre);
                console.log('DNI:', dni);
                document.getElementById('nuevaModal').classList.remove('show');
                document.getElementById('nuevaModal').setAttribute('aria-hidden', 'true');
                document.getElementById('nuevaModal').setAttribute('style', 'display: none');
                document.body.classList.remove('modal-open');
                document.body.setAttribute('style', '');
                document.getElementById('registroExitosoModal').classList.add('show');
                document.getElementById('registroExitosoModal').setAttribute('aria-hidden', 'false');
                document.getElementById('registroExitosoModal').setAttribute('style', 'display: block');
            }
        });

        document.getElementById('registrarOtraPersona').addEventListener('click', function() {
            document.getElementById('nombre').value = ''; // Limpiar el campo nombre
            document.getElementById('dni').value = '';    // Limpiar el campo DNI
            modal.show();
        });

        document.getElementById('cerrarRegistroExitoso').addEventListener('click', function() {
            document.getElementById('registroExitosoModal').classList.remove('show');
            document.getElementById('registroExitosoModal').setAttribute('aria-hidden', 'true');
            document.getElementById('registroExitosoModal').setAttribute('style', 'display: none');
            document.body.classList.remove('modal-open');
            document.body.setAttribute('style', '');
        });

    </script>
</body>
</html>
