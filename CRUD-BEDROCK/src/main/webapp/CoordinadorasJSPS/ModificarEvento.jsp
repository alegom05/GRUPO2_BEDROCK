<%--
  Created by IntelliJ IDEA.
  User: Isaac
  Date: 12/06/2024
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="evento" type="com.example.grupo2.Beans.Evento" scope="request"/>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>


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
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="./logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
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
            <!--h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">%=usuarioSesion.getNombre()%> %=usuarioSesion.getApellido()%><br>Rol: %=usuarioSesion.getRol()%></h2-->
            <a href="logIN.html">
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
                <a href="${pageContext.request.contextPath}/Coordis?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=calendario" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listaEventos" class="nav-link">Historial De Eventos</a>
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
            <h1>Modificar Evento</h1>
        </div>


        <div class="col-md-6 mb-3 ">

            <div class="contenedor mt-4">
                <img src="./imagenes_eventos/deporte/evento1.jpg" alt="Evento" id="imagen_detallada" class="img-fluid mx-auto">
            </div>
        </div>

        <div class="col-md-6 d-flex align-items-center">
            <div>
                <div class="mt-2">
                    <div class="mb-2">
                        <label>Nombre del Evento</label>
                        <input type="text" class="form-control"  name="nombre" value="<%=evento.getNombre()%>">
                    </div>
                    <div class="mb-2">
                        <label>Detalles</label>
                        <textarea class="form-control"  name="descripcion" rows="3" required>Un evento de carrera de 10 km que atraviesa los lugares más emblemáticos de San Miguel. Ideal para corredores de todas las edades.</textarea>
                    </div>
                    <div class="mb-2">
                        <label>Lugar</label>
                        <input type="text" class="form-control" name="lugar" value="<%=evento.getLugar()%>" >
                    </div>


                    <div class="row">
                        <div class="col">
                            <label>Encargado</label>
                            <input type="text" class="form-control"  name="idProfesor" value="<%=evento.getIdProfesor()%>">
                        </div>

                        <div class="col-md-auto">
                            <div class="mb-2">
                                <label>Número de Vacantes</label>
                                <input type="number" class="form-control" name="vacantes" min="1" value="<%=evento.getVacantes()%>" >
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <label>Fecha Inicio</label>
                            <input type="date" class="form-control" name="fechaInicial" value="<%=evento.getFechaInicial()%>">
                        </div>
                        <div class="col">
                            <label>Fecha Fin</label>
                            <input type="date" class="form-control" name="fechaFinal" value="<%=evento.getFechaFinal()%>">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <label>Hora</label>
                            <input type="time" class="form-control" name="hora" value="<%=evento.getHora()%>" >
                        </div>
                        <div class="col">
                            <label>Frecuencia</label>
                            <select class="form-control" value="<%=evento.getFrecuencia()%>">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
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
                <div class="elemento_texto_evento text-center">
                    <a href="" class="btn btn-mas-grande me-4" data-bs-toggle="modal" data-bs-target="#exampleModal"><h7>Guardar</h7></a>
                    <a href="PaginaEventos.html" class="btn btn-primary btn-mas-grande">Cancelar</a>
                </div>
            </div>

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
