package com.example.grupo2.Servlet;

import com.example.grupo2.daos.VecinosDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Blob;

@WebServlet(name = "VecinoPruebaServlet", value = "/VecinoPruebaServlet")
public class VecinoIndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;

        requestDispatcher = request.getRequestDispatcher("./VecinosJSPS/paginaPrincipalBeta-Vecino.jsp");

        requestDispatcher.forward(request,response);

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");

        VecinosDao newVecinoDao = new VecinosDao();

        switch (action){
            case "new":
                request.getRequestDispatcher("./VecinosJSPS/reportarIncidenciaPrueba.jsp").forward(request,response);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VecinosDao jobVecino = new VecinosDao();

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");

        switch (action){
            case "crear"://creamos una nueva incidencia

                String nombreIncidencia=request.getParameter("");
                String descripcionIncidencia=request.getParameter("");
                String lugarIncidencia=request.getParameter("");
                String referenciaIncidencia=request.getParameter("");
                String contactoIncidencia=request.getParameter("contacto");
                String tipoIncidencia=request.getParameter("tipo");
                String ambulancia=request.getParameter("ambulancia");

                String idTipoIncidencia="";
                Boolean requiereAmbulancia=true;

                switch (tipoIncidencia){
                    case "accidente":
                        idTipoIncidencia="AC";
                        break;
                    case "alteracion_del_orden":
                        idTipoIncidencia="AL";
                        break;
                    case "robo":
                        idTipoIncidencia="RO";
                        break;
                    case "emergencia_medica":
                        idTipoIncidencia="EM";
                        break;
                    default:
                        idTipoIncidencia="OT";
                        break;

                }
                switch (ambulancia){
                    case "si":
                        requiereAmbulancia=true;
                        break;
                    case "no":
                        requiereAmbulancia=false;
                        break;
                    default:
                        requiereAmbulancia=true;
                        break;

                }

                boolean isAllValid = true;

                if(isAllValid){
                    jobVecino.crearIncidencia(nombreIncidencia,descripcionIncidencia,lugarIncidencia,referenciaIncidencia,contactoIncidencia,idTipoIncidencia,requiereAmbulancia);
                    response.sendRedirect(request.getContextPath() + "/JobServlet");
                }else{
                    request.getRequestDispatcher("VecinosJSPS/reportarIncidenciaPrueba.jsp").forward(request,response);
                }
                break;
    }
    }
}
