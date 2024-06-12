<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JuntosPorSanMiguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <a href="${pageContext.request.contextPath}/AdministradorJSPS/paginaPrincipal-Admin.jsp" class="nav-link">Página principal</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/AdministradorJSPS/solicitudes-Admin.jsp" class="nav-link">Administración de solicitudes</a>
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

<header id="top" role="banner" class="header">
    <div class="container-bootstrap">
        <h2 class="heading-4">Bienvenido Administrador</h2>
    </div>

    <a id="searchAll2" href="<%=request.getContextPath()%>/Serenazgos" class="btn">
        <span class="display-6 text-light">¿Buscas la lista de Serenazgos?</span>
        <p class="display-11 text-light text-left ml-1"> Te ayudamos
            <i focusable="false" data-fa-i2svg="">
                <svg class="svg-inline--fa fa-turn-up custom-icon" focusable="false" aria-hidden="true" data-prefix="fas" data-icon="turn-up" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg="">
                    <path fill="currentColor" d="M350 177.5c3.8-8.8 2-19-4.6-26l-136-144C204.9 2.7 198.6 0 192 0s-12.9 2.7-17.4 7.5l-136 144c-6.6 7-8.4 17.2-4.6 26s12.5 14.5 22 14.5h88l0 192c0 17.7-14.3 32-32 32H32c-17.7 0-32 14.3-32 32v32c0 17.7 14.3 32 32 32l80 0c70.7 0 128-57.3 128-128l0-192h88c9.6 0 18.2-5.7 22-14.5z"></path>
                </svg>
            </i>
        </p>
        <span class="sr-only"> ir al campo lista de Serenazgos</span>
    </a>





</header>






<div class="container-fluid py-3" id="primerBloque">
    <h2 class="mb-4 text-center display-5" id="bicentenario">¡Nuestra misión como administrador!</h2>
    <div class="row mb-5 justify-content-center">
        <div class="col-12 col-xl-10">
            <div class="row m-0 p-0">

                <div class="col-12 col-xl-7 my-1">
                    <img src="${pageContext.request.contextPath}/Administrador/assets/fotos_pag_princ/fotomunicipalidad.jpg" class="img-fluid p-2" alt="Imagen de serenazgos con su vehículo">
                </div>
                <div class="col-12 col-xl-5 my-4">
                    <p class="parrafoMision">Como administrador de la página de San Miguel, su deber es garantizar un entorno seguro y organizado para la comunidad.
                        Esto implica revisar y aprobar solicitudes de manera eficiente y precisa, así como crear y gestionar los serenazgos de manera efectiva.
                        Su objetivo es trabajar en estrecha colaboración con la comunidad para mantener altos estándares de seguridad y calidad de vida en nuestra área,
                        facilitando la comunicación y la acción rápida en situaciones de emergencia.</p>
                    <div class="row">
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

        <div class="col-md-4 text-center d-flex d-flex justify-content-center">
            <div class="footer-section">
                <h4>Siguenos en nuestras redes: </h4>
                <a href="https://es-la.facebook.com/" target="_blank">
                    <img src="${pageContext.request.contextPath}/Administrador/assets/logos/facebook.png" alt="Imagen 1" class="img-thumbnail">
                </a>
                <a href="https://www.instagram.com/" target="_blank">
                    <img src="${pageContext.request.contextPath}/Administrador/assets/logos/instagram.png" alt="Imagen 2" class="img-thumbnail">
                </a>
                <a href="https://www.tiktok.com/es/" target="_blank">
                    <img src="${pageContext.request.contextPath}/Administrador/assets/logos/tiktok.png" alt="Imagen 3" class="img-thumbnail">
                </a>
            </div>
        </div>

        <div class="col-md-4 d-flex align-items-center justify-content-end">
            <div class="footer-section">
                <h4>¿Dónde ubicarnos?</h4>
                <h6> Central: Federico Gallese 370 - Lima - Lima - San Miguel - Perú</h6>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Selecciona el carousel
        var carousel = document.getElementById('carouselExample');

        // Crea un intervalo para cambiar de slide cada 5 segundos
        var carouselInterval = setInterval(function() {
            var activeIndex = document.querySelector('.carousel-item.active').getAttribute('data-bs-slide-to');
            var nextIndex = (parseInt(activeIndex) + 1) % carousel.querySelectorAll('.carousel-item').length;
            carousel.querySelector(`[data-bs-slide-to="${nextIndex}"]`).click();
        }, 3000);

        // Detiene el intervalo cuando el mouse entra al carousel
        carousel.addEventListener('mouseenter', function() {
            clearInterval(carouselInterval);
        });

        // Restablece el intervalo cuando el mouse sale del carousel
        carousel.addEventListener('mouseleave', function() {
            carouselInterval = setInterval(function() {
                var activeIndex = document.querySelector('.carousel-item.active').getAttribute('data-bs-slide-to');
                var nextIndex = (parseInt(activeIndex) + 1) % carousel.querySelectorAll('.carousel-item').length;
                carousel.querySelector(`[data-bs-slide-to="${nextIndex}"]`).click();
            }, 3000);
        });
    });
</script>
</body>
</html>

