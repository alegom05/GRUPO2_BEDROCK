<%--
  Created by IntelliJ IDEA.
  User: alexm
  Date: 7/7/2024
  Time: 9:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="./index2.css" rel="stylesheet">
</head>
<body style="background-color: #eee;">
<section class="h-100 gradient-form">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-10">
                <div class="card rounded-3 text-black cuadro-con-sombra">
                    <div class="row g-0">
                        <div class="col-lg-6">
                            <div class="card-body p-md-5 mx-md-4">
                                <div class="text-center">
                                    <h4 class="mt-1 mb-5 pb-1">Bienvenido a Juntos Por San Miguel!</h4>
                                </div>
                                <form class="needs-validation" novalidate>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="nombre">Nombre: </label>
                                        <input type="text" id="nombre" class="form-control" placeholder="Ej: Tomas" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" title="Solo letras y espacios" required>
                                        <div class="invalid-feedback">Por favor ingresa tu nombre.</div>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="apellidos">Apellidos: </label>
                                        <input type="text" id="apellidos" class="form-control" placeholder="Ej: Ramirez Torres" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" title="Solo letras y espacios" required>
                                        <div class="invalid-feedback">Por favor ingresa tus apellidos.</div>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="dni">DNI: </label>
                                        <input type="text" id="dni" class="form-control" placeholder="Ej: 72324506" pattern="[0-9]+" title="Solo números" required>
                                        <div class="invalid-feedback">Por favor ingresa tu DNI.</div>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="urbanizacion">Urbanización: </label>
                                        <input type="text" id="urbanizacion" class="form-control" placeholder="Ej: Av... #XXXX" required>
                                        <div class="invalid-feedback">Por favor ingresa tu urbanización.</div>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="email">Correo electrónico (Gmail)</label>
                                        <input type="email" id="email" class="form-control" placeholder="example@gmail.com" required>
                                        <div class="invalid-feedback">Por favor ingresa un correo electrónico válido.</div>
                                    </div>
                                    <div class="text-center pt-1 mb-5 pb-1">
                                        <button type="submit" class="btn btn-success gradient-custom-2">Ingresar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-6 d-flex align-items-center background-section">
                            <div class="overlay"></div>
                            <div class="content text-white px-3 py-4 p-md-5 mx-md-4">
                                <h4 class="mb-4">Bienvenido!</h4>
                                <h6 class="large mb-0">Registrate para pertenecer a esta linda comunidad! En esta página estarás al tanto de todos los eventos que ocurrirán en el distrito!</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                event.preventDefault();
                if (!form.checkValidity()) {
                    event.stopPropagation();
                } else {
                    window.location.href = 'logIN.html';
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
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

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

