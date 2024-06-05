<%@ page import="java.util.ArrayList" %>

<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Incidencia incidencia = (Incidencia) request.getAttribute("incidencia");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles incidencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link href="style-Serenazgo.css" rel="stylesheet">
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
            <a href="logIN-Serenazgo.jsp">
                <img src="${pageContext.request.contextPath}/assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="paginaPrincipal-Serenazgo.jsp" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="actualizarInfo-Serenazgo.jsp" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/SerenazgoJSPS/IncidenciaServlet" class="nav-link">Incidencias</a>
            </li>
        </ul>
    </nav>
</div>

<div class="container">
    <h4 class="labelFormulario">Detalles de nueva incidencia</h4>
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
                    <input class="form-check-input" type="radio" id="inlineRadio1" value="option1" disabled checked>
                    <label class="form-check-label" for="inlineRadio1">Si</label>
                </div>

                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="inlineRadio2" value="option2" disabled>
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

    <a href="evaluarIncidencias-Serenazgo.jsp" type="button" class="btn gradient-custom-3" id="btnRedireccional">Evaluar incidencia</a>

    <a href="IncidenciaServlet" type="button" class="btn gradient-custom-3" id="btnRedireccional">Falsa Alarma</a>

    <a href="IncidenciaServlet" type="button" class="btn btn-secondary" id="btnRedireccional">Cancelar</a>

</div>




</body>
</html>
