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
                <a href="${pageContext.request.contextPath}/AdminIndexServlet" class="nav-link">Página principal</a>
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

    </header>



<div class="container-fluid py-3" id="primerBloque">
    <h2 class="mb-4 text-center display-5" id="bicentenario">¡Nuestra misión como administrador!</h2>
</div>
    <div class="contenedor mt-4">
        <div class="contenedor mt-2 row align-items-center custom-cartanz">
            <div class="col-md-5 d-flex justify-content-center">
                <img src="${pageContext.request.contextPath}/Administrador/assets/fotos_pag_princ/fotomunicipalidad.jpg" alt="Imagen" class="img-muni">
            </div>
            <div class="col-md-7">
                <h3 class="parrafoMision">Como administrador de la página de San Miguel su objetivo es trabajar en estrecha colaboración con la comunidad para mantener altos estándares de seguridad y calidad de vida en nuestra área
                    Esto implica revisar y aprobar solicitudes de manera eficiente y precisa, así como crear y gestionar los serenazgos de manera efectiva.</h3>
            </div>
        </div>
    </div>
<br>

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

