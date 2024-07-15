<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page import="com.example.grupo2.daos.EventoDao" %>
<%@ page import="java.util.ArrayList" %>

<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>
<%
    EventoDao eventosDAO = new EventoDao();
    ArrayList<Evento> eventos_populares = eventosDAO.listarEventos_populares();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Juntos Por San Miguel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
</head>
<body>
<div class="ParteSuperior container-fluid">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail" style="margin-right: 10px;">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <a href="javascript:void(0)" onclick="detallesUsuario('<%=usuarioSesion.getId()%>')">
                <!--href="%=request.getContextPath()%>/VecinoIndexServlet?action=editar&id=%=usuarioSesion.getId()%>"-->
                <img src="${pageContext.request.contextPath}/logos-Vecino/R-removebg-preview.png" style="margin-right: 10px;" alt="" class="img-thumbnail imagen_cerrarsesion">
            </a>
            <div class="usuario-info" style="margin-right: 1.2rem">
                <%
                    String tipoUsuario = usuarioSesion.getTipo();
                    String rol = "Coordinadora de " + tipoUsuario.toLowerCase();
                %>
                <h3 style=" text-align: right;">
                    <%=usuarioSesion.getNombre()%> <%=usuarioSesion.getApellido()%><br><%=rol%>
                </h3>
            </div>
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
                <a href="javascript:void(0)" onclick="historialEventos('<%=usuarioSesion.getTipo()%>')" class="nav-link">Historial De Eventos</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/Coordis?action=listarve" class="nav-link">Lista de Vecinos</a>
            </li>
        </ul>
    </nav>
</div>

    <div class="contenedor mt-4">
        <div class="col-md-7 d-flex align-items-center contenedor">
            <h2 class="texto_titulos">Últimos Eventos en San Miguel</h2>
        </div>
        <div id="carouselExample" class="carousel slide contenedor mt-2" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <%
                        boolean isActive = true;
                        for (Evento evento : eventos_populares) {
                    %>
                    <div class="carousel-item <%= isActive ? "active" : "" %>">
                        <div class="imagen-container">
                            <div class="row">
                                <div class="col-md-6 div-50 d-flex">
                                    <div>
                                        <h1 class="texto-con-imagen"><%= evento.getNombre() %></h1>
                                        <h4 class="texto-con-imagen">Fecha: <br> <%= evento.getFechaInicial() %> <br> Hora: <br> <%= evento.getHora() %> <br> Lugar: <br> <%= evento.getLugar() %></h4>
                                        <div class="d-flex mt-4">
                                            <a href="${pageContext.request.contextPath}/Coordis?action=detallarParaCoordi&id=<%= evento.getIdEvento() %>" class="btn btn-primary"><h7>Más Información</h7></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 d-flex">
                                    <img src="${pageContext.request.contextPath}/Coordis?action=verFotoEvento&id=<%= evento.getIdEvento() %>" alt="Imagen" class="img-fluid rounded">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                            isActive = false;
                        }
                    %>

            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <div class="contenedor mt-4">
            <div class="col-md-7 d-flex align-items-center contenedor">
                <h2 class="texto_titulos">Municipalidad de San Miguel</h2>
            </div>
            <div class="contenedor mt-2 row align-items-center fondo_recuadros">
                <div class="col-md-5 d-flex justify-content-center">
                    <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/fotos_pag_princ/fotomunicipalidad.jpg" alt="Imagen" class="img-muni">
                </div>
                <div class="col-md-7">
                    <h3 class="custom-h3">¡Bienvenidos a la página oficial de la Municipalidad de San Miguel! Somos el equipo encargado de brindarte seguridad y bienestar en tu comunidad. Nuestro compromiso es velar por tu tranquilidad y la de tu familia, gestionando servicios y programas que mejoren la calidad de vida en nuestro distrito. ¡Contáctanos para conocer más sobre cómo trabajamos juntos por un San Miguel seguro y próspero para todos!</h3>
                </div>
            </div>
            <div>
                <div class="row">
                    <div class="col-md-6">
                        <!--<div class="contenedor mt-4 d-flex align-items-center">
                            <h4 class="align-self-center">Tuviste o viste algún inconveniente en el distrito?</h4>
                            <a href="${pageContext.request.contextPath}/Coordis?action=formCrearIncidencia" class="btn btn-primary izquierda"><h7>Reporta Aquí!</h7></a>
                        </div>-->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pie_de_pagina">
        <div class="row">
            <div class="col-md-4 d-flex">
                <div class="footer-section">
                    <h4>Números de emergencia</h4>
                    <h6>Emergencia: 105</h6>
                    <h6>Bomberos: 105</h6>
                    <h6>Serenazgo: 715-9700</h6>
                </div>
            </div>

            <div class="col-md-4 text-center d-flex d-flex justify-content-center">
                <div class="footer-section">
                    <h4>Siguenos en nuestras redes: </h4>
                    <a href="https://www.facebook.com/municipalidadsanmiguel/?locale=es_LA" target="_blank">
                        <img  src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/facebook.png" alt="Imagen 1" class="img-thumbnail">
                    </a>
                    <a href="https://www.instagram.com/municipalidadsanmiguel/" target="_blank">
                        <img  src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/instagram.png" alt="Imagen 2" class="img-thumbnail">
                    </a>
                    <a href="https://www.tiktok.com/@munisanmiguel" target="_blank">
                        <img src="${pageContext.request.contextPath}/CoordinadorasJSPS/logos/tiktok.png" alt="Imagen 3" class="img-thumbnail">
                    </a>
                </div>
            </div>

            <div class="col-md-4 d-flex align-items-center justify-content-end">
                <div class="footer-section">
                    <h4>Dónde ubicarnos?</h4>
                    <h6> Central: Federico Gallese 370 - Lima - Lima - San Miguel - Perú</h6>
                </div>
            </div>
        </div>

    <!-- Script de Bootstrap -->
    <script src="/https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Script personalizado -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Selecciona el carousel
            var carousel = document.getElementById('carouselExample');

            // Crea un intervalo para cambiar de slide cada 5 segundos
            var carouselInterval = setInterval(function() {
                var activeIndex = document.querySelector('.carousel-item.active').getAttribute('data-bs-slide-to');
                var nextIndex = (parseInt(activeIndex) + 1) % carousel.querySelectorAll('.carousel-item').length;
                carousel.querySelector(`[data-bs-slide-to="${nextIndex}"]`).click();
            }, 5000);

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
                }, 5000);
            });
        });
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
                input.name = 'tipoUsuario';
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


    </div>
</body>
</html>