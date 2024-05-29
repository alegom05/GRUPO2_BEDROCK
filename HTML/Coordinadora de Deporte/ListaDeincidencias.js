document.addEventListener("DOMContentLoaded", function() {
    var filtroEvento= document.getElementById("filtroIncidencia");
  
    filtroEvento.addEventListener("change", function() {
      var deporteSeleccionado = filtroEvento.value;
  
      var filas = document.querySelectorAll("#tablaIncidencias tbody tr");
  
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
/*document.getElementById('filterSelect').addEventListener('change', function() {
    filterTable();
});

function filterTable() {
    var filter = document.getElementById('filterSelect').value;
    var table = document.getElementById('myTable');
    var rows = table.getElementsByTagName('tr');

    for (var i = 1; i < rows.length; i++) { // Empezamos desde 1 para omitir la fila de cabecera
        var row = rows[i];
        var dateCell = row.cells[3];
        var date = new Date(dateCell.textContent);

        if (filter === 'recent') {
            var today = new Date();
            if (date >= today) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        } else {
            row.style.display = '';
        }
    }
}

// Llama a filterTable() para mostrar todas las fechas al cargar la página
filterTable();*/