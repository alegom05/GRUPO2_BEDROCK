package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.SerenazgosDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.Objects;

@WebServlet(name = "Serenazgos", value = "/Serenazgos")
public class SerenazgoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();

        switch (action) {
            case "listar" -> {
                ArrayList<Usuario> listaSerenazgos = serenazgosDao.obtenerSerenazgos();
                request.setAttribute("serenazgos",listaSerenazgos);
                RequestDispatcher view =request.getRequestDispatcher("/AdministradorJSPS/serenazgos-Admin.jsp");
                view.forward(request,response);
            }
            case "formCrear" -> {
                RequestDispatcher view = request.getRequestDispatcher("/AdministradorJSPS/nuevoSerenazgo-Admin.jsp");
                view.forward(request, response);
            }
            case "editar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Usuario serenazgo = serenazgosDao.buscarPorId(id);
                if (serenazgo != null) {
                    request.getSession().setAttribute("serenazgoId", id);
                    request.setAttribute("serenazgo", serenazgo);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AdministradorJSPS/editarSerenazgo-Admin.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Serenazgos");
                }
            }
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();
        HttpSession session = request.getSession();

        switch (action) {
            case "agregar" -> {
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String dni = request.getParameter("dni");
                String nacimiento = request.getParameter("nacimiento");
                String numtelefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");
                String tipo = request.getParameter("tipo");
                String turnoSerenazgo = request.getParameter("turno");
                String correo_pucp = request.getParameter("correo");
                String contrasenia = request.getParameter("contrasenia");


                ArrayList<Usuario> listaUsuarios = serenazgosDao.obtenerUsuarios();
                int i=0;
                int j=0;
                if (serenazgosDao.existeDni(dni)) {
                    session.setAttribute("invalid1","error");
                    request.setAttribute("nombre", nombre);
                    request.setAttribute("apellido", apellido);
                    request.setAttribute("nacimiento", nacimiento);
                    request.setAttribute("telefono", numtelefono);
                    request.setAttribute("tipo", tipo);
                    request.setAttribute("turno", turnoSerenazgo);
                    request.setAttribute("correo", correo_pucp);
                    request.setAttribute("contrasenia", contrasenia);
                    RequestDispatcher view =request.getRequestDispatcher("/Serenazgos?a=formCrear");
                    view.forward(request,response);
                }else{
                    serenazgosDao.crearSerenazgos(nombre, apellido, dni, nacimiento, numtelefono, direccion, tipo, turnoSerenazgo, correo_pucp, contrasenia);
                    int idSere= serenazgosDao.buscarIdUsuarioPorDNI(dni);
                    serenazgosDao.crearCredenciales(correo_pucp,contrasenia,idSere);
                    response.sendRedirect(request.getContextPath() + "/Serenazgos");
                }
            }
            case "actualizar" -> {
                int id = (int) request.getSession().getAttribute("serenazgoId");
                Usuario serenazgo = leerParametrosRequest(request);
                serenazgo.setId(id);
                serenazgosDao.actualizar(serenazgo);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }
            case "borrar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.eliminarSerenazgo(id);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }
            case "cambiarContra" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                String clave = request.getParameter("clave");
            }
            case "cambiarContrasenia" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");

                // Verificar que la contraseña antigua sea correcta
                Usuario serenazgo = serenazgosDao.buscarPorId(id);
                if (serenazgo != null && serenazgo.getClave().equals(oldPassword)) {
                    // Actualizar la contraseña
                    serenazgosDao.actualizarContrasenia(id, newPassword);
                    serenazgosDao.crearCredencialesContraNueva(id, newPassword);
                    response.sendRedirect(request.getContextPath() + "/Serenazgos?a=editar&id=" + id);
                } else {
                    // Redirigir con un mensaje de error
                    request.setAttribute("error", "La contraseña antigua es incorrecta.");
                    request.getRequestDispatcher("/ruta/del/formulario").forward(request, response);
                }
            }
            case "editar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Usuario serenazgo = serenazgosDao.buscarPorId(id);
                if (serenazgo != null) {
                    request.setAttribute("serenazgo", serenazgo);
                    request.getSession().setAttribute("serenazgoId", id);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AdministradorJSPS/editarSerenazgo-Admin.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Serenazgos");
                }
            }
            case "formCrear" -> {
                RequestDispatcher view = request.getRequestDispatcher("/AdministradorJSPS/nuevoSerenazgo-Admin.jsp");
                view.forward(request, response);
            }


        }
    }
    public Usuario leerParametrosRequest(HttpServletRequest request) {
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String tipo = request.getParameter("tipo");
        String turno = request.getParameter("turno");
        String correo = request.getParameter("correo");
        String contrasenia = request.getParameter("contrasenia");

        Usuario serenazgo = new Usuario();
        serenazgo.setNumtelefono(telefono);
        serenazgo.setDireccion(direccion);
        serenazgo.setTipo(tipo);
        serenazgo.setTurnoSerenazgo(turno);
        serenazgo.setCorreo(correo);
        serenazgo.setClave(contrasenia);

        return serenazgo;
    }

}
