<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<!--jsp:useBean type="java.util.ArrayList<com.example.grupo2.Beans.Incidencia>" scope="request" id="incidencia"/-->
<%
    ArrayList<Incidencia> listaIncidencias = (ArrayList<Incidencia>) request.getAttribute("incidencia");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
    <title>Lista de Incidencias</title>
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

<div class="mt-4" style="height: 100vh; margin: 0;">
    <h2 style="text-align: center;">Incidencias Registradas este mes</h2>
    <div class="container mt-4">
        <div style="display: flex; justify-content: space-between;">
            <select id="filtroIncidencia" style="border-color: #DFDFDF; border-radius: 6px; padding:10px; outline: none; width: 130px; height: 50px;">
                <option value="" disabled selected>Filtrar Por</option>
                <option value="">Todos</option>
                <option value="robo">Robo</option>
                <option value="Accidente">Accidente</option>
                <option value="Emergencia">Emergencia</option>
                <option value="Alterar el Orden">Alterar Orden</option>
            </select>
            <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;" placeholder="Buscar...">
        </div>
        <br>
        <div class="table-responsive">
            <table id="miTabla" class="display table-responsive">
                <thead>
                <tr>
                    <th>Tipo De Incidencia</th>
                    <th>Nombre</th>
                    <th>Fecha</th>
                    <th>Lugar</th>
                    <th>Ver</th>
                </tr>
                </thead>
                <tbody>
                <% for (Incidencia incidencia : listaIncidencias) { %>
                <tr>
                    <td><%= incidencia.getTipoIncidencia() %></td>
                    <td><%= incidencia.getNombreIncidencia() %></td>
                    <td><%= incidencia.getFechaIncidencia() %></td>
                    <td><%= incidencia.getLugar() %></td>
                    <td><button id="lupaICON" class="btn btn-outline-secondary" onclick="detallesIncidencia(<%=(incidencia.getIdIncidencia()) %>)">
                        <img src="${pageContext.request.contextPath}/assets/icons/lupa.svg" alt="VerDetalles">
                    </button> </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    $(document).ready(function() {
        var table = $('#miTabla').DataTable({
            "pageLength": 5,
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
            table.column(0).search(estado).draw();
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
    function detallesIncidencia(id) {
        // Redireccionar a otra página HTML
        window.location.href = '<%=request.getContextPath()%>/Coordis?action=detallarIncidencia&id=' + id;
    }

    function detallesIncidencia1() {
        // Redireccionar a otra página HTML
        window.location.href = 'detallesIncidencias.html';
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
