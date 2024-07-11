<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<jsp:useBean type="java.util.ArrayList<com.example.grupo2.Beans.Incidencia>" scope="request" id="incidencia"/>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
        <link href="${pageContext.request.contextPath}/VecinosJSPS/style-Vecino.css" rel="stylesheet">
        <title>Lista de Incidencias</title>
    </head>
    <body>
        <div class="ParteSuperior" style="overflow-x: hidden">
            <div class="row">
                <div class="col-md-3 d-flex justify-content-start align-items-center">
                    <img src="${pageContext.request.contextPath}/assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
                    <h4 style="margin-top: 10px;" >¡Juntos Por<br>San Miguel!</h4>
                </div>
                <div class="col-md-9 d-flex align-items-center justify-content-end">
                    <a href="<%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=<%=usuarioSesion.getId()%>">
                        <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
                    </a>
                    <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%></h2>
                    <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                        <img src="${pageContext.request.contextPath}/assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar">
                    </a>
                </div>
            </div>
            <nav class="letra_botones_encabezado">
                <ul class="nav">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/VecinoIndexServlet" class="nav-link">Municipalidad</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/EventoServlet?action=listarEventoFiltrado" class="nav-link">Eventos</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=formCrear" class="nav-link">Reportar Incidencia</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=lista3&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/EventoServlet?action=calendario&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Mira Tu Calendario!</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/EventoServlet?action=listaEventosVecino&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Historial De Eventos</a>
                    </li>
                </ul>
            </nav>
        </div>


        <div class="mt-4" style="">
            <!-- Contenido con imagen centrada -->
            <h2 style="text-align: center;">Incidencias Registradas este mes</h2>
            <div class="container mt-4">

                <div style="display: flex; justify-content: space-between;">
                    <select id="filtroIncidencia" style="border-color: #DFDFDF; border-radius: 6px; padding:10px; outline: none; width: 130px; height: 50px;" >
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
                <div class="tabla-container">
                    <table id="miTabla" class="display">
                        <thead>
                            <tr>
                                <th>Tipo De Incidencia</th>
                                <th>Nombre</th>
                                <th>Fecha</th>
                                <th>Lugar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Incidencia incidencia1 : incidencia) { %>

                            <tr>
                                <td><%=incidencia1.getTipoIncidencia()%></td>
                                <td><%=incidencia1.getNombreIncidencia()%></td>
                                <td><%=incidencia1.getFechaIncidencia()%></td>
                                <td><%=incidencia1.getLugar()%></td>
                            </tr>
                            <%  }  %>
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
                            "info": "Mostrando de _START_ a _END_ de _TOTAL_ entradas",
                            "infoFiltered": "(filtrado de _MAX_ entradas totales)"
                        }

                    });
                    $('.dataTables_filter input').css('margin-bottom', '20px');
                    $('#miTabla thead').css({
                        'background-image': 'linear-gradient(0deg, rgba(8,67,148,1) 0%, rgba(38,149,226,1) 100%)',
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
        </div>
    </body>
</html>
