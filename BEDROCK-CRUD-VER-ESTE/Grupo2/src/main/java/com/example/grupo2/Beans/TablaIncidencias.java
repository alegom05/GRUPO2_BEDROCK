package com.example.grupo2.Beans;

public class TablaIncidencias {

    private  int idIncidencia;
    private String nombreIncidencia;
    private String tipoIncidencia;
    private String estadoIncidencia;
    private String nombreUsuario;
    private String correoUsuario;


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

    public String getTipoIncidencia() {
        return tipoIncidencia;
    }

    public void setTipoIncidencia(String tipoIncidencia) {
        this.tipoIncidencia = tipoIncidencia;
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
}
