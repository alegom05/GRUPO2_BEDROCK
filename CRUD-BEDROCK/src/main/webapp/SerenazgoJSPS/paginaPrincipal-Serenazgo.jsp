<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 28/05/2024
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/SerenazgoJSPS/style-Serenazgo.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body>
<!-- Loader HTML -->

<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/assets/logos/logo_principal.png" alt="Logo" class="img-thumbnail">
            <h4 class="textoDeParteSuperiorIzquierda">¡Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h4 class="textoDeParteSuperiorDerecha"><%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br>Serenazgo Dispatcher</h4>
            <a href="<%=request.getContextPath()%>/LoginServlet?finish=yes">
                <img src="${pageContext.request.contextPath}/assets/icons/cerrar_sesion.png" alt="Cerrar Sesión" class="img-thumbnail imagen_cerrar" style="width: 50px;">
            </a>
        </div>
    </div>
    <nav class="letra_botones_encabezado" style="font-family: 'Lato',sans-serif">
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

<header id="top" role="banner" class="header">
    <div class="container-bootstrap">
        <h2 class="heading-4" style="font-family: 'Roboto Thin', sans-serif">Bienvenido personal de Serenazgo</h2>
    </div>

    <a id="searchAll2" href="${pageContext.request.contextPath}/Sereno?action=listaIncidencias" class="btn">
        <span class="display-6 text-light">¿Buscas las incidencia?</span>
        <p class="display-11 text-light text-left ml-1"> Te ayudamos
            <i focusable="false" data-fa-i2svg="">
                <svg class="svg-inline--fa fa-turn-up custom-icon" focusable="false" aria-hidden="true" data-prefix="fas" data-icon="turn-up" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg="">
                    <path fill="currentColor" d="M350 177.5c3.8-8.8 2-19-4.6-26l-136-144C204.9 2.7 198.6 0 192 0s-12.9 2.7-17.4 7.5l-136 144c-6.6 7-8.4 17.2-4.6 26s12.5 14.5 22 14.5h88l0 192c0 17.7-14.3 32-32 32H32c-17.7 0-32 14.3-32 32v32c0 17.7 14.3 32 32 32l80 0c70.7 0 128-57.3 128-128l0-192h88c9.6 0 18.2-5.7 22-14.5z"></path>
                </svg>
            </i>
        </p>
        <span class="sr-only"> ir al campo incidencias de la cabecera</span>
    </a>





</header>






<div class="container-fluid py-3" id="primerBloque">
    <h2 class="mb-4 text-center display-5" id="bicentenario">¡Nuestra misión como servicio de serenazgo!</h2>
    <div class="row mb-5 justify-content-center">
        <div class="col-12 col-xl-10">
            <div class="row m-0 p-0">
                <div class="col-12 col-xl-7 my-1">
                    <img src="${pageContext.request.contextPath}/assets/images/serenazgoMision.jpg" class="img-fluid p-2" alt="Imagen de serenazgos con su vehículo">
                </div>
                <div class="col-12 col-xl-5 my-4">
                    <p class="parrafoMision">En el corazón de San Miguel, nuestro compromiso es con la seguridad y la tranquilidad de cada uno de nuestros vecinos.
                        Como el servicio de serenazgo de la municipalidad, estamos dedicados a proteger y velar por el bienestar de nuestra comunidad
                        las 24 horas del día, los 7 días de la semana. Trabajamos incansablemente para asegurar que cada calle sea un lugar seguro para todos,
                        cultivando un ambiente de confianza y unión entre vecinos. Juntos, construimos un San Miguel más seguro y próspero para
                        todos.</p>
                    <div class="row">
                        <div class="col-12 col-lg-6 my-3">
                            <a href="" class="btn btn-outline-primary rounded w-100" title="Ir a la información" aria-label="Ir a la información">Tutorial para el uso del portal web</a>
                        </div>
                        <div class="col-12 col-lg-6 my-3">
                            <a href="" class="btn btn-outline-primary rounded w-100" title="Ir a la información" aria-label="Ir a la información">¿Recomendaciones? háznoslas saber</a>
                        </div>


                    </div>


                </div>
            </div>
        </div>
    </div>
</div>


<div class="pie_de_pagina container-fluid">
    <div class="row">
        <div class="col-md-4 d-flex">
            <div class="footer-section">
                <h4>Contacto con central de operaciones</h4>
                <h6>Teléfono (01) 715-9700</h6>
                <h6>Whastapp: 990024063</h6>

            </div>
        </div>

        <div class="col-md-4 text-center d-flex d-flex ">
            <div class="footer-section">
                <h4>Siguenos en nuestras redes: </h4>
                <a href="https://es-la.facebook.com/" target="_blank">
                    <img src="${pageContext.request.contextPath}/assets/logos/facebook.png" alt="Imagen 1" class="img-thumbnail">
                </a>
                <a href="https://www.instagram.com/" target="_blank">
                    <img src="${pageContext.request.contextPath}/assets/logos/instagram.png" alt="Imagen 2" class="img-thumbnail">
                </a>
                <a href="https://www.tiktok.com/es/" target="_blank">
                    <img src="${pageContext.request.contextPath}/assets/logos/tiktok.png" alt="Imagen 3" class="img-thumbnail">
                </a>
            </div>
        </div>

        <div class="col-md-4 d-flex align-items-center ">
            <div class="footer-section">
                <h4>¿Dónde ubicarnos?</h4>
                <h6> Central: Federico Gallese 370 - Lima - Lima - San Miguel - Perú</h6>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
