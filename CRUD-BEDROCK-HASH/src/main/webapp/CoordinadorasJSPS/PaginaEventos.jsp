<%@ page import="java.util.ArrayList" %>

<%@ page import="com.example.grupo2.Beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="usuarioSesion" scope="session" type="com.example.grupo2.Beans.Usuario" class="com.example.grupo2.Beans.Usuario"/>

<%
    Evento evento = (Evento) request.getAttribute("listarev");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/CoordinadorasJSPS/index.css" rel="stylesheet">
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
                    <a href="${pageContext.request.contextPath}/CoordisIndexServlet" class="nav-link">Municipalidad</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/EventoServlet" class="nav-link">Eventos</a>
                </li>
                <li class="nav-item">
                    <a href="ReportarIncidencia.html" class="nav-link">Reportar Incidencia</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Incidencias?action=listaCoordi&idUsuario=<%=usuarioSesion.getId()%>" class="nav-link">Lista de Incidencias</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/CoordisCalendarioServlet" class="nav-link">Mira Tu Calendario!</a>
                </li>
                <li class="nav-item">
                    <a href="HistorialDeEventos.html" class="nav-link">Historial De Eventos</a>
                </li>
                <li class="nav-item">
                    <a href="VecinoSanmi.jsp" class="nav-link">Lista de Vecinos</a>
                </li>
            </ul>
        </nav>             
    </div>

    <div class="contenedor imagen-container mt-4 ">
        <div class="row mt-4 custom-cartanz-2">
            
            <div class="col">
                
                <div class="col-md-12">
                    <input type="text" id="inputBuscar" class="form-control" placeholder="Buscar eventos...">
                </div>
             </div>

            <div class="col-md-3">
                <button onclick="buscarEventos()" class="btn btn-primary">Buscar</button>
            </div>

            
            <div class="col d-flex justify-content-end">
                <a href="CrearEvento.html" class="btn btn-primary"><h7>Crear evento</h7></a>
            </div>

        </div>

        <div class="row mt-3 custom-cartanz-2">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/EventosDetallado1.html" class="card-link">
                    <div class="card shadow">
                        <img src="${pageContext.request.contextPath}/imagenes_eventos/deporte/evento1.jpg" alt="Evento 1" class="card-img-top w-100">
                        <div class="card-body">
                            <h5 class="card-title">Maraton de San Miguel</h5>
                            <p class="card-text">30/08/2024</p>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-md-4 custom-cartanz-2">
                <a href="./EventosDetallado2.html" class="card-link">
                    <div class="card shadow">
                        <img src="${pageContext.request.contextPath}/imagenes_eventos/deporte/evento2.jpg" alt="Evento 2" class="card-img-top w-100">
                        <div class="card-body">
                            <h5 class="card-title">Torneo de futbol juvenil</h5>
                            <p class="card-text">25/08/2024</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 custom-cartanz-2">
                <a href="./EventosDetallado3.html" class="card-link">
                    <div class="card shadow">
                        <img src="${pageContext.request.contextPath}/imagenes_eventos/deporte/evento3.jpg" alt="Evento 3" class="card-img-top w-100">
                        <div class="card-body">
                            <h5 class="card-title">Carrera de ciclismo</h5>
                            <p class="card-text">15/08/2024</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mt-4 custom-cartanz-2">
                <a href="./EventosDetallado4.html" class="card-link">
                    <div class="card shadow">
                        <img src="${pageContext.request.contextPath}/imagenes_eventos/deporte/evento4.jpg" alt="Evento 4" class="card-img-top w-100">
                        <div class="card-body">
                            <h5 class="card-title">Torneo Raqueta Dorada</h5>
                            <p class="card-text">03/08/2024</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mt-4 custom-cartanz-2">
                <a href="./EventosDetallado5.html" class="card-link">
                    <div class="card shadow">
                        <img src="./imagenes_eventos/deporte/evento5.jpg" alt="Evento 5" class="card-img-top w-100">
                        <div class="card-body">
                            <h5 class="card-title">Copa San Miguel</h5>
                            <p class="card-text">24/07/2024</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mt-4 custom-cartanz-2">
                <a href="./EventosDetallado6.html" class="card-link">
                    <div class="card shadow">
                        <img src="./imagenes_eventos/deporte/evento6.jpg" alt="Evento 6" class="card-img-top w-100">
                        <div class="card-body">
                            <h5 class="card-title">Clases de Yoga</h5>
                            <p class="card-text">18/07/2024</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col">
                <nav aria-label="Page navigation" class="no_colocar_fondo mb-3">
                    <ul class="pagination justify-content-end">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item"><a class="page-link" href="PaginaEventos.html">1</a></li>
                        <li class="page-item"><a class="page-link" href="PaginaEventos2.html">2</a></li>
                        <li class="page-item"><a class="page-link" href="PaginaEventos3.html">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <!-- Script de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función para filtrar eventos por búsqueda
        function buscarEventos() {
            // Obtener el texto de búsqueda
            var textoBuscar = document.getElementById('inputBuscar').value.toLowerCase();

            // Obtener todos los elementos de eventos
            var eventos = document.querySelectorAll('.card-title');

            // Iterar sobre los elementos de eventos y mostrar/ocultar según la búsqueda
            eventos.forEach(function(evento) {
                var nombreEvento = evento.textContent.toLowerCase();
                var tarjetaEvento = evento.parentElement.parentElement.parentElement.parentElement; // Obtener el elemento de tarjeta de evento

                // Mostrar la tarjeta de evento si coincide con la búsqueda, ocultarla de lo contrario
                if (nombreEvento.includes(textoBuscar)) {
                    tarjetaEvento.style.display = 'block';
                } else {
                    tarjetaEvento.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>





