<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Usuario" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<%
    ArrayList<Usuario> listaVecinos = (ArrayList<Usuario>) request.getAttribute("vecinoInscrito");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Juntos Por San Miguel</title>

    <link href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail">
            <h4 class="main-logo-size" style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="DetallesUsuario.html">
                <img src="../logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br></h2>
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
                <a href="${pageContext.request.contextPath}/Coordis?action=listaEventos" class="nav-link">Historial De Eventos</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listarve" class="nav-link">Lista de Vecinos</a>
            </li>
        </ul>
    </nav>
</div>
<div class="mt-4" style="height: 100vh; margin: 0;">
    <h2 style="text-align: center;">Vecinos inscritos para este evento</h2>
    <div class="container mt-4">
        <div style="display: flex; justify-content: space-between;">
            <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;" placeholder="Buscar...">
        </div>
        <br>
        <div class="table-responsive">
            <table id="miTabla" class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>DNI</th>
                    <th>Nombres y apellidos</th>
                    <th>Correo electronico</th>
                    <th>Ver</th>
                    <th>Reportar</th>
                    <th>Eliminar</th>
                </tr>
                </thead>
                <tbody>
                <% for (Usuario vecino : listaVecinos) { %>
                <tr>
                    <td><%= vecino.getDni() %></td>
                    <td><%= vecino.getNombre() %></td>
                    <td><%= vecino.getCorreo() %></td>
                    <td><button id="lupaICON" class="btn btn-secondary" onclick="detalleVecino(<%= vecino.getId() %>)">
                        <img src="${pageContext.request.contextPath}/assets/icons/lupa.svg" alt="Ver">
                    </button></td>
                    <td>
                        <a href="" data-bs-toggle="modal" data-bs-target="#modalReporte">
                            <img src="<%= request.getContextPath() %>/CoordinadorasJSPS/Iconos/report.png" alt="Descripción de la imagen" class="mi-imagen">
                        </a>
                    </td>
                    <td>
                        <a href="" class="" data-bs-toggle="modal" data-bs-target="#modalEliminar">
                            <img src="<%= request.getContextPath() %>/CoordinadorasJSPS//Iconos/removeduser.png" alt="Descripción de la imagen" class="mi-imagen">
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="modalEliminarLabel">Eliminar vecino</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h5>¿Estás seguro de eliminar al vecino del evento?</h5>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="confirmarEliminacion">Sí</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalReporte" tabindex="-1" aria-labelledby="modalReporteLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="modalReporteLabel">Reportar al vecino</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="motivoReporte" class="form-label">Motivo:</label>
                            <textarea class="form-control" id="motivoReporte" rows="3" placeholder="Ingrese el motivo"></textarea>
                            <div id="errorMotivo" class="text-danger mt-2" style="display: none;">Es necesario llenar este campo para poder guardar.</div>
                            <div id="successMessage" class="text-success mt-2" style="display: none;">Reporte registrado con éxito.</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="registrarReporte">Registrar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
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

        $('#customSearch').on('keyup', function() {
            table.search(this.value).draw();
        });

        // Resetear el mensaje de error al abrir el modal
        $('#modalReporte').on('show.bs.modal', function () {
            document.getElementById('errorMotivo').style.display = 'none';
            document.getElementById('successMessage').style.display = 'none';
            document.getElementById('motivoReporte').value = '';
        });
    });

    document.getElementById('registrarReporte').addEventListener('click', function() {
        var motivo = document.getElementById('motivoReporte').value;
        var errorMotivo = document.getElementById('errorMotivo');
        var successMessage = document.getElementById('successMessage');

        if (motivo.trim() === '') {
            errorMotivo.style.display = 'block';
            successMessage.style.display = 'none';
        } else {
            errorMotivo.style.display = 'none';
            successMessage.style.display = 'block';

            console.log('Motivo:', motivo);

            setTimeout(function() {
                var modal = bootstrap.Modal.getInstance(document.getElementById('modalReporte'));
                modal.hide();
                successMessage.style.display = 'none';
                location.reload();
            }, 2000);
        }
    });

    document.getElementById('confirmarEliminacion').addEventListener('click', function() {
        console.log('Vecino eliminado');
        location.reload();
    });
</script>
<script>
    function detalleVecino(id) {
        // Redireccionar a otra página HTML
        window.location.href = '<%=request.getContextPath()%>/Usuario?action=detallar&id=' + id;
    }
</script>
</body>
</html>
