package com.example.grupo2.Filters;

import com.example.grupo2.Beans.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "FilterSinLogin",servletNames = {"MenuSinLoginServlet"})
public class FilterSinLogin implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        Usuario usuario = (Usuario) req.getSession().getAttribute("usuarioSesion");
        if (usuario==null || usuario.getId()==0) {
            chain.doFilter(request, response);
        } else {
            if("VE".equals(usuario.getRol())){
                resp.sendRedirect(req.getContextPath()+"/VecinoIndexServlet");
            }else if("CO".equals(usuario.getRol())){
                resp.sendRedirect(req.getContextPath()+"/CoordinadorasJSPS/PaginaPrincipal.jsp");
            }else if("SE".equals(usuario.getRol())){
                resp.sendRedirect(req.getContextPath()+"/SerenazgoIndexServlet");
            }else{
                resp.sendRedirect(req.getContextPath()+"/AdminIndexServlet");
            }

        }
    }
}
