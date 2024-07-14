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
    boolean mostrarGuardar = (Boolean) request.getAttribute("mostrarGuardar");
    boolean mostrarIniciar = (Boolean) request.getAttribute("mostrarIniciar");
    boolean mostrarCerrar = (Boolean) request.getAttribute("mostrarCerrar");

    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

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
                <a href="<%=request.getContextPath()%>/CoordinadoraIndexServlet?action=editar&id=<%=usuarioSesion.getId()%>">
                    <!--href="%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=%=usuarioSesion.getId()%>"-->
                    <img src="../logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
                </a>
                <div class="usuario-info">
                    <%
                        String tipoUsuario = usuarioSesion.getTipo();
                        String rol = "Coordinadora de " + tipoUsuario.toLowerCase();
                    %>
                    <h2 style=" text-align: right;">
                        <%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br><%=rol%>
                    </h2>
                </div>
                <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                    <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
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
                    <a href="${pageContext.request.contextPath}/Coordis?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?action=calendario" class="nav-link">Mira Tu Calendario!</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?action=listaEventos&tipoUsuario=<%=usuarioSesion.getTipo()%>" class="nav-link">Historial De Eventos</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?action=listarve" class="nav-link">Lista de Vecinos</a>
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

            <!-- Versión que te lleva a modal, lo comento por el momento-->
            <!--<a href="" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">Guardar</a>-->
            <% if (mostrarGuardar) { %>
            <button type="button" class="btn btn-primary" id="btnRedireccional">Guardar cambios</button>
            <% } %>

            <% if (mostrarIniciar) { %>
            <button type="button" class="btn btn-primary" id="btnRedireccional" data-bs-toggle="modal" data-bs-target="#exampleModal">Iniciar evento</button>
            <% } %>
            <!-- Modal para iniciar evento (cambia el estado de "Pronto" a "En curso" -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Iniciar evento</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ¿Está segur@ de inciar el evento?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <form method="POST" action="<%= request.getContextPath() %>/Coordis?action=eventoEnCurso">
                                <div>
                                    <input type="hidden" name="idEvento" value="<%=evento.getIdEvento()%>">
                                </div>
                                <button type="submit" class="btn btn-primary">Confirmar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <% if (mostrarCerrar) { %>
            <button type="button" class="btn btn-primary" id="btnRedireccional" data-bs-toggle="modal" data-bs-target="#culminarEventoModal" onclick="mostrarModalCulminar(<%= evento.getIdEvento()%>)">Culminar evento</button>
            <% } %>
            <!-- Modal para culminar evento -->
            <div class="modal fade" id="culminarEventoModal" tabindex="-1" aria-labelledby="culminarEventoModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="culminarEventoModalLabel">Culminar evento</h1>

                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div id="alertaFoto" class="alert alert-danger" style="display: none;">
                                Para continuar debe subir las fotos.
                            </div>
                            <form  class="row align-items-start mb-3" novalidate enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label for="imagenAsistencia" class="form-label">Por favor suba imágenes que demuestren su asistencia al evento:</label>
                                    <input type="file" id="imagenAsistencia" name="imagenAsistencia" class="form-control" accept="image/*">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-success" onclick="confirmarCulminar()">Continuar</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal para confirmar el culminar -->
            <div class="modal fade" id="confirmarCulminar" tabindex="-1" aria-labelledby="confirmarCulminarEvento" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmarCulminarEvento">Confirmar acción</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ¿Estás seguro de que deseas culminar este evento?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-danger" onclick="culminarEventoDefinitivamente()">Culminar</button>
                        </div>
                    </div>
                </div>
            </div>



            <a href="${pageContext.request.contextPath}/Coordis?action=listarInscritos&idEvento=<%= evento.getIdEvento() %>" class="btn btn-primary" >Ver lista de participantes</a>
            <a href="${pageContext.request.contextPath}/Coordis?action=listaEventos" class="btn btn-primary ">Cancelar</a>
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
    <!--<div class="modal fade" id="nuevaModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    </div>-->


</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script>


        function mostrarModalCulminar(id) {
            eventoIdParaCulminar = id;
            $('#culminarEventoModal').modal('show');
        }

        function confirmarCulminar() {
            var foto = document.getElementById('imagenAsistencia');
            var alertaFoto = document.getElementById('alertaFoto');

            if (!foto.files || !foto.files.length) {
                alertaFoto.style.display = 'block';
                setTimeout(function() {
                    alertaFoto.style.display = 'none';
                }, 3000);
                return;
            }
            console.log("Ocultando modal 'culminarEventoModal'");
            $('#culminarEventoModal').modal('hide');

            console.log("Mostrando modal 'confirmarCulminar'");
            $('#confirmarCulminar').modal('show');
        }

        function culminarEventoDefinitivamente() {
            var foto = document.getElementById('imagenAsistencia');
            var idDeEvento = eventoIdParaCulminar; // Supongo que idDeEvento es el mismo que eventoIdParaCulminar

            console.log('ID del evento:', idDeEvento);
            console.log('Archivos seleccionados:', foto.files.length);

            if (idDeEvento != null && foto.files.length > 0) {
                var formData = new FormData();
                formData.append('action', 'culminar');
                formData.append('id', idDeEvento);
                formData.append('foto', foto.files[0]);

                // Realizar la solicitud de eliminación con la imagen
                $.ajax({
                    url: '<%=request.getContextPath()%>/Coordis?action=publicarFotosAsistencia',
                    type: 'POST',
                    data: formData,
                    processData: false, // No procesar los datos
                    contentType: false, // No establecer el tipo de contenido
                    success: function(response) {
                        // Recargar la página para actualizar la tabla
                        console.log('Solicitud completada con éxito');
                        window.location.href = '<%=request.getContextPath()%>/Coordis?action=listaEventos';
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error en la solicitud:', textStatus, errorThrown);
                    }
                });
            } else {
                console.error('ID de evento o foto no válido.');
            }
        }

        /*function soloLetras(event) {
            var inputValue = event.key;
            if (!/^[a-zA-Z\s]*$/.test(inputValue)) {
                event.preventDefault();
            }
        }*/
        /*function soloNumeros(event) {
            var inputValue = event.key;
            var dniValue = document.getElementById('dni').value;
            if (!/^\d$/.test(inputValue) || dniValue.length >= 8) {
                event.preventDefault();
            }
        }*/

        /*document.getElementById('nombre').addEventListener('keypress', soloLetras);
        document.getElementById('dni').addEventListener('keypress', soloNumeros);*/

        /*function abrirModal() {
            var modal = new bootstrap.Modal(document.getElementById('nuevaModal'));
            modal.show();
        }*/

        //document.getElementById('abrirNuevaModal').addEventListener('click', abrirModal);

        /*document.getElementById('registrarPersona').addEventListener('click', function() {
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
        });*/

        /*document.getElementById('registrarOtraPersona').addEventListener('click', function() {
            document.getElementById('nombre').value = ''; // Limpiar el campo nombre
            document.getElementById('dni').value = '';    // Limpiar el campo DNI
            modal.show();
        });*/

        /*document.getElementById('cerrarRegistroExitoso').addEventListener('click', function() {
            document.getElementById('registroExitosoModal').classList.remove('show');
            document.getElementById('registroExitosoModal').setAttribute('aria-hidden', 'true');
            document.getElementById('registroExitosoModal').setAttribute('style', 'display: none');
            document.body.classList.remove('modal-open');
            document.body.setAttribute('style', '');
        });*/

    </script>
</body>
</html>
