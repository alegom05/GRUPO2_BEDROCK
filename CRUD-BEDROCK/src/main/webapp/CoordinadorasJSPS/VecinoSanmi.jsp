<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.grupo2.Beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
ArrayList<Usuario> listaUsuarios = (ArrayList<Usuario>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
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
    <div class="ParteSuperior">
        <div class="row">
            <div class="col-md-3 d-flex justify-content-start align-items-center">
                <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
                <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
            </div>
            <div class="col-md-9 d-flex align-items-center justify-content-end">
                <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Gina Jimenez Villavicencio<br>Coordinadora de deporte </h2>
                <a href="logIN.html">
                    <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
                </a>
            </div>
        </div>
        <nav class="letra_botones_encabezado">
            <ul class="nav">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=paginaPrincipal" class="nav-link">Municipalidad</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=listarev" class="nav-link">Eventos</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=crearin" class="nav-link">Reportar Incidencia</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=listarin" class="nav-link">Lista de Incidencias</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=calendario" class="nav-link">Mira Tu Calendario!</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=listarev" class="nav-link">Historial De Eventos</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Coordis?a=listarve" class="nav-link">Lista de Vecinos</a>
                </li>
            </ul>
        </nav>             
    </div>

	<div class="mt-4" style="height: 100vh; margin: 0;">
		<!-- Contenido con imagen centrada -->
        <h2 style="text-align: center;">Vecinos Sanmiguelinos</h2>
        <div class="container mt-4">

            <div style="display: flex; justify-content: space-between;">
                <!--<select id="filtroIncidencia" style="border-color: #DFDFDF; border-radius: 6px; padding:10px; outline: none; width: 130px; height: 50px;" >
                    <option value="" disabled selected>Filtrar Por</option>
                    <option value="">Todos</option>
                    <option value="Deportivo">Eventos Deportivos</option>
                    <option value="Cultural">Eventos Culturales</option>
                </select>-->
                <input type="text" id="customSearch" style="border: 1px solid #DFDFDF; border-radius: 6px; padding: 10px; outline: none; width: 200px;" placeholder="Buscar...">
            </div>
        <br>
		<div class="tabla-container">
            <table id="miTabla" class="display">
                <thead>
                    <tr>
                        <th>DNI</th>
                        <th>Nombres y apellidos</th>
                        <th>Correo electronico</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Usuario usuario : listaUsuarios) {%>
                <tr>
                    <td><%=usuario.getDni()%> </td>
                    <td><%=usuario.getNombre()%></td>
                    <td><%=usuario.getCorreo()%></td>
                    <%--<td><button id="lupaICON" class="btn btn-outline-secondary" onclick="detallesIncidencia(<%= incidencia.getIdIncidencia() %>)">
                    <img src="${pageContext.request.contextPath}/assets/icons/lupa.svg" alt="Evaluar">
                </button> </td>
                    <td><button id="tachoICON" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#eliminarIncidenciaModal" onclick="eliminarIncidencia(<%= incidencia.getIdIncidencia()%>)"><img src="${pageContext.request.contextPath}/assets/icons/trash.svg" alt="Eliminar"></button></td>--%>
                </tr>
                <% } %>
    

                </tbody>
            </table>
	    </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="exampleModalLabel">Eliminar vecino </h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h5>¿Estás seguro de eliminar al vecino del evento?</h5>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-darte-cuenta btn_letra_negrita" data-bs-dismiss="modal" id="abrirNuevaModal">Si</button>
                        <button type="button" class="btn btn-primary btn_letra_negrita" data-bs-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="exampleModalLabel">Reportar al vecino</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!--<div class="mb-3">
                            <label for="fechaReporte" class="form-label">Fecha:</label>
                            <input type="date" class="form-control" id="fechaReporte">
                        </div>
                        <div class="mb-3">
                            <label for="eventoReporte" class="form-label">Evento:</label>
                            <input type="text" class="form-control" id="eventoReporte" placeholder="Ingrese el evento">
                        </div>-->
                        <div class="mb-3">
                            <label for="motivoReporte" class="form-label">Motivo:</label>
                            <textarea class="form-control" id="motivoReporte" rows="3" placeholder="Ingrese el motivo"></textarea>
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
        // Función para registrar el reporte
        document.getElementById('registrarReporte').addEventListener('click', function() {
            // Obtener los valores de los campos
            var fecha = document.getElementById('fechaReporte').value;
            var evento = document.getElementById('eventoReporte').value;
            var motivo = document.getElementById('motivoReporte').value;

            // Validar si los campos están vacíos
            if (fecha.trim() === '' || evento.trim() === '' || motivo.trim() === '') {
                alert('Por favor, complete todos los campos.');
            } else {
                // Mostrar los valores en la consola (puedes reemplazar esto con tu lógica de registro real)
                console.log('Fecha:', fecha);
                console.log('Evento:', evento);
                console.log('Motivo:', motivo);

                // Cerrar el modal
                var modal = bootstrap.Modal.getInstance(document.getElementById('exampleModal'));
                modal.hide();

                // Limpiar los campos después de registrar
                document.getElementById('fechaReporte').value = '';
                document.getElementById('eventoReporte').value = '';
                document.getElementById('motivoReporte').value = '';

                // Mostrar un mensaje de éxito (opcional)
                alert('Reporte registrado con éxito.');
            }
        });
    </script>
</body>
</html>