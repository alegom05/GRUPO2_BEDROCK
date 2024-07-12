package com.example.grupo2.Beans;

import java.io.InputStream;

public class Incidencia {

    private int idIncidencia;
    private String nombreIncidencia;
    private String descripcion;
    private String lugar;
    private String referencia;
    private String idTipoIncidencia;
    private String tipoIncidencia;
    private String contacto;
    private boolean requiereAmbulancia;
    private boolean requierePolicia;
    private boolean requiereBomberos;
    private String estadoIncidencia;
    private String nombreUsuario;
    private String correoUsuario;
    private String usuario;
    private InputStream fotoIncidencia;
    private String descripcionSolucion;
    private String descripcionEliminacion;
    private String fechaIncidencia;
    private String criticidad;
    private String personalRefuerzo;
    private int idUsuario;
    private double latitud;
    private double longitud;
    public int getIdIncidencia() {
        return idIncidencia;
    }

    public void setIdIncidencia(int idIncidencia) {
        this.idIncidencia = idIncidencia;
    }

    public String getNombreIncidencia() {
        return nombreIncidencia;
    }

    public void setNombreIncidencia(String nombreIncidencia) {
        this.nombreIncidencia = nombreIncidencia;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getTipoIncidencia() {
        return tipoIncidencia;
    }

    public void setTipoIncidencia(String tipoIncidencia) {
        this.tipoIncidencia = tipoIncidencia;
    }

    public String getContacto() {
        return contacto;
    }

    public void setContacto(String contacto) {
        this.contacto = contacto;
    }

    public boolean isRequiereAmbulancia() {
        return requiereAmbulancia;
    }

    public void setRequiereAmbulancia(boolean requiereAmbulancia) {
        this.requiereAmbulancia = requiereAmbulancia;
    }

    public String getEstadoIncidencia() {
        return estadoIncidencia;
    }

    public void setEstadoIncidencia(String estadoIncidencia) {
        this.estadoIncidencia = estadoIncidencia;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getCorreoUsuario() {
        return correoUsuario;
    }

    public void setCorreoUsuario(String correoUsuario) {
        this.correoUsuario = correoUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getDescripcionSolucion() {
        return descripcionSolucion;
    }

    public void setDescripcionSolucion(String descripcionSolucion) {
        this.descripcionSolucion = descripcionSolucion;
    }

    public String getDescripcionEliminacion() {
        return descripcionEliminacion;
    }

    public void setDescripcionEliminacion(String descripcionEliminacion) {
        this.descripcionEliminacion = descripcionEliminacion;
    }

    public String getFechaIncidencia() {
        return fechaIncidencia;
    }

    public void setFechaIncidencia(String fechaIncidencia) {
        this.fechaIncidencia = fechaIncidencia;
    }

    public boolean isRequierePolicia() {
        return requierePolicia;
    }

    public void setRequierePolicia(boolean requierePolicia) {
        this.requierePolicia = requierePolicia;
    }

    public boolean isRequiereBomberos() {
        return requiereBomberos;
    }

    public void setRequiereBomberos(boolean requiereBomberos) {
        this.requiereBomberos = requiereBomberos;
    }

    public String getCriticidad() {
        return criticidad;
    }

    public void setCriticidad(String criticidad) {
        this.criticidad = criticidad;
    }

    public String getPersonalRefuerzo() {
        return personalRefuerzo;
    }

    public void setPersonalRefuerzo(String personalRefuerzo) {
        this.personalRefuerzo = personalRefuerzo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getIdTipoIncidencia() {
        return idTipoIncidencia;
    }

    public void setIdTipoIncidencia(String idTipoIncidencia) {
        this.idTipoIncidencia = idTipoIncidencia;
    }

    public InputStream getFotoIncidencia() {
        return fotoIncidencia;
    }

    public void setFotoIncidencia(InputStream fotoIncidencia) {
        this.fotoIncidencia = fotoIncidencia;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }
}
