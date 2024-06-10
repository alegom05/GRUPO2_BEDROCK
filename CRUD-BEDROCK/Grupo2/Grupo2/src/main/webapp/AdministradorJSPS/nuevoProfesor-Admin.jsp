<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Creación profesor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/AdministradorJSPS/style-Admin.css" rel="stylesheet">
    <style>
    </style>
</head>
<body>
<div class="ParteSuperior">
    <div class="row">
        <div class="col-md-3 d-flex justify-content-start align-items-center">
            <img src="${pageContext.request.contextPath}/Administrador/assets/logos/logo_pag_principal.png" alt="Logo" class="img-thumbnail">
            <h4 style="margin-top: 10px;">Juntos Por<br>San Miguel!</h4>
        </div>
        <div class="col-md-9 d-flex align-items-center justify-content-end">
            <h2 style="margin-top: 10px; margin-right: 40px; text-align: right;"> Rol: Administrador</h2>
            <a href="login.html">
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

<form class="needs-validation" style="width: 100%; margin-left: 0%; margin-top: 3%;" action="<%=request.getContextPath()%>/Profesores?a=agregar" method="POST" novalidate>
    <div class="container">
        <h2>Nuevo Profesor</h2>
        <div class="container" style="margin-top: 3%; ">
            <div class="row">
                <div class="col">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombres: (*)</label>
                        <input type="text" name="nombre" id="nombre" placeholder="Ej: Tomas" pattern="[a-zA-ZáéíóúÁÉÍÓÚñÑ]+(\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]+)?" class="form-control" required>
                        <div class="invalid-feedback">Por favor ingresar nombre(s).</div>
                    </div>
                </div>
                <div class="col">
                    <div class="mb-3">
                        <label for="apellido" class="form-label">Apellidos: (*)</label>
                        <input type="text" name="apellido" id="apellido" placeholder="Ej: Rodriguez Loayza" pattern="[a-zA-ZáéíóúÁÉÍÓÚñÑ]+(\s[a-zA-ZáéíóúÁÉÍÓÚñÑ]+)?" class="form-control" aria-describedby="emailHelp" required>
                        <div class="invalid-feedback">Por favor ingresar apellidos.</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="mb-3">
                        <div class="mb-3">
                            <label for="curso" class="form-label">Curso: (*)</label><br>
                            <select id="curso" name="curso" class="form-select" required>
                                <option value="" disabled selected>Escoja una opción</option>
                                <option value="Yoga para adultos mayores, embarazadas y jóvenes">Yoga para adultos mayores, embarazadas y jóvenes</option>
                                <option value="Competencia de fútbol">Competencia de fútbol</option>
                                <option value="Competencia de vóley">Competencia de vóley</option>
                                <option value="Competencia de Atletismo">Competencia de Atletismo</option>
                                <option value="Carrera de tres pies">Carrera de tres pies</option>
                                <option value="Festival de juegos familiares">Festival de juegos familiares</option>
                                <option value="Juegos deportivos para los niños">Juegos deportivos para los niños</option>
                            </select>
                            <div class="invalid-feedback">Por favor escoja una opción.</div>
                        </div>

                    </div>
                </div>
                <div class="col">
                    <div class="mb-3">
                        <div class="mb-3">
                            <br>
                            <br>
                            <h3 class="obligatory-fields">(*)Campos obligatorios</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="btn-container">
        <button type="submit" class="btn btn-outline-primary" style="width: 200px;">Crear</button>
    </div>
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Incluir los archivos JavaScript de Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
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
