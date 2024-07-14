
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>


<%
    ArrayList<Evento> listaEventos = (ArrayList<Evento>) request.getAttribute("listaEventos");

%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
    <title>Historial de Eventos</title>

</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="DetallesUsuario.html">
                <img src="../logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <div class="usuario-info">
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

<div class="mt-4" style="height: 100vh; margin: 0;">
    <!-- Contenido con imagen centrada -->
    <h2 style="text-align: center;">Eventos Realizados Este Mes</h2>
    <div class="container mt-4">

        <div style="display: flex; justify-content: space-between;">

            <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;" placeholder="Buscar...">
            <div class="col d-flex justify-content-end">
                <a href="<%=request.getContextPath()%>/Coordis?action=formCrearEventos" class="btn btn-primary"><h7>Crear evento</h7></a>
            </div>
        </div>
        <br>
        <div class="table-responsive">
            <table id="miTabla" class="display table-responsive">
                <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Encargado</th>
                    <th>Lugar</th>
                    <th>Fecha</th>
                    <th>Estado</th>
                    <th>Ver</th>
                    <th>Eliminar</th>
                </tr>
                </thead>

                <tbody>
                <% for (Evento eventos: listaEventos){%>
                <tr>
                    <td><%=eventos.getNombre()%></td>
                    <td><%=eventos.getNombreProfesor()%></td>
                    <td><%=eventos.getLugar()%></td>
                    <td><%=eventos.getFechaInicial()%></td>
                    <td><%=eventos.getEstadoEvento()%></td>

                    <td><button id="lupaICON" class="btn btn-outline-secondary" onclick="detallesEvento(<%= eventos.getIdEvento() %>)">
                        <img src="${pageContext.request.contextPath}/assets/icons/lupa.svg" alt="Evaluar">
                    </button> </td>
                    <td><button id="tachoICON" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#confirmModal"  onclick="establecerIdParaEliminar(<%= eventos.getIdEvento() %>)">
                        <img src="${pageContext.request.contextPath}/assets/icons/trash.svg" alt="Eliminar"></button></td>
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
                    ¿Está seguro que desea eliminar este evento?
                    <input type="hidden" id="eventoIdParaEliminar">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="confirmarEliminacion()">Confirmar</button>
                    <!--button type="button" class="btn btn-danger" onclick="confirmarEliminacion()">Eliminar</button-->
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
    <script>
        function detallesEvento(id) {
            // Redireccionar a otra página HTML
            window.location.href = '<%=request.getContextPath()%>/Coordis?action=detallarParaCoordi&id=' + id;
        }
    </script>
    <script>
        function establecerIdParaEliminar(idEvento) {
            document.getElementById('eventoIdParaEliminar').value = idEvento;
        }

        function confirmarEliminacion() {
            const idEvento = document.getElementById('eventoIdParaEliminar').value;
            window.location.href = '<%= request.getContextPath() %>/Coordis?action=deleteEventos&id=' + idEvento;
        }
    </script>
</div>
</body>
</html>