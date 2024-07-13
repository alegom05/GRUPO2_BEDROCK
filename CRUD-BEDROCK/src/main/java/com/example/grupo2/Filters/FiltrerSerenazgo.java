package com.example.grupo2.Filters;


import com.example.grupo2.Beans.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "FilterSerenazgo",servletNames = {"SerenazgoIndexServlet","Sereno","ExportarPDFServlet"})

public class FiltrerSerenazgo implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        Usuario usuario = (Usuario) req.getSession().getAttribute("usuarioSesion");
        if (usuario != null && usuario.getId()!=0 && "SE".equals(usuario.getRol())) {
            resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            resp.setHeader("Pragma", "no-cache"); // HTTP 1.0.
            resp.setDateHeader("Expires", 0);
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath());
        }
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
