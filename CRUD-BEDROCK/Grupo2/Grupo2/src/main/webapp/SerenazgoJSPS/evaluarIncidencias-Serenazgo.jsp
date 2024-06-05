<%--
  Created by IntelliJ IDEA.
  User: doria
  Date: 29/05/2024
  Time: 00:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluar incidencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style-Serenazgo.css" rel="stylesheet">
</head>
<body class="bodyForms">
<div class="container contenedor-evaluacion" id="formsCuadros">
    <h3>Evaluación de incidencia</h3>
    <form class="row align-items-start mb-3">

        <div class="mb-3">
            <%--@declare id="enabledtextinput"--%><label for="enabledTextInput" class="form-label">Criticidad:</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions1" id="inlineRadio1" value="option1">
                <label class="form-check-label" for="inlineRadio1">Bajo</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions1" id="inlineRadio2" value="option2">
                <label class="form-check-label" for="inlineRadio2">Medio</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions1" id="inlineRadio3" value="option3">
                <label class="form-check-label" for="inlineRadio3">Alto</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="enabledTextInput" class="form-label">Se necesita:</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                <label class="form-check-label" for="inlineCheckbox1">Bomberos</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
                <label class="form-check-label" for="inlineCheckbox2">Comisaría</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="option3">
                <label class="form-check-label" for="inlineCheckbox3">Ambulancia</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="enabledTextInput" class="form-label">Personal de serenazgo de refuerzo:</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions2" id="inlineRadio1" value="option1">
                <label class="form-check-label" for="inlineRadio1">A pie</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions2" id="inlineRadio2" value="option2">
                <label class="form-check-label" for="inlineRadio2">Bicicleta</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions2" id="inlineRadio3" value="option3">
                <label class="form-check-label" for="inlineRadio3">Canino</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions2" id="inlineRadio4" value="option4">
                <label class="form-check-label" for="inlineRadio3">Vehículo</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="enabledTextInput" class="form-label">Descripción de solución:</label>
            <textarea class="form-control" placeholder="Máximo 130 caracteres" id="floatingTextarea2" style="height: 75px"></textarea>
        </div>


        <div class="mb-3">
            <label for="enabledTextInput" class="form-label">Estado de personal::</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                <label class="form-check-label" for="inlineCheckbox1">Bomberos en camino</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
                <label class="form-check-label" for="inlineCheckbox2">Ambulancia en camino </label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="option3">
                <label class="form-check-label" for="inlineCheckbox3">Policía en camino</label>
            </div>
        </div>



    </form>

    <div class="botonesGroup">

        <a href="IncidenciaServlet" type="button" class="btn gradient-custom-3" id="btnRedireccional">Guardar</a>

        <a href="IncidenciaServlet" type="button" class="btn btn-secondary" id="btnRedireccional">Cancelar</a>


    </div>
</div>

</body>
</html>
