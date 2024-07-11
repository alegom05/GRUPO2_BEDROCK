<%@ page import="com.example.grupo2.Beans.CantidadIncidencias" %>
<%@ page import="com.example.grupo2.Beans.Incidencia" %><%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 9/06/2024
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<% CantidadIncidencias cantidadIncidencias = (CantidadIncidencias) request.getAttribute("cantidad"); %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <link rel="preconnect" href="https://fonts.gstatic.com">

    <link rel="canonical" href="https://demo-basic.adminkit.io/" />

    <title>Dashboard</title>

    <link href="${pageContext.request.contextPath}/SerenazgoJSPS/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/SerenazgoJSPS/style-Serenazgo.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        .parteSuperiorText {
            margin-top: 10px;
            color: white; /* O el color que desees */
            font-size: 24px;
        }
        }
    </style>
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>

<body>
<div class="ParteSuperior" style="overflow-x: hidden ">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img style="margin-left: 10px" src="${pageContext.request.contextPath}/assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail">
            <h4 class="parteSuperiorText">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h4 class="parteSuperiorText" style="margin-top: 10px; margin-right: 40px; text-align: right; "><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%></h4>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado" style="font-family: Roboto,serif">
        <ul class="nav">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/SerenazgoJSPS/paginaPrincipal-Serenazgo.jsp" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/IncidenciaServlet?action=estadisticalizar" class="nav-link"> Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Usuario?action=actualizarS&id=<%= usuarioSesion.getId() %>" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/IncidenciaServlet" class="nav-link">Incidencias</a>
            </li>

        </ul>
    </nav>
</div>
<div class="wrapper" style="background-color: white;">


    <!-- Aquí en class iba el main debo corregirlo si quiero volver a ponerlo-->
    <!-- <div class="" style="background-color: white;" > -->
    <div class="main" >


        <main class="content">
            <div class="container-fluid p-0">

                <h1 class="h3 mb-3">Dashboard de <strong>Incidencias</strong></h1>

                <div class="row">
                    <div class="col-xl-6 col-xxl-5 d-flex">
                        <div class="w-100">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col mt-0">
                                                    <h5 class="card-title">Nuevas incidencias</h5>
                                                </div>

                                                <div class="col-auto">
                                                    <div class="stat text-primary">
                                                        <i class="align-middle" data-feather="bell"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <h1 class="mt-1 mb-3"><%=cantidadIncidencias.getCantidadNuevas()%></h1>
                                            <div class="mb-0">
                                                <!--<span class="text-danger">-3.65%</span>-->
                                                <span class="text-muted">Reportes recientes de eventos o problemas que requieren atención y seguimiento.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col mt-0">
                                                    <h5 class="card-title">Falsas alarmas</h5>
                                                </div>

                                                <div class="col-auto">
                                                    <div class="stat text-primary">
                                                        <i class="align-middle" data-feather="bell-off"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <h1 class="mt-1 mb-3"><%=cantidadIncidencias.getCatidadFalsasAlarmas()%></h1>
                                            <div class="mb-0">
                                                <!--<span class="text-success">5.25%</span>-->
                                                <span class="text-muted">Incidentes reportados que resultaron ser falsos o no representan una amenaza real.</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col mt-0">
                                                    <h5 class="card-title">Incidencias en proceso</h5>
                                                </div>

                                                <div class="col-auto">
                                                    <div class="stat text-primary">
                                                        <i class="align-middle" data-feather="zap"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <h1 class="mt-1 mb-3"><%=cantidadIncidencias.getCantidadEnProceso()%></h1>
                                            <div class="mb-0">
                                                <!--<span class="text-success">6.65%</span>-->
                                                <span class="text-muted">Problemas o eventos que están siendo abordados activamente y están en curso de resolución.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col mt-0">
                                                    <h5 class="card-title">Incidencias resueltas</h5>
                                                </div>

                                                <div class="col-auto">
                                                    <div class="stat text-primary">
                                                        <i class="align-middle" data-feather="check-square"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <h1 class="mt-1 mb-3"><%=cantidadIncidencias.getCantidadCerradas()%></h1>
                                            <div class="mb-0">
                                                <!--<span class="text-danger">-2.25%</span>-->
                                                <span class="text-muted">Problemas o eventos que han sido satisfactoriamente abordados y ya no requieren acción adicional.</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-6 col-xxl-7">
                        <div class="card flex-fill w-100">
                            <div class="card-header">

                                <h5 class="card-title mb-0">Incidencias Reportadas</h5>
                            </div>
                            <div class="card-body py-3">
                                <div class="chart chart-sm">
                                    <canvas id="chartjs-dashboard-line"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-md-6 col-xxl-3 d-flex order-1 order-xxl-1">
                        <div class="card flex-fill">
                            <div class="card-header">

                                <h5 class="card-title mb-0">Calendario</h5>
                            </div>
                            <div class="card-body d-flex">
                                <div class="align-self-center w-100">
                                    <div class="chart">
                                        <div id="datetimepicker-dashboard"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-12 col-xxl-6 d-flex order-3 order-xxl-2">
                        <div class="card flex-fill w-100">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Mapa</h5>
                            </div>
                            <iframe
                                    width="600"
                                    height="450"
                                    style="border:0"
                                    loading="lazy"
                                    allowfullscreen
                                    referrerpolicy="no-referrer-when-downgrade"
                                    src="https://www.openstreetmap.org/export/embed.html?bbox=-122.35422,47.61829,-122.34727,47.62163&layer=mapnik">
                                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB3FK1tQpOyxUYzE74Sxp0q7Gk9jUVchhU&libraries=places"></script>
                                    <%--var map = new google.maps.Map(document.getElementById('map-container'), {
                                    center: {lat: -33.8688, lng: 151.2093},
                                    zoom: 13,
                                    mapTypeId: 'roadmap'--%>
                            </iframe>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
                        <div class="card flex-fill w-100">
                            <div class="card-header">

                                <h5 class="card-title mb-0">Comparación de incidencias</h5>
                            </div>
                            <div class="card-body d-flex">
                                <div class="align-self-center w-100">
                                    <div class="py-3">
                                        <div class="chart chart-xs">
                                            <canvas id="chartjs-dashboard-pie"></canvas>
                                        </div>
                                    </div>

                                    <table class="table mb-0">
                                        <tbody>
                                        <tr>
                                            <td>Nuevas incidencias</td>
                                            <td class="text-end"><%=cantidadIncidencias.getCantidadNuevas()%></td>
                                        </tr>
                                        <tr>
                                            <td>Incidencias en proceso</td>
                                            <td class="text-end"><%=cantidadIncidencias.getCantidadEnProceso()%></td>
                                        </tr>
                                        <tr>
                                            <td>Falsas alarmas</td>
                                            <td class="text-end"><%=cantidadIncidencias.getCatidadFalsasAlarmas()%></td>
                                        </tr>
                                        <tr>
                                            <td>Incidencias resueltas</td>
                                            <td class="text-end"><%=cantidadIncidencias.getCantidadCerradas()%></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </main>


    </div>


</div>


<script src="${pageContext.request.contextPath}/SerenazgoJSPS/app.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var ctx = document.getElementById("chartjs-dashboard-line").getContext("2d");
        var gradient = ctx.createLinearGradient(0, 0, 0, 225);
        gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
        gradient.addColorStop(1, "rgba(215, 227, 244, 0)");
        // Line chart
        new Chart(document.getElementById("chartjs-dashboard-line"), {
            type: "line",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Sales ($)",
                    fill: true,
                    backgroundColor: gradient,
                    borderColor: window.theme.primary,
                    data: [
                        11,
                        22,
                        34,
                        41,
                        56,
                        68,
                        75,
                        89,
                        92,
                        95,
                        97,
                        100
                    ]
                }]
            },
            options: {
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                tooltips: {
                    intersect: false
                },
                hover: {
                    intersect: true
                },
                plugins: {
                    filler: {
                        propagate: false
                    }
                },
                scales: {
                    xAxes: [{
                        reverse: true,
                        gridLines: {
                            color: "rgba(0,0,0,0.0)"
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            stepSize: 1000
                        },
                        display: true,
                        borderDash: [3, 3],
                        gridLines: {
                            color: "rgba(0,0,0,0.0)"
                        }
                    }]
                }
            }
        });
    });
</script>
<!--Gráfico circular -->
<!--
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Pie chart
        new Chart(document.getElementById("chartjs-dashboard-pie"), {
            type: "pie",
            data: {
                labels: ["Chrome", "Firefox", "IE"],
                datasets: [{
                    data: [4306, 3801, 1689],
                    backgroundColor: [
                        window.theme.primary,
                        window.theme.warning,
                        window.theme.danger
                    ],
                    borderWidth: 5
                }]
            },
            options: {
                responsive: !window.MSInputMethodContext,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                cutoutPercentage: 75
            }
        });
    });
</script> -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/es.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        flatpickr("#datetimepicker-dashboard", {
            inline: true,
            prevArrow: "<span title=\"Mes anterior\">&laquo;</span>",
            nextArrow: "<span title=\"Mes siguiente\">&raquo;</span>",
            locale: "es"
        });
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Pie chart
        new Chart(document.getElementById("chartjs-dashboard-pie"), {
            type: "pie",
            data: {
                labels: ["Nuevas", "En proceso", "Falsas alarmas","Cerradas"],
                datasets: [{
                    data: ['<%=cantidadIncidencias.getCantidadNuevas()%>', '<%=cantidadIncidencias.getCantidadEnProceso()%>', '<%=cantidadIncidencias.getCatidadFalsasAlarmas()%>','<%=cantidadIncidencias.getCantidadCerradas()%>'],
                    backgroundColor: [
                        window.theme.primary,
                        window.theme.warning,
                        window.theme.danger
                    ],
                    borderWidth: 5
                }]
            },
            options: {
                responsive: !window.MSInputMethodContext,
                maintainAspectRatio: false,
                legend: {
                    display: false
                },
                cutoutPercentage: 75
            }
        });
    });
</script>

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

<div id="map" style="height: 400px;"></div>

<script>
    var map = L.map('map').setView([-12.0789, -77.0828], 13); // Coordenadas de San Miguel, Lima

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);
    <%--
    <% for(Incidencia incidencia : listaIncidencias) { %>
    L.marker([<%= incidencia.getLatitud() %>, <%= incidencia.getLongitud() %>])
        .addTo(map)
        .bindPopup("<%= incidencia.getDescripcion() %>");
    <% } %>--%>OP
</script>

</body>

</html>

