<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="invalid1" scope="session" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="invalid2" scope="session" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="indicador2" scope="session" type="java.lang.String" class="java.lang.String"/>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Creación serenazgo</title>
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
        <a href="<%=request.getContextPath()%>/AdminIndexServlet" class="nav-link">Página principal</a>
      </li>
      <li class="nav-item">
        <a href="<%=request.getContextPath()%>/Solicitudes" class="nav-link">Administración de solicitudes</a>
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

    <form class="needs-validation" style="width: 100%; margin-left: 0%; margin-top: 3%;" action="<%=request.getContextPath()%>/Serenazgos?a=agregar" method="POST" novalidate>
      <div class="container">
        <h2>Nuevo Serenazgo</h2>
        <%if (session.getAttribute("invalid1").equals("error")){%>
        <div class="text-danger nb-2">
          El DNI ya existe en el sistema.
        </div>
        <%session.removeAttribute("invalid1");%>
        <%}%>
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
                <label for="dni" class="form-label" >DNI: (*)</label>
                <input type="tel" class="form-control" name="dni" id="dni" maxlength="8" minlength="8" placeholder="Ej: 87654321" pattern="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" title="ingrese su DNI" required>
                <div class="invalid-feedback">Por favor ingresar DNI.</div>
              </div>
            </div>
            <div class="col">
              <label for="nacimiento" class="form-label">Fecha de Nacimiento: (*)</label>
              </br>
              <input type="date"  name="nacimiento" id="nacimiento" class="form-control" aria-describedby="emailHelp"  max="2006-04-01" min="1910-01-01" required>
              <div class="invalid-feedback">Por favor ingresar fecha de nacimiento.</div>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <div class="mb-3">
                <label for="telefono" class="form-label">Número de Teléfono: (*)</label>
                <input type="tel" class="form-control" name="telefono" id="telefono" maxlength="9" minlength="9" placeholder="Ej: 987654321" pattern="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" title="ingrese su número de teléfono" required>
                <div class="invalid-feedback">Por favor ingresar número de teléfono.</div>
              </div>
            </div>
            <div class="col">
              <div class="mb-3">
                <label for="direccion" class="form-label">Dirección: (*)</label>
                <input type="text" name="direccion" id="direccion" placeholder="Ej: Av. ... #XXXX" pattern="[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+\s[a-zA-Z0-9#ZáéíóúÁÉÍÓÚñÑ.]+(\s[a-zA-Z0-9#ZáéíóúÁÉÍÓÚñÑ.]+)?+(\s[a-zA-Z0-9#ZáéíóúÁÉÍÓÚñÑ.]+)?" class="form-control" aria-describedby="emailHelp" required>
                <div class="invalid-feedback">Por favor ingresar dirección.</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <div class="mb-3">
                <div class="mb-3">
                  <label for="tipo" class="form-label">Tipo: (*)</label><br>
                  <select id="tipo" name="tipo" class="form-select" required>
                    <option value="" disabled selected>Escoja una opción</option>
                    <option value="En bicicleta">En bicicleta</option>
                    <option value="Con canino">Con canino</option>
                    <option value="A pie">A pie</option>
                    <option value="Con vehículo">Con vehículo</option>
                  </select>
                  <div class="invalid-feedback">Por favor escoja una opción.</div>
                </div>

              </div>
            </div>
            <div class="col">
              <div class="mb-3">
                <label for="turno" class="form-label">Turno: (*)</label><br>
                <select id="turno" name="turno" class="form-select" required>
                  <option value="" disabled selected>Escoja una opción</option>
                  <option value="Mañana">Mañana</option>
                  <option value="Tarde">Tarde</option>
                  <option value="Noche">Noche</option>
                </select>
                <div class="invalid-feedback">Por favor escoja una opción.</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <div class="mb-3">
                <label for="correo" class="form-label">Correo: (*)</label>
                <input type="text" name="correo" id="correo" placeholder="Ej: ejemplo@gmail.com" class="form-control" aria-describedby="emailHelp" required>
                <div class="invalid-feedback">Por favor ingresar correo.</div>
              </div>
            </div>
            <div class="col">
              <div class="mb-3">
                <label for="contrasenia" class="form-label">Contraseña: (*)</label>
                <input type="password" class="form-control" id="contrasenia" name="contrasenia" required>
                <div class="invalid-feedback">Por favor ingresar contraseña.</div>
              </div>
              <div class="mb-3">
                <h3 class="obligatory-fields">(*)Campos obligatorios</h3>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="btn-container">
        <button type="submit" class="btn btn-primary" style="width: 200px;">Crear</button>
      </div>
    </form>
  </div>
</div>





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

  // Validar que solo se ingresen números en el campo de DNI
  document.addEventListener("input", function(event) {
    if (event.target && event.target.id === "dni") {
      let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
      if (value.length > 8) {
        value = value.slice(0, 8); // Limitar a 8 dígitos
      }
      event.target.value = value;
    }
  });
  // Validar que solo se ingresen números en el campo de teléfono
  document.addEventListener("input", function(event) {
    if (event.target && event.target.id === "telefono") {
      let value = event.target.value.replace(/\D/g, ""); // Eliminar caracteres no numéricos
      if (value.length > 9) {
        value = value.slice(0, 9); // Limitar a 9 dígitos
      }
      event.target.value = value;
    }
  });
  document.addEventListener("input", function(event) {
    if (event.target && event.target.id === "direccion") {
      let pattern = /^[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+\s[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+(\s[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+)?(\s[a-zA-Z0-9#áéíóúÁÉÍÓÚñÑ.]+)?$/;
      let value = event.target.value;
      if (!pattern.test(value)) {
        event.target.setCustomValidity("La dirección no cumple con el formato requerido.");
      } else {
        event.target.setCustomValidity("");
      }
    }
  });
  document.addEventListener("input", function(event) {
    if (event.target && event.target.id === "correo") {
      let pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Patrón de correo
      if (!pattern.test(event.target.value)) {
        event.target.setCustomValidity("Por favor, ingrese un correo válido.");
      } else {
        event.target.setCustomValidity("");
      }
    }
  });
  document.addEventListener("input", function(event) {
    if (event.target && event.target.id === "contrasenia") {
      // Permitir letras, números y caracteres especiales específicos
      event.target.value = event.target.value.replace(/[^a-zA-Z0-9!@#$%^&*]/g, "");
    }
  });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
