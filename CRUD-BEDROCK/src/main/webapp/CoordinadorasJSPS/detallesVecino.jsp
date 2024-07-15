<%@ page import="com.example.grupo2.Beans.Usuario" %>
<%@ page import="com.example.grupo2.Beans.Historial" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Isaac
  Date: 9/07/2024
  Time: 17:53
  To change this template use File | Settings | File Templates.
--%>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario vecino = (Usuario) request.getAttribute("vecino");
    ArrayList<Historial> historialVecino = (ArrayList<Historial>) request.getAttribute("historialVecino");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
    <title>Vecinos de San Miguel</title>

</head>
<body>
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
<div class="container mt-4">
    <h2 style="text-align: center;">Información vecino</h2>
    <form class="row align-items-start mt-4">
        <div class="col">
            <fieldset disabled>

                <div class="mb-3">

                    <label for="disabledTextInput" class="form-label">Nombre</label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=vecino.getNombre()%> ">

                    <label for="disabledTextInput" class="form-label">Telefono </label>
                    <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=vecino.getNumtelefono()%>">

                </div>
            </fieldset>

        </div>

        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput" class="form-label">Apellido</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=vecino.getApellido()%>">

                <label for="disabledTextInput" class="form-label">Dirección</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=vecino.getDireccion()%>">

            </fieldset>
        </div>
        <div class="col">
            <fieldset disabled>
                <label for="disabledTextInput" class="form-label">DNI</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=vecino.getDni()%>">

                <label for="disabledTextInput" class="form-label">Urbanizacion</label>
                <input type="text" id="disabledTextInput" class="form-control" placeholder="<%=vecino.getUrbanizacion()%>">

            </fieldset>
        </div>

    </form>
    <h3 style="text-align: center mt-4" >Historial de comportamiento</h3>
    <div class="tabla-container mt-4">
        <table id="miTabla" class="display">
            <thead>
            <tr>
                <th>Fecha</th>
                <th>Evento</th>
                <th>Lugar</th>
                <th>Motivo</th>

            </tr>
            </thead>
            <tbody>
            <% for (Historial historial : historialVecino) { %>
            <tr>
                <td><%= historial.getFechaInicial() %></td>
                <td><%= historial.getNombre() %></td>
                <td><%= historial.getLugar() %></td>
                <td><%= historial.getDescripcion() %></td>

            </tr>
            <% } %>

            </tbody>
        </table>
    </div>



</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function() {
        var table = $('#miTabla').DataTable({
            "pageLength":5,
            "lengthChange": false,
            "language": {
                "emptyTable": "No hay registros disponibles",
                "zeroRecords": "No se encontraron registros coincidentes",
                "infoEmpty": "Mostrando 0 a 0 de 0 entradas",
                "paginate": {
                    "first": "Primero",
                    "last": "Último",
                    "next": "Siguiente",
                    "previous": "Anterior"
                },
                "info": "Mostrando de _START_ a _END_ de _TOTAL_ entradas"
            }

        });
        $('.dataTables_filter input').css('margin-bottom', '20px');
        $('#miTabla thead').css({
            'background-image': 'linear-gradient(0deg, rgb(131, 126, 190) 0%, rgb(92, 131, 210) 100%)',
            'color': 'white'
        });


        $('#filtroIncidencia').on('change', function() {
            var estado = $(this).val();
            table.column(2).search(estado).draw();
        });
        $('#customSearch').on('keyup', function() {
            table.search(this.value).draw();
        });
        $('#limpiarFiltros').on('click', function() {
            $('#filtroIncidencia').val('');
            table.search('').columns().search('').draw();
        });
    });
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
