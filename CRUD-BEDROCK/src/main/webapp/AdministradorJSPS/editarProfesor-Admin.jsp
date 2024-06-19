<%--
  Created by IntelliJ IDEA.
  User: Usuario
  Date: 19/06/2024
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="profesores" scope="request" type="com.example.grupo2.Beans.Profesores" />

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar serenazgo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link href="${pageContext.request.contextPath}/AdministradorJSPS/style-Admin.css" rel="stylesheet">
        <style>
        </style>
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

        <div class="col">
            <div class="card-body p-md-5 mx-md-4">

                <form class="needs-validation" style="width: 100%; margin-left: 0%; margin-top: 3%;" action="<%=request.getContextPath()%>/Profesores?a=actualizar" method="POST" novalidate>
                    <div class="container">
                        <h2>Editar Profesor</h2>
                        <input type="hidden" name="id" value="<%=profesores.getId()%>" />
                        <div class="container" style="margin-top: 3%; ">
                            <div class="row">
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="nombre" class="form-label">Nombres: (*)</label>
                                        <input type="text" name="nombre" id="nombre" value="<%=profesores.getNombre()%>" class="form-control" readonly>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="apellido" class="form-label">Apellidos: (*)</label>
                                        <input type="text" name="apellido" id="apellido" class="form-control" value="<%=profesores.getApellido()%>" aria-describedby="emailHelp" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="mb-3">
                                        <div class="mb-3">
                                            <label for="curso" class="form-label">Curso: (*)</label><br>
                                            <select id="curso" name="curso" class="form-select" required>
                                                <option value="Yoga para adultos mayores, embarazadas y jóvenes" <%= "Yoga para adultos mayores, embarazadas y jóvenes".equals(profesores.getCurso()) ? "selected" : "" %>>Yoga para adultos mayores, embarazadas y jóvenes</option>
                                                <option value="Competencia de fútbol" <%= "Competencia de fútbol".equals(profesores.getCurso()) ? "selected" : "" %>>Competencia de fútbol</option>
                                                <option value="Competencia de vóley" <%= "Competencia de vóley".equals(profesores.getCurso()) ? "selected" : "" %>>Competencia de vóley</option>
                                                <option value="Competencia de Atletismo" <%= "Competencia de Atletismo".equals(profesores.getCurso()) ? "selected" : "" %>>Competencia de Atletismo</option>
                                                <option value="Carrera de tres pies" <%= "Carrera de tres pies".equals(profesores.getCurso()) ? "selected" : "" %>>Carrera de tres pies</option>
                                                <option value="Festival de juegos familiares" <%= "Festival de juegos familiares".equals(profesores.getCurso()) ? "selected" : "" %>>Festival de juegos familiares</option>
                                                <option value="Juegos deportivos para los niños" <%= "Juegos deportivos para los niños".equals(profesores.getCurso()) ? "selected" : "" %>>Juegos deportivos para los niños</option>
                                            </select>
                                            <div class="invalid-feedback">Por favor escoja una opción.</div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btn-container">
                        <button type="submit" class="btn btn-outline-primary" style="width: 280px;">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <!-- Incluir los archivos JavaScript de Bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script>
            document.querySelector('.form-login').addEventListener('submit', function(event) {
                event.preventDefault(); // Evitar el envío del formulario
                window.location.href = 'serenazgos.html';
            });
        </script>
        <script>
            var forms = document.querySelectorAll('.needs-validation');

            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }

                    form.classList.add('was-validated');
                }, false);
            });
            // Validar que solo se ingresen letras en los campos de nombre y apellidos
            document.addEventListener("input", function(event) {
                if (event.target && event.target.id === "nombre") {
                    event.target.value = event.target.value.replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ\s]/g, "");
                } else if (event.target && event.target.id === "apellidos") {
                    event.target.value = event.target.value.replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ\s]/g, "");
                }
            });



        </script>
    </body>
</html>
