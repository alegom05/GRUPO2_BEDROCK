package com.example.grupo2.Beans;

import java.sql.Date;

public class Incidencia {

    private int idIncidencia;
    private String nombreIncidencia;
    private String descripcion;
    private String lugar;
    private String referencia;
    private Date fecha;
    private String tipoIncidencia;
    private String contacto;
    private boolean requiereAmbulancia;
    private String estadoIncidencia;
    private String nombreUsuario;
    private String correoUsuario;
    private String usuario;
    private byte[] fotoIncidencia;

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

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
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

    public byte[] getFotoIncidencia() {
        return fotoIncidencia;
    }

    public void setFotoIncidencia(byte[] fotoIncidencia) {
        this.fotoIncidencia = fotoIncidencia;
    }
}
