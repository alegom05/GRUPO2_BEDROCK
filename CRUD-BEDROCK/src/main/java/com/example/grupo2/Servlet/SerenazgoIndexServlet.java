package com.example.grupo2.Servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "SerenazgoIndexServlet", value = "/SerenazgoIndexServlet")
public class SerenazgoIndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        //recuperar informacion del servidor
        /*doGet

        -Uso Principal: Se utiliza para recuperar información del servidor.
        Las solicitudes GET son idempotentes, lo que significa que hacer varias solicitudes GET
        al mismo recurso no debe cambiar su estado.

        -Envío de Datos: Los datos se envían como parte de la URL (query string).
        Por ejemplo, http://example.com/servlet?param1=value1&param2=value2.

        -Visibilidad de Datos: Los datos enviados son visibles en la URL,
        lo que puede ser menos seguro para datos sensibles.

        -Límite de Tamaño: Las URL tienen un límite de longitud (2048 caracteres ),
        lo que limita la cantidad de datos que se pueden enviar.
        Caché: Las respuestas a las solicitudes GET pueden ser almacenadas en
         caché por el navegador y proxies, lo que puede mejorar el rendimiento.*/

        /*doPost

        -Uso Principal: Se utiliza para enviar datos al servidor para crear o actualizar recursos.
        Las solicitudes POST no son idempotentes, lo que significa que enviar la misma solicitud
        varias veces puede tener efectos secundarios (por ejemplo, crear múltiples recursos).

        -Envío de Datos: Los datos se envían en el cuerpo de la solicitud, no en la URL.
        Esto permite enviar grandes cantidades de datos.

        -Visibilidad de Datos: Los datos no son visibles en la URL,
         lo que puede ser más seguro para datos sensibles.

        -Límite de Tamaño: No hay un límite específico para la cantidad de datos que se pueden enviar,
         ya que los datos se envían en el cuerpo de la solicitud.

        Caché: Las solicitudes POST no se almacenan en caché por defecto, ya que suelen cambiar el
        estado del servidor.*/

        requestDispatcher = request.getRequestDispatcher("/SerenazgoJSPS/paginaPrincipal-Serenazgo.jsp");

        requestDispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
