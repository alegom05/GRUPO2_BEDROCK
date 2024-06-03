<%@ page import="java.util.ArrayList" %>

<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<Incidencia> listaIncidencias = (ArrayList<Incidencia>) request.getAttribute("lista");

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incidencias</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link href="style-Serenazgo.css" rel="stylesheet">

</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h4 style="margin-top: 10px; margin-right: 40px; text-align: right; ">Diego Rodriguez<br>Rol: Serenazgo</h4>
            <a href="logIN-Serenazgo.jsp">
                <img src="assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
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
                <a href="IncidenciaServlet" class="nav-link">Incidencias</a>
            </li>
        </ul>
    </nav>
</div>


<div class="container mt-4">

    <div style="display: flex; justify-content: space-between;">
        <select id="filtroEstado" style="border-color: #DFDFDF; border-radius: 6px; padding:10px; outline: none;" >
            <<option value=""> </option>
            <option value="nueva">Nuevas</option>
            <option value="en proceso">En proceso</option>
            <option value="falsa alarma">Falsa alarma</option>
        </select>


        <button id="limpiarFiltros" class="btn gradient-custom-3">Limpiar Filtros</button>
    </div>
    <br>
    <div class="table-responsive">
        <table id="miTabla" class="display table-responsive">

            <thead>
            <tr>
            <tr>
                <th>Incidencia</th>
                <th>Tipo de Incidencia</th>
                <th>Estado</th>
                <th>Usuario</th>
                <th>Correo de Usuario</th>
                <th>Ver</th>
                <th>Eliminar</th>
            </tr>

            </tr>
            </thead>

            <tbody>
            <% for (Incidencia incidencia : listaIncidencias) {%>
            <tr>
                <td><%=incidencia.getNombreIncidencia()%></td>
                <td><%=incidencia.getTipoIncidencia()%> </td>
                <td><%=incidencia.getEstadoIncidencia()%></td>
                <td><%=incidencia.getNombreUsuario()%></td>
                <td><%=incidencia.getCorreoUsuario()%></td>
                <td><button id="lupaICON" class="btn btn-outline-secondary" onclick="detallesIncidencia(<%= incidencia.getIdIncidencia() %>)">
                    <img src="assets/icons/lupa.svg" alt="Evaluar">
                </button> </td>
                <td><button id="tachoICON" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#eliminarIncidenciaModal" onclick="eliminarIncidencia(<%= incidencia.getIdIncidencia()%>)"><img src="assets/icons/trash.svg" alt="Eliminar"></button></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
                "info": "Mostrando de _START_ a _END_ de _TOTAL_ entradas",
                "search": "Buscar:"
            }

        });
        $('.dataTables_filter input').css('margin-bottom', '20px');
        $('#miTabla thead').css({
            'background-image': 'linear-gradient(to right, #0f0f3d, #191970)',
            'color': 'white'
        });


        $('#filtroEstado').on('change', function() {
            var estado = $(this).val();
            table.column(2).search(estado).draw();
        });

        $('#limpiarFiltros').on('click', function() {
            $('#filtroEstado').val('');
            table.search('').columns().search('').draw();
        });
    });
</script>
<script>
    function detallesIncidencia(id) {
        // Redireccionar a otra página HTML
        window.location.href = '<%=request.getContextPath()%>/IncidenciaServlet?action=detallar&id=' + id;
    }

    function detallesIncidencia1() {
        // Redireccionar a otra página HTML
        window.location.href = 'detallesIncidenciasProcesadas.html';
    }

    function eliminarIncidencia(id) {
        // Mostrar el modal de eliminación de incidencia
        $('#eliminarIncidenciaModal').modal('show');
        window.location.href = '<%=request.getContextPath()%>/IncidenciaServlet?action=borrar&id=' + id;
    }
</script>
</body>
</html>

