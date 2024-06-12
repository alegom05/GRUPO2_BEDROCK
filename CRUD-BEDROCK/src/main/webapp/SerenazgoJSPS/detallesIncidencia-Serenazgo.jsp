<%@ page import="java.util.ArrayList" %>

<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Incidencia incidencia = (Incidencia) request.getAttribute("incidencia");
    boolean mostrarEvaluar = (Boolean) request.getAttribute("mostrarEvaluar");
    boolean mostrarVerEvaluacion = (Boolean) request.getAttribute("mostrarVerEvaluacion");
    boolean mostrarFalsaAlarma = (Boolean) request.getAttribute("mostrarFalsaAlarma");
    boolean mostrarCerrar = (Boolean) request.getAttribute("mostrarCerrar");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles incidencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link href="${pageContext.request.contextPath}/SerenazgoJSPS/style-Serenazgo.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h4 style="margin-top: 10px; margin-right: 40px; text-align: right; ">Diego Rodriguez<br>Rol: Serenazgo</h4>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/SerenazgoJSPS/paginaPrincipal-Serenazgo.jsp" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=estadisticalizar" class="nav-link"> Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/IncidenciaServlet" class="nav-link">Incidencias</a>
            </li>
        </ul>
    </nav>
</div>

<div class="container">
    <h4 class="labelFormulario">Detalles de incidencia (Estado: <%=incidencia.getEstadoIncidencia()%>) (Fecha de reporte: <%=incidencia.getFechaIncidencia()%>)</h4>
    <form class="row align-items-start">
        <div class="col">
            <fieldset disabled>

                <div class="mb-3">

                    <label for="disabledTextInput" class="form-label">Incidencia</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= incidencia.getNombreIncidencia() %>">

                    <label for="disabledTextInput" class="form-label">Descripción</label>
                    <textarea class="form-control" placeholder="<%= incidencia.getDescripcion() %>" id="floatingTextarea2" style="height: 125px" disabled></textarea>

                    <label for="disabledTextInput" class="form-label">Lugar</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= incidencia.getLugar()%>">

                    <label for="disabledTextInput" class="form-label">Referencia</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= incidencia.getReferencia()%>">

                    <label for="disabledTextInput" class="form-label">Tipo de incidencia</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= incidencia.getTipoIncidencia()%>">



                </div>
            </fieldset>

        </div>

        <div class="col">
            <fieldset disabled>

                <label for="disabledTextInput" class="form-label">Contacto</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= incidencia.getContacto()%>">

                <label for="disabledTextInput" class="form-label">Requiere Ambulancia</label>


                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="inlineRadio1" value="option1" <%= incidencia.isRequiereAmbulancia() ? "checked" : "" %> disabled>
                    <label class="form-check-label" for="inlineRadio1">Si</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="inlineRadio2" value="option2" <%= incidencia.isRequiereAmbulancia() ? "" : "checked" %> disabled>
                    <label class="form-check-label" for="inlineRadio2">No</label>
                </div>

                <label for="disabledTextInput" class="form-label">Usuario que reportó</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%= incidencia.getUsuario()%>">
            </fieldset>
            <br>
            <figure class="figure">
                <img src="<%= incidencia.getFotoIncidencia() %>" class="figure-img img-fluid rounded" alt="..." style="height: 250px">
                <figcaption class="figure-caption">Foto tomada por usuario.</figcaption>
            </figure>

        </div>


    </form>

</div>

<div class="botonesGroup">

    <button type="button" class="btn gradient-custom-3" id="btnRedireccional">Exportar</button>

    <% if (mostrarEvaluar) { %>
    <!--<a href="${pageContext.request.contextPath}/SerenazgoJSPS/evaluarIncidencias-Serenazgo.jsp" type="button" class="btn gradient-custom-3" id="btnRedireccional">Evaluar incidencia</a>-->
    <buttom type="button" class="btn gradient-custom-3" data-bs-toggle="modal" data-bs-target="#evaluacionIncidencia" id="btnRedireccional">Evaluar incidencia</buttom>
    <% } %>

    <% if (mostrarVerEvaluacion) { %>
    <a href="${pageContext.request.contextPath}/SerenazgoJSPS/evaluarIncidencias-Serenazgo.jsp  " type="button" class="btn gradient-custom-3" id="btnRedireccional">Ver evaluación</a>
    <% } %>

    <!--Modal para evaluar incidencia o ver la evaluación-->
    <div class="modal fade modal-dialog modal-lg" id="evaluacionIncidencia" tabindex="-1" aria-labelledby="evaluacionIncidencia" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="evaluacionIncidencia">Evaluación de incidencia</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form class="row align-items-start mb-3" style="text-align: left">

                        <div class="mb-3">

                            <%--@declare id="enabledtextinput"--%><label for="enabledTextInput" class="form-label" >Criticidad:</label>
                            <select class="form-select" aria-label="Default select example">
                                <option selected>Seleccione la criticidad</option>
                                <option value="1">Bajo</option>
                                <option value="2">Medio</option>
                                <option value="3">Alto</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="enabledTextInput" class="form-label" >Se necesita:</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                                <label class="form-check-label" for="inlineCheckbox1">Bomberos</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
                                <label class="form-check-label" for="inlineCheckbox2">Comisaría</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="option3">
                                <label class="form-check-label" for="inlineCheckbox3">Ambulancia</label>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="enabledTextInput" class="form-label" >Personal de serenazgo de refuerzo:</label>
                            <select  class="form-select" aria-label="Default select example">
                                <option selected>Seleccione el personal de refuerzo</option>
                                <option value="1">A pie</option>
                                <option value="2">Bicicleta</option>
                                <option value="3">Canino</option>
                                <option value="3">Vehículo</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="enabledTextInput" class="form-label" >Descripción de solución:</label>
                            <textarea class="form-control" placeholder="Máximo 130 caracteres" id="floatingTextarea2" style="height: 100px"></textarea>
                        </div>

                        <!--
                        <div class="mb-3">
                            <label for="enabledTextInput" class="form-label" >Estado de personal::</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                                <label class="form-check-label" for="inlineCheckbox1">Bomberos en camino</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
                                <label class="form-check-label" for="inlineCheckbox2">Ambulancia en camino </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="option3">
                                <label class="form-check-label" for="inlineCheckbox3">Policía en camino</label>
                            </div>
                        </div> -->
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn gradient-custom-3">Guardar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>

        </div>

    </div>

    <%-- Botón "Cerrar incidencia" --%>
    <% if (mostrarCerrar) {%>
    <button type="button" class="btn gradient-custom-3" data-bs-toggle="modal" data-bs-target="#cerrarIncidencia" id="btnRedireccional"> Cerrar incidencia </button>
    <% } %>

    <!-- Modal para cerrar incidencia -->
    <div class="modal fade" id="cerrarIncidencia" tabindex="-1" aria-labelledby="cerrarIncidencia" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="cerrarIncidencia">Cerrar incidencia</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Está seguro de cerrar esta incidencia?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <form method="POST" action="<%= request.getContextPath() %>/IncidenciaServlet?action=incidenciaCerrada">
                        <div>
                            <input type="hidden" name="idIncidencia" value="<%=incidencia.getIdIncidencia()%>">
                        </div>
                        <button type="submit" class="btn btn-danger">Confirmar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%-- Botón "Falsa alarma" --%>
    <% if (mostrarFalsaAlarma) { %>
    <button type="button" class="btn gradient-custom-3" data-bs-toggle="modal" data-bs-target="#exampleModal" id="btnRedireccional"> Falsa alarma </button>
    <% } %>

    <!-- Modal para convertir a Falasa alarma -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Falsa alarma</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Está seguro de convertir esta incidencia a falsa alarma?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <form method="POST" action="<%= request.getContextPath() %>/IncidenciaServlet?action=falsaAlarma">
                        <div>
                            <input type="hidden" name="idIncidencia" value="<%=incidencia.getIdIncidencia()%>">
                        </div>
                        <button type="submit" class="btn btn-danger">Confirmar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <a href="IncidenciaServlet" type="button" class="btn btn-secondary" id="btnRedireccional">Cancelar</a>

</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
