<jsp:useBean id="indicador" scope="session" type="java.lang.String" class="java.lang.String"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="id" scope="session" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="email" scope="session" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="invalid_id" scope="session" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="invalid_repeat" scope="session" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="invalid_pass" scope="session" type="java.lang.String" class="java.lang.String"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="./styleLogIN.css" rel="stylesheet">
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


                                        <form class="form-login" style="margin-top: 4%;" method="POST" action="<%=request.getContextPath()%>/RestablecerClave?a=restablecer">

                                            <div class="login-container" style="margin-top: -1%;">
                                                <div class="login-header">

                                                    <h2 style="margin-top: 1%;font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;color: rgb(16, 16, 115);">Establecer Contraseña</h2>
                                                    <%if (session.getAttribute("invalid_id").equals("error")){%>
                                                    </br>
                                                    <div class="text-danger nb-2">
                                                        Código incorrecto
                                                    </div>
                                                    <%session.removeAttribute("invalid_id");%>
                                                    <%}%>
                                                    <%if (session.getAttribute("invalid_repeat").equals("error")){%>
                                                    </br>
                                                    <div class="text-danger nb-2">
                                                        Las contraseñas no coinciden.
                                                    </div>
                                                    <%session.removeAttribute("invalid_repeat");%>
                                                    <%}%>
                                                    <%if (session.getAttribute("invalid_pass").equals("error")){%>
                                                    </br>
                                                    <div class="text-danger nb-2">
                                                        Las contraseñas no coinciden.
                                                    </div>
                                                    <%session.removeAttribute("invalid_pass");%>
                                                    <%}%>
                                                </div>
                                                <div class="mb-3" style="margin-top: 2%;" >
                                                    <label for="verificador" class="form-label">Código enviado:</label>
                                                    <input type="text" pattern="[0-9]+" class="form-control" id="verificador" name="verificador" aria-describedby="emailHelp" required>
                                                    <br/>
                                                    <label for="pass" class="form-label">Ingrese la nueva contraseña:</label>
                                                    <input type="password" class="form-control" id="pass" name="pass" aria-describedby="emailHelp" required>
                                                    <br/>
                                                    <label for="pass2" class="form-label">Repita la nueva contraseña:</label>
                                                    <input type="password" class="form-control" id="pass2" name="pass2" aria-describedby="emailHelp" required>
                                                    <input type="hidden" name="correo" id="correo" value="<%=email%>" />
                                                    <input type="hidden" name="codigo" id="codigo" value="<%=id%>" />
                                                </div>
                                                <div class="btn-container" style="">
                                                    <button type="submit" class="btn btn-success gradient-custom-2" style="width: 280px;" >
                                                        Cambiar contraseña
                                                    </button>
                                                </div>
                                            </div>
                                        </form>



                                    </div>
                                </div>
                                <div class="col-lg-6 d-flex align-items-center background-section">
                                    <div class="overlay"></div>
                                    <div class="content text-white px-3 py-4 p-md-5 mx-md-4">
                                        <h4 class="mb-4">Revisa tu correo!</h4>
                                        <h6 class="large mb-0">Te enviamos un código con el cual podrás cambiar tu contraseña!</h6>
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

                const forms = document.querySelectorAll('.needs-validation');

                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            })();

        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
