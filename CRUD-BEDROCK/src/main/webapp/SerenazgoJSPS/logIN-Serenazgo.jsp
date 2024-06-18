<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 01:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../styleLogIN.css" rel="stylesheet">
</head>
<body>
<section class="h-100 gradient-form" style="background-color: #eee;">
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

                                <form id="loginForm" class="needs-validation" novalidate>
                                    <p>Correo electrónico (Gmail)</p>

                                    <div class="form-outline mb-4">
                                        <input type="email" id="email" class="form-control" placeholder="example@gmail.com" required />
                                        <div class="invalid-feedback">Por favor ingrese un correo electrónico válido.</div>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="password1">Contraseña</label>
                                        <input type="password" id="password1" class="form-control" required>
                                        <div class="invalid-feedback">Por favor ingrese su contraseña.</div>
                                    </div>

                                    <div class="text-center pt-4 mb-2 pb-1">
                                        <button id="loginButton" class="btn gradient-custom-3" type="submit">Ingresar</button>
                                        <a class="btn btn-link" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">¿Olvidaste tu contraseña?</a>
                                    </div>
                                </form>

                                <form id="modalForm" class="needs-validation" novalidate>
                                    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Recupera tu contraseña</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="form-outline mb-3">
                                                        <label class="form-label" for="modalEmail">Escribe el correo asociado a tu cuenta</label>
                                                        <input type="email" id="modalEmail" class="form-control" placeholder="example@gmail.com" required>
                                                        <div class="invalid-feedback">Por favor ingresa un correo electrónico válido.</div>
                                                    </div>
                                                    <div id="emailError" class="text-danger d-none">Por favor, completa este campo.</div>
                                                    <div id="successMessage" class="text-success d-none">Se ha enviado un correo, por favor revise su bandeja.</div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button id="nextBtn" type="submit" class="btn gradient-custom-3">Confirmar</button>
                                                    <button id="understoodBtn" type="button" class="btn btn-success d-none">Entendido</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-6 d-flex align-items-center background-section">
                            <div class="overlay"></div>
                            <div class="content text-white px-3 py-4 p-md-5 mx-md-4">
                                <h4 class="mb-4">Bienvenido!</h4>
                                <h6 class="large mb-0">Logueate para pertencer a esta linda comunidad! En esta página estarás al tanto de todos los eventos que ocurrirán al distrito!</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    document.getElementById('understoodBtn').addEventListener('click', function() {
        var modal = bootstrap.Modal.getInstance(document.getElementById('exampleModalToggle'));
        modal.hide();
        document.getElementById('modalEmail').value = '';
        document.getElementById('emailError').classList.add('d-none');
        document.getElementById('successMessage').classList.add('d-none');
        document.getElementById('nextBtn').classList.remove('d-none');
        document.getElementById('understoodBtn').classList.add('d-none');
    });

    // Disable default browser validation
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('invalid', function(event) {
            event.preventDefault();
        });
    });

    (() => {
        'use strict';

        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        const forms = document.querySelectorAll('.needs-validation');

        // Loop over them and prevent submission
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                event.preventDefault(); // Prevent the page from reloading
                if (!form.checkValidity()) {
                    event.stopPropagation();
                } else {
                    if (form.id === 'loginForm') {
                        window.location.href = 'paginaPrincipal-Serenazgo.jsp'; // Redirect to the main page
                    } else if (form.id === 'modalForm') {
                        document.getElementById('emailError').classList.add('d-none');
                        document.getElementById('successMessage').classList.remove('d-none');
                        document.getElementById('nextBtn').classList.add('d-none');
                        document.getElementById('understoodBtn').classList.remove('d-none');
                    }
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
