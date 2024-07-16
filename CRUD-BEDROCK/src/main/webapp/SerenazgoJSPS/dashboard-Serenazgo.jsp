<%@ page import="com.example.grupo2.Beans.CantidadIncidencias" %>
<%@ page import="com.example.grupo2.Beans.Incidencia" %>
<%@ page import="com.example.grupo2.Beans.IncidenciasPorMes" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 9/06/2024
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<% CantidadIncidencias cantidadIncidencias = (CantidadIncidencias) request.getAttribute("cantidad"); %>
<% IncidenciasPorMes incidenciasPorMes = (IncidenciasPorMes) request.getAttribute("porMes"); %>

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
                <a href="${pageContext.request.contextPath}/SerenazgoIndexServlet" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/Sereno?action=estadisticalizarIncidencias" class="nav-link"> Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Sereno?action=actualizarS&id=<%= usuarioSesion.getId() %>" class="nav-link">Actualizar información</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Sereno?action=listaIncidencias" class="nav-link">Incidencias</a>
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

                    <div class="col-xl-6 col-xxl-9">
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
                                <h5 class="card-title mb-0">Mapa de San Miguel</h5>
                            </div>
                            <div class="card-body">
                                <div id="map" style="height: 400px; width: 100%;"></div>
                            </div>
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
        gradient.addColorStop(0, "rgba(54, 162, 235, 0.8)");
        gradient.addColorStop(1, "rgba(54, 162, 235, 0.6)");
        // Bar chart
        new Chart(document.getElementById("chartjs-dashboard-line"), {
            type: "bar",
            data: {
                labels: ["En", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Incidencias reportadas",
                    fill: true,
                    backgroundColor: gradient,
                    borderColor: window.theme.primary,
                    data: [
                        '<%=incidenciasPorMes.getEneroIncidencias()%>',
                        '<%=incidenciasPorMes.getFebreroIncidencias()%>',
                        '<%=incidenciasPorMes.getMarzoIncidencias()%>',
                        '<%=incidenciasPorMes.getAbrilIncidencias()%>',
                        '<%=incidenciasPorMes.getMayoIncidencias()%>',
                        '<%=incidenciasPorMes.getJunioIncidencias()%>',
                        '<%=incidenciasPorMes.getJulioIncidencias()%>',
                        '<%=incidenciasPorMes.getAugustIncidencias()%>',
                        '<%=incidenciasPorMes.getSeptiemIncidencias()%>',
                        '<%=incidenciasPorMes.getOctopusIncidencias()%>',
                        '<%=incidenciasPorMes.getNovemIncidencias()%>',
                        '<%=incidenciasPorMes.getDezemIncidencias() %>'
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

<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />

<script>
    var map = L.map('map').setView([-12.0789, -77.0828], 13);

    var sanMiguelBoundaries = {
        "type": "Feature",
        "properties": {"name": "San Miguel"},
        "geometry": {
            "type": "Polygon",
            "coordinates": [[
                [-77.1015, -12.0670],
                [-77.0950, -12.0670],
                [-77.0880, -12.0700],
                [-77.0800, -12.0750],
                [-77.0750, -12.0830],
                [-77.0700, -12.0900],
                [-77.0750, -12.0950],
                [-77.0850, -12.0980],
                [-77.0950, -12.0950],
                [-77.1000, -12.0900],
                [-77.1050, -12.0800],
                [-77.1015, -12.0670]
            ]]
        }
    };

    L.geoJSON(sanMiguelBoundaries, {
        style: {
            color: "#ff7800",
            weight: 3,
            opacity: 0.65,
            fillOpacity: 0.2
        }
    }).addTo(map);

    // Ajustar la vista del mapa a los límites de San Miguel

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    var comisarias = [
        {nombre: "Serenazgo Av. de la Marina 2400", lat: -12.077639, lon: -77.088194},
        {nombre: "Serenazgo Chicama 177", lat: -12.077611, lon: -77.104389},
        {nombre: "Serenazgo Plaza San Miguel", lat: -12.066917, lon: -77.093833},
        {nombre: "Serenazgo Precursores Av. los Insurgentes 714", lat: -12.068194, lon: -77.103944}
    ];

    var serenazgoIcon = L.icon({
        iconUrl: '${pageContext.request.contextPath}/assets/icons/serenazgo_icon.png',
        iconSize: [32, 32],
        iconAnchor: [16, 32],
        popupAnchor: [0, -32]
    });

    comisarias.forEach(function(comisaria) {
        L.marker([comisaria.lat, comisaria.lon], {icon: serenazgoIcon})
            .addTo(map)
            .bindTooltip(comisaria.nombre, {permanent: false, direction: 'top'});
    });

    // Código existente para añadir marcadores de incidencias
    var meses = [
        // ... (tu array de meses e incidencias) ...
    ];

    meses.forEach(function(mes, index) {
        var lat = -12.0789 + (Math.random() - 0.5) * 0.02;
        var lng = -77.0828 + (Math.random() - 0.5) * 0.02;

        var radius = Math.sqrt(mes.incidencias) * 2;
        var color = "red";

        L.circleMarker([lat, lng], {
            color: 'white',
            weight: 3,
            fillColor: color,
            fillOpacity: 0.8,
            radius: radius,
            opacity: 1
        }).addTo(map)
            .bindPopup(mes.nombre + ": " + mes.incidencias + " incidencias");
    });
</script>

<script>
    var map = L.map('map').setView([-12.0789, -77.0828], 13); // Coordenadas de San Miguel, Lima

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    var meses = [
        {nombre: "Enero", incidencias: <%= incidenciasPorMes.getEneroIncidencias() %>},
        {nombre: "Febrero", incidencias: <%= incidenciasPorMes.getFebreroIncidencias() %>},
        {nombre: "Marzo", incidencias: <%= incidenciasPorMes.getMarzoIncidencias() %>},
        {nombre: "Abril", incidencias: <%= incidenciasPorMes.getAbrilIncidencias() %>},
        {nombre: "Mayo", incidencias: <%= incidenciasPorMes.getMayoIncidencias() %>},
        {nombre: "Junio", incidencias: <%= incidenciasPorMes.getJunioIncidencias() %>},
        {nombre: "Julio", incidencias: <%= incidenciasPorMes.getJulioIncidencias() %>},
        {nombre: "Agosto", incidencias: <%= incidenciasPorMes.getAugustIncidencias() %>},
        {nombre: "Septiembre", incidencias: <%= incidenciasPorMes.getSeptiemIncidencias() %>},
        {nombre: "Octubre", incidencias: <%= incidenciasPorMes.getOctopusIncidencias() %>},
        {nombre: "Noviembre", incidencias: <%= incidenciasPorMes.getNovemIncidencias() %>},
        {nombre: "Diciembre", incidencias: <%= incidenciasPorMes.getDezemIncidencias() %>}
    ];

    meses.forEach(function(mes, index) {
        var lat = -12.0789 + (Math.random() - 0.5) * 0.02;
        var lng = -77.0828 + (Math.random() - 0.5) * 0.02;

        var radius = Math.sqrt(mes.incidencias) * 2; // Ajusta el factor de escala según necesites
        var color = "red"; // Puedes ajustar el color según tus necesidades

        L.circleMarker([lat, lng], {
            color: 'white',          // Color del borde
            weight: 3,               // Grosor del borde
            fillColor: color,        // Color de relleno (rojo, amarillo o verde según la criticidad)
            fillOpacity: 0.8,        // Opacidad del relleno
            radius: radius,          // Radio del círculo
            opacity: 1
        }).addTo(map)
            .bindPopup(mes.nombre + ": " + mes.incidencias + " incidencias");
    });
</script>

</body>

</html>

