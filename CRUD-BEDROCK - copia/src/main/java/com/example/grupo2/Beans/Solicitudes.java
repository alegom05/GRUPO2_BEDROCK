package com.example.grupo2.Beans;

import java.util.Date;

public class Solicitudes {
    private int idsolicitud;
    private String nombre;
    private String apellido;
    private String dni;
    private String correo;
    private String direccion;
    private Boolean estadosolicitud;
    private String rol;
    private Date fechaSolicitud;

    public int getIdsolicitud() {
        return idsolicitud;
    }

    public void setIdsolicitud(int idsolicitud) {
        this.idsolicitud = idsolicitud;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Boolean getEstadosolicitud() {
        return estadosolicitud;
    }

    public void setEstadosolicitud(Boolean estadosolicitud) {
        this.estadosolicitud = estadosolicitud;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
}

