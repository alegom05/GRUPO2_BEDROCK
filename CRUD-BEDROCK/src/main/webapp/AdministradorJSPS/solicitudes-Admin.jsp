<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Solicitudes" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="solicitudes" scope="request" type="java.util.ArrayList<com.example.grupo2.Beans.Solicitudes>" />
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitudes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="${pageContext.request.contextPath}/AdministradorJSPS/style-Admin.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/Administrador/assets/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Administrador</h2>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/Administrador/assets/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail cerrar-sesion-img">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/AdminIndexServlet" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Solicitudes" class="nav-link">Administración de solicitudes</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Serenazgos" class="nav-link">Serenazgos</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Profesores" class="nav-link">Lista de profesores</a>
            </li>

        </ul>
    </nav>
</div>


<div class="container mt-4 table-responsive">
    <div class="filter-container">
        <div class="filter-left">
            <label>Buscar:</label>
            <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;">
        </div>
        <div class="filter-center">
            <label for="filtroMiembro">Filtrar por:</label>
            <select id="filtroMiembro" style="border-color: #DFDFDF; border-radius: 6px; padding:10px; outline: none;">
                <option value="">Mostrar Todos</option>
                <option value="Vecino">Vecino</option>
                <option value="Coordinadora">Coordinadora</option>
            </select>
        </div>
        <div class="filter-right">
            <button id="limpiarFiltros" type="button" class="btn btn-dark">Limpiar Filtros</button>
        </div>
    </div>
    <br>
    <table id="miTabla" class="display">
        <thead class="cabecera-tabla">
        <tr>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>DNI</th>
            <th>Correo</th>
            <th>Dirección</th>
            <th>Rol solicitado</th>
            <th >Acción a realizar</th>
        </tr>
        </thead>

        <tbody>
            <% for (Solicitudes solicitudes1 : solicitudes) { %>
        <tr>
            <td><%=solicitudes1.getNombre()%></td>
            <td><%=solicitudes1.getApellido()%></td>
            <td><%=solicitudes1.getDni()%></td>
            <td><%=solicitudes1.getCorreo()%></td>
            <td><%=solicitudes1.getDireccion()%></td>
            <td>
                <% if ("VE".equals(solicitudes1.getRol())) { %>
                Coordinadora
                <% } else if (solicitudes1.getRol() == null) { %>
                Vecino
                <% } else { %>
                <%=solicitudes1.getRol()%>
                <% } %>
            </td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-ellipsis-v"></i>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="#" onclick="mostrarModalAprobacion('<%= solicitudes1.getIdsolicitud() %>', '<%= solicitudes1.getCorreo() %>', '<%= solicitudes1.getRol() %>')">Aprobar</a></li>
                        <li><a onclick="setSerenazgoId('<%= solicitudes1.getIdsolicitud() %>', '<%= solicitudes1.getCorreo() %>')" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#rechazarSolicitudModal" href="#">Rechazar</a></li>
                    </ul>
                </div>
            </td>
        </tr>
            <%  }  %>
        </tbody>
    </table>



    <div class="modal fade" id="rechazarSolicitudModal" tabindex="-1" aria-labelledby="rechazarSolicitudModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="rechazarSolicitudModalLabel">Rechazar Solicitud</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="formRechazar">
                        <div class="mb-3">
                            <label for="motivoRechazo" class="form-label">Motivo de Rechazo</label>
                            <select id="motivoRechazo" class="form-select" required>
                                <option value="">Seleccione una razón</option>
                                <option value="Información incompleta">Información incompleta</option>
                                <option value="No cumple con los requisitos">No cumple con los requisitos</option>
                                <option value="Otro">Otro</option>
                            </select>
                        </div>
                        <input type="hidden" id="idSolicitudRechazo" name="idSolicitudRechazo">
                        <input type="hidden" id="correoSolicitudRechazo" name="correoSolicitudRechazo">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="confirmarRechazo">Rechazar</button>
                </div>
            </div>
        </div>
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
                    "infoFiltered": "(filtrado de _MAX_ entradas totales)"
                },

            });
            $('.dataTables_filter input').css('margin-bottom', '20px');
            $('#miTabla thead').css({
                'color': 'white'
            });


            $('#filtroMiembro').on('change', function() {
                var miembro = $(this).val();
                table.column(5).search(miembro).draw();
            });

            $('#limpiarFiltros').on('click', function() {
                $('#filtroMiembro').val('');
                table.search('').columns().search('').draw();
            });
            $('#customSearch').on('keyup', function() {
                table.search(this.value).draw();
            });
        });
    </script>
</div>

<div class="modal fade" id="aprobarSolicitudModal" tabindex="-1" aria-labelledby="aprobarSolicitudModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="aprobarSolicitudModalLabel">Aprobar Solicitud</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Está seguro que desea aprobar esta solicitud? Se enviará un correo al usuario con la información de acceso.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="confirmarAprobacion">Aprobar</button>
            </div>
        </div>
    </div>
</div>

<script>
    let idSolicitudActual;
    let correoSolicitudActual;

    function mostrarModalAprobacion(id, correo, rol) {
        idSolicitudActual = id;
        correoSolicitudActual = correo;
        rolSolicitudActual = rol;
        $('#aprobarSolicitudModal').modal('show');
    }

    $(document).ready(function() {
        $('#confirmarAprobacion').click(function() {
            $.ajax({
                url: '<%=request.getContextPath()%>/Solicitudes',
                type: 'POST',
                data: {
                    a: 'aprobar',
                    id: idSolicitudActual,
                    correo: correoSolicitudActual,
                    rol: rolSolicitudActual
                },
                success: function(response) {
                    $('#aprobarSolicitudModal').modal('hide');
                    // Redirigir a la página de solicitudes
                    window.location.href = '<%=request.getContextPath()%>/Solicitudes';
                },
                error: function(xhr, status, error) {
                    console.error('Error al aprobar la solicitud:', error);
                    alert('Hubo un error al aprobar la solicitud. Por favor, inténtelo de nuevo.');
                }
            });
        });
    });
</script>
    <script>
        let idSolicitudRechazoActual;
        let correoSolicitudRechazoActual;

        function setSerenazgoId(id, correo) {
            document.getElementById('idSolicitudRechazo').value = id;
            document.getElementById('correoSolicitudRechazo').value = correo;
            $('#rechazarSolicitudModal').modal('show');
        }

        $(document).ready(function() {
            $('#confirmarRechazo').click(function() {
                const idSolicitud = $('#idSolicitudRechazo').val();
                const correoSolicitud = $('#correoSolicitudRechazo').val();
                const motivoRechazo = $('#motivoRechazo').val();

                if (motivoRechazo) {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/Solicitudes',
                        type: 'POST',
                        data: {
                            a: 'rechazar',
                            id: idSolicitud,
                            correo: correoSolicitud,
                            motivo: motivoRechazo
                        },
                        success: function(response) {
                            $('#rechazarSolicitudModal').modal('hide');
                            window.location.href = '<%=request.getContextPath()%>/Solicitudes';
                        },
                        error: function(xhr, status, error) {
                            console.error('Error al rechazar la solicitud:', error);
                            alert('Hubo un error al rechazar la solicitud. Por favor, inténtelo de nuevo.');
                        }
                    });
                } else {
                    alert('Por favor, seleccione un motivo de rechazo.');
                }
            });
        });
    </script>



</body>
</html>