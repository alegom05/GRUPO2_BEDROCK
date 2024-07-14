<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Usuario" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%
    ArrayList<Usuario> listaVecinos = (ArrayList<Usuario>) request.getAttribute("vecinoInscrito");
    //Usuario vecino1 = (Usuario) request.getAttribute("vecino1");
%>
<!DOCTYPE html>
<html lang="en">
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
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" >
            <h4 class="main-logo-size" style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="javascript:void(0)" onclick="detallesUsuario('<%=usuarioSesion.getId()%>')">
                <!--href="%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=%=usuarioSesion.getId()%>"-->
                <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
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
                <a href="javascript:void(0)" onclick="listaIncidencias('<%=usuarioSesion.getId()%>')" class="nav-link">Lista de Incidencias</a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0)" onclick="verCalendario('<%=usuarioSesion.getId()%>')" class="nav-link">Mira Tu Calendario!</a>
                <%--<a href="${pageContext.request.contextPath}/Coordis?action=calendario" class="nav-link">Mira Tu Calendario!</a>--%>
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
    <h2 style="text-align: center;">Vecinos inscritos para este evento</h2>
    <div class="container mt-4">
        <div style="display: flex; justify-content: space-between;">
            <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;" placeholder="Buscar...">
        </div>
        <br>
        <div class="table-responsive">
            <table id="miTabla" class="display table-responsive">
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
                    <td><button id="lupaICON" class="btn btn-secondary" onclick="detalleVecino(<%= vecino.getId()%>)">
                        <img src="${pageContext.request.contextPath}/assets/icons/lupa.svg" alt="Evaluar">
                    </button></td>



                    <td>
                        <a href="" data-bs-toggle="modal" data-bs-target="#modalReporte">
                            <img src="<%= request.getContextPath() %>/CoordinadorasJSPS/Iconos/report.png" alt="Descripción de la imagen" class="mi-imagen">
                        </a>
                    </td>


                    <td><button id="tachoICON" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#modalEliminar"  onclick="establecerIdParaEliminar(<%= vecino.getId() %>)">
                        <img src="${pageContext.request.contextPath}/assets/icons/trash.svg" alt="Eliminar"></button></td>
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
                        ¿Estás seguro de eliminar al vecino del evento?
                        <input type="hidden" id="usuarioIdParaEliminar">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="confirmarEliminacion()">Sí</button>
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
                    <form id="reporteVecino" method="post" action="<%=request.getContextPath()%>/UsuarioServlet?action=reportar"  novalidate style="text-align: left; margin-left: 10px; margin-right: 10px">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="motivoReporte" class="form-label">Motivo:</label>
                                <textarea class="form-control" id="motivoReporte" name ="motivoReporte" rows="3" placeholder="Ingrese el motivo"></textarea>
                                <div id="errorMotivo" class="text-danger mt-2" style="display: none;">Es necesario llenar este campo para poder guardar.</div>
                                <div id="successMessage" class="text-success mt-2" style="display: none;">Reporte registrado con éxito.</div>
                            </div>
                        </div>
                        <%--<div class="mb-3">
                            <input type="hidden" name="idVecino" value="<%=vecino1.getId()%>">
                        </div>--%>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" id="registrarReporte">Registrar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
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

    document.getElementById('usuarioIdParaEliminar').addEventListener('click', function() {
        console.log('Vecino eliminado');
       location.reload();
    });
</script>
<script>
    function detalleVecino(id) {
        // Redireccionar a otra página HTML
        window.location.href = '<%=request.getContextPath()%>/UsuarioServlet?action=detallar&id=' + id;
    }

    function establecerIdParaEliminar(idUsuario){
        document.getElementById('usuarioIdParaEliminar').value = idUsuario;
    }

    function confirmarEliminacion(){
        const idUsuario= document.getElementById('usuarioIdParaEliminar').value;
        window.location.href= '<%=request.getContextPath()%>/Coordis?action=deleteUsuario&idVecino=' + idUsuario;
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
