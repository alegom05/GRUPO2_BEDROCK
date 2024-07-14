package com.example.grupo2.Beans;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Time;
import java.sql.Date;
import java.util.Objects;

public class Evento {

    private int idEvento;
    private String nombre;
    private Date fechaInicial;
    private Date fechaFinal;
    private InputStream foto;
    private String materiales;
    private String lugar;
    private Time horaInicio;
    private String frecuencia;
    private int vacantes;
    private String descripcion;
    private String tipo;
    private int idProfesor;
    private String estadoEvento;
    private String nombreProfesor;
    private InputStream fotoAsistenciaEvento;

    public String getNombreProfesor() {
        return nombreProfesor;
    }

    public void setNombreProfesor(String nombreProfesor) {
        this.nombreProfesor = nombreProfesor;
    }

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechaInicial() {
        return fechaInicial;
    }

    public void setFechaInicial(Date fechaInicial) {
        this.fechaInicial = fechaInicial;
    }

    public Date getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(Date fechaFinal) {
        this.fechaFinal = fechaFinal;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }

    public String getMateriales() {
        return materiales;
    }

    public void setMateriales(String materiales) {
        this.materiales = materiales;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public Time getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Time hora) {
        this.horaInicio = hora;
    }

    public String getFrecuencia() {
        return frecuencia;
    }

    public void setFrecuencia(String frecuencia) {
        this.frecuencia = frecuencia;
    }

    public int getVacantes() {
        return vacantes;
    }

    public void setVacantes(int vacantes) {
        this.vacantes = vacantes;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getIdProfesor() {
        return idProfesor;
    }

    public void setIdProfesor(int idProfesor) {
        this.idProfesor = idProfesor;
    }

    public String getEstadoEvento() {
        return estadoEvento;
    }

    public void setEstadoEvento(String estadoEvento) {
        this.estadoEvento = estadoEvento;
    }

    public InputStream getFotoAsistenciaEvento() {
        return fotoAsistenciaEvento;
    }

    public void setFotoAsistenciaEvento(InputStream fotoAsistenciaEvento) {
        this.fotoAsistenciaEvento = fotoAsistenciaEvento;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Evento evento = (Evento) o;
        return idEvento == evento.idEvento;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idEvento);
    }

}
