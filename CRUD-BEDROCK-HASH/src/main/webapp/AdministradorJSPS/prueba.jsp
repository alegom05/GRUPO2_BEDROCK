<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Usuario" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean type="java.util.ArrayList<com.example.grupo2.Beans.Usuario>" scope="request" id="serenazgos"/>
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
                        <a href="solicitudes-Admin.jsp" class="nav-link">Administración de solicitudes</a>
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
                    <button id="limpiarFiltros" type="button" class="btn btn-outline-dark">Limpiar Filtros</button>
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
                    <% for (Usuario serenazgo1 : serenazgos) { %>
                    <tr>
                        <td><%=serenazgo1.getNombre()%></td>
                        <td><%=serenazgo1.getApellido()%></td>
                        <td><%=serenazgo1.getDni()%></td>
                        <td><%=serenazgo1.getCorreo()%></td>
                        <td><%=serenazgo1.getDireccion()%></td>
                        <td>
                            <% if ("VE".equals(serenazgo1.getRol())) { %>
                            Vecino
                            <% } else { %>
                            Coordinadora
                            <% } %>
                        </td>
                        <td><a href="<%=request.getContextPath()%>/Serenazgos?a=editar&id=<%=serenazgo1.getId() %>" class="btn btn-outline-secondary"><img src="${pageContext.request.contextPath}/Administrador/assets/icons/pencil.svg" alt="Editar"></a></td>
                        <td><button onclick="setSerenazgoId('<%= serenazgo1.getId() %>')" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal"><img src="${pageContext.request.contextPath}/Administrador/assets/icons/trash.svg" alt="Eliminar"></button></td>
                    </tr>
                    <%  }  %>
                    <tr>
                        <td>JAIME DANIEL SANTOS BALON</td>
                        <td>23456789</td>
                        <td>asantos@gmail.com</td>
                        <td>Vecino</td>
                        <td>
                            <div class="dropdown">
                                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                    <li><a class="dropdown-item" href="#">Aprobar</a></li>
                                    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#exampleModal" href="#">Eliminar</a></li>
                                    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#exampleModal" href="#">Banear</a></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Advertencia</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ¿Está seguro que desea realizar la acción indicada?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-danger">Sí</button>
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
                    table.column(3).search(miembro).draw();
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
    </body>
</html>
