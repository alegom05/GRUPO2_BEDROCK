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

<%
    HttpSession currentSession = request.getSession();
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
                <a href="javascript:void(0)" onclick="detallesUsuario('<%=usuarioSesion.getId()%>')">
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
                    <a href="javascript:void(0)" onclick="listaIncidencias('<%=usuarioSesion.getId()%>')" class="nav-link">Lista de Incidencias</a>
                </li>
                <li class="nav-item">
                    <a href="javascript:void(0)" onclick="verCalendario('<%=usuarioSesion.getId()%>')" class="nav-link">Mira Tu Calendario!</a>
                </li>
                <li class="nav-item">
                    <a href="javascript:void(0)" onclick="historialEventos('<%=usuarioSesion.getId()%>')" class="nav-link">Historial De Eventos</a>
                </li>
            </ul>
        </nav>
    </div>

<div id="container-evento-det" style="max-width: 80%; margin: 0 auto; margin-top: 70px;">
    <div class="row mt-3">
        <div class="col-md-6 mb-3">
            <div class="contenedor mt-4" >
                <img src="<%=request.getContextPath()%>/imagenEvento?id=<%= evento.getIdEvento() %>" alt="Evento" id="imagen_detallada" class="img-fluid mx-auto" style="max-width: 100%;">
            </div>
        </div>

        <div class="col-md-6 d-flex align-items-center">
            <div>
                <div class="">
                    <div class="elemento_texto_evento text-center lh-base">
                        <p class="fw-bold fs-2"><%= evento.getNombre() %></p>
                    </div>
                    <div class="elemento_texto_evento lh-base">
                        <p class="fw-bold mb-0 p- fs-5">Detalles del evento:</p>
                        <p class="mb-0 p-0 fs-5"><%= evento.getDescripcion() %></p>
                    </div>
                    <div class="elemento_texto_evento lh-base">
                        <ul class="list-inline mb-0 p-0">
                            <li class="list-inline-item fw-bold fs-5">Encargado: </li>
                            <li class="list-inline-item fs-5"><%= evento.getNombreProfesor() %></li>
                        </ul>
                    </div>
                    <div class="elemento_texto_evento lh-base">
                        <ul class="list-inline mb-0 p-0">
                            <li class="list-inline-item fw-bold fs-5">Vacantes disponibles: </li>
                            <li class="list-inline-item fs-5"><%= evento.getVacantes() %></li>
                        </ul>
                    </div>
                    <div class="elemento_texto_evento lh-base">
                        <ul class="list-inline mb-0 p-0 ">
                            <li class="list-inline-item fw-bold fs-5">Frecuencia: </li>
                            <li class="list-inline-item fs-5"><%= evento.getFrecuencia() %> veces por semana</li>
                        </ul>
                    </div>
                    <div class="row elemento_texto_evento lh-base">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0 m-0 p-0">
                                <img src="${pageContext.request.contextPath}/imagenes_eventos-Vecino/lugar.png" class="img-thumbnail w-75" alt="lugar">
                            </div>
                            <div class="flex-grow-1 ms-3 lh-base">
                                <ul class="list-inline mb-0 p-0">
                                    <li class="list-inline-item fw-bold fs-5">Lugar: </li>
                                    <li class="list-inline-item fs-5"><%= evento.getLugar() %></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row elemento_texto_evento lh-base">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0 m-0 p-0">
                                <img src="${pageContext.request.contextPath}/imagenes_eventos-Vecino/fecha.png" class="img-thumbnail w-75" alt="fecha">
                            </div>
                            <div class="flex-grow-1 ms-3 lh-base">
                                <ul class="list-inline mb-0 p-0 ">
                                    <li class="list-inline-item fw-bold fs-5">Fecha inicial: </li>
                                    <li class="list-inline-item fs-5"><%= evento.getFechaInicial() %></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row elemento_texto_evento lh-base">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0 m-0 p-0">
                                <img src="${pageContext.request.contextPath}/imagenes_eventos-Vecino/hora.png" class="img-thumbnail w-75" alt="hora">
                            </div>
                            <div class="flex-grow-1 ms-3 lh-base">
                                <ul class="list-inline mb-0">
                                    <li class="list-inline-item fw-bold fs-5">Hora:</li>
                                    <li class="list-inline-item fs-5"><%= evento.getHora() %></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
                <%
                    Integer enCurso = (Integer) currentSession.getAttribute("EventoEnCurso");
                    Integer estaRegistrado = (Integer) currentSession.getAttribute("estaRegistrado");
                    Integer noHayVacantes = (Integer) currentSession.getAttribute("noHayVacantes");
                    Integer eventoYaPaso = (Integer) currentSession.getAttribute("EventoYaPaso");
                %>

                <div class="elemento_texto_evento d-flex mt-1">
                    <% if (enCurso != null && enCurso == 1) { %>
                    <button class="btn" disabled>Evento En Curso</button>
                    <% } else if(eventoYaPaso != null && eventoYaPaso == 1) { %>
                    <button class="btn" disabled>Evento Finalizado</button>
                    <% } else if (noHayVacantes != null && noHayVacantes == 1) { %>
                    <button class="btn" disabled>No Hay Vacantes</button>
                    <% } else if (estaRegistrado != null && estaRegistrado == 1) { %>
                    <button class="btn btn-mas-grande" disabled>Ya Inscrito</button>
                    <% } else { %>
                    <a href="<%= request.getContextPath() %>/EventoServlet?action=inscribirse_evento&id=<%= evento.getIdEvento() %>" class="btn btn-mas-grande"><h7>Inscribirse</h7></a>
                    <% } %>
                </div>
            </div>
        </div>

    </div>
</div>
    <script>
        //listaincidencias//
        function detallesUsuario(id) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%=request.getContextPath()%>/VecinoIndexServlet?action=editar';

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
            form.action = '<%=request.getContextPath()%>/IncidenciaServlet?action=lista3';

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
            form.action = '<%=request.getContextPath()%>/EventoServlet?action=calendario';

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
            form.action = '<%=request.getContextPath()%>/EventoServlet?action=listaEventosVecino';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'idUsuario';
            input.value = id;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>