<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitudes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="./style-Admin.css" rel="stylesheet">

</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="./Administrador/assets/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;">Administrador</h2>
            <a href="login.html">
                <img src="Administrador/assets/logos/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail cerrar-sesion-img">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado">
        <ul class="nav">
            <li class="nav-item">
                <a href="paginaPrincipal-Admin.jsp" class="nav-link">Página principal</a>
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


<div class="container mt-4">
    <table id="miTabla2" class="table table-borderless">
        <thead>
        <tr>
            <th></th>
            <th>Miembros</th>
            <th style="width: 550px;"></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Filtrar por:</td>
            <td>
                <select id="filtroMiembro" style="border-color: #DFDFDF; border-radius: 6px; padding:10px; outline: none;" >
                    <option value="">Mostrar Todos</option>
                    <option value="Vecino">Vecino</option>
                    <option value="Coordinadora">Coordinadora</option>
                </select>
            </td>
            <td>
            </td>
            <td>
                <button id="limpiarFiltros" type="button" class="btn btn-outline-dark">Limpiar Filtros</button>
            </td>
        </tr>
        </tbody>
    </table>
    <br>
    <table id="miTabla" class="display">
        <thead class="cabecera-tabla">
        <tr>
            <th>Nombre</th>
            <th>DNI</th>
            <th>Correo</th>
            <th>Rol solicitado</th>
            <th >Acción a realizar</th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>ENRIQUE SIGIFREDO CENTENO MENDOZA</td>
            <td>12345678</td>
            <td>ecenteno@gmail.com</td>
            <td>Vecino</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>MARIA JOSE FRIERE ALMEIDA</td>
            <td>92345678</td>
            <td>mfriere@gmail.com</td>
            <td>Vecino</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>MONICA CRISTINA GUAMAN GUAMAN</td>
            <td>73345678</td>
            <td>mguaman@gmail.com</td>
            <td>Vecino</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>MARIO FRANCISCO JATIVA REYES</td>
            <td>68545678</td>
            <td>mjativa@gmail.com</td>
            <td>Vecino</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>FIDEL ANTONIO VISCAINO BURGOS </td>
            <td>73192458</td>
            <td>fviscaino@gmail.com</td>
            <td>Vecino</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>HECTOR PATRICIO TAPIA RAMIREZ</td>
            <td>78962589</td>
            <td>htapia@gmail.com</td>
            <td>Vecino</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>XIMENA ELIZABETH CAYAMBE BADILLO</td>
            <td>15697538</td>
            <td>xcayambe@gmail.com</td>
            <td>Coordinadora</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>SONIA LILIAN BERMEO AYNAGUANO</td>
            <td>75925658</td>
            <td>sbermeo@gmail.com</td>
            <td>Coordinadora</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>KAREN VIVIANA LUZARDO ALARCON</td>
            <td>16839756</td>
            <td>kluzardo@gmail.com</td>
            <td>Coordinadora</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>STEPHANIE JUDITH BADILLO HERRERA</td>
            <td>48632698</td>
            <td>sbadillo@gmail.com</td>
            <td>Coordinadora</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
        <tr>
            <td>ANA MILENA ARBELÁEZ HURTADO</td>
            <td>79863589</td>
            <td>aarbelaez@gmail.com</td>
            <td>Coordinadora</td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
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
                    "search": "Buscar:",
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
        });
    </script>
</div>
</body>
</html>

