<%@ page import="java.util.ArrayList" %>

<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    ArrayList<Evento> evento = (ArrayList<Evento>) request.getAttribute("lista");

%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
    <title>Historial de Eventos</title>

</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="./logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Gina Jimenez Villavicencio<br>Coordinadora de deporte </h2>
            <a href="logIN.html">
                <img src="./logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/CoordisIndexServlet" class="nav-link">Municipalidad</a>
            </li>
            <li class="nav-item">
                <a href="PaginaEventos.html" class="nav-link">Eventos</a>
            </li>
            <li class="nav-item">
                <a href="ReportarIncidencia.html" class="nav-link">Reportar Incidencia</a>
            </li>
            <li class="nav-item">
                <a href="ListaDeIncidencias.html" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="Calendario.html" class="nav-link">Mira Tu Calendario!</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/EventoServlet" class="nav-link">Historial De Eventos</a>
            </li>
            <li class="nav-item">
                <a href="VecinoSanmi.html" class="nav-link">Lista de Vecinos</a>
            </li>
        </ul>
    </nav>
</div>

<div class="mt-4" style="height: 100vh; margin: 0;">
    <!-- Contenido con imagen centrada -->
    <h2 style="text-align: center;">Eventos Realizados Este Mes</h2>
    <div class="container mt-4">

        <div style="display: flex; justify-content: space-between;">

            <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;" placeholder="Buscar...">
            <div class="col d-flex justify-content-end">
                <a href="<%=request.getContextPath()%>/EventoServlet?action=new" class="btn btn-primary"><h7>Crear evento</h7></a>
            </div>
        </div>
        <br>
        <div class="tabla-container">
            <table id="miTabla" class="display">
                <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Encargado</th>
                    <th>Lugar</th>
                    <th>Fecha</th>
                    <th>Estado</th>
                    <th>Opciones</th>
                </tr>
                </thead>

                <tbody>
                <% for (Evento eventos: evento){%>
                <tr>
                    <td><%=eventos.getNombre()%></td>
                    <td><%=eventos.getIdProfesor()%></td>
                    <td><%=eventos.getLugar()%></td>
                    <td><%=eventos.getFechaInicial()%></td>
                    <td><%=eventos.getEstadoEvento()%></td>
                    <td>
                        <div class="dropdown">
                            <button class="btn btn-dots dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">

                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=editar&id">Modificar</a></li>
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/EventoServlet?action=editar&id">Finalizar</a></li>
                                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#confirmModal">Eliminar</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>


            </table>
        </div>
    </div>

    <!-- Modal de confirmación -->
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">Eliminar Evento</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estás seguro de que deseas realizar esta acción?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary">Confirmar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery y Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
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
                table.column(2).search(estado).draw();
            });
            $('#customSearch').on('keyup', function() {
                table.search(this.value).draw();
            });
            $('#limpiarFiltros').on('click', function() {
                table.search('').columns().search('').draw();
                $('#filtroIncidencia').val('');
                $('#customSearch').val('');
            });
        });
    </script>
</div>
</body>
</html>