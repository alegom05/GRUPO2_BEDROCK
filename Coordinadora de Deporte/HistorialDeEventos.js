document.addEventListener("DOMContentLoaded", function() {
    var filtroEvento= document.getElementById("filtroEvento");
  
    filtroEvento.addEventListener("change", function() {
      var deporteSeleccionado = filtroEvento.value;
  
      var filas = document.querySelectorAll("#tablaEventos tbody tr");
  
      filas.forEach(function(fila) {
        var deporteFila = fila.querySelector("td:nth-child(3)").textContent;
        if (deporteSeleccionado === "todos" || deporteFila === deporteSeleccionado) {
          fila.style.display = "";
        } else {
          fila.style.display = "none";
        }
      });
    });
  });