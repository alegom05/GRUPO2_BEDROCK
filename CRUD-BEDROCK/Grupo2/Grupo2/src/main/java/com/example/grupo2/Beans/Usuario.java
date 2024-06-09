package com.example.grupo2.Beans;
import java.sql.Time;

public class Usuario {
    private int id;
    private String nombre;
    private String apellido;
    private String dni;
    private String correo;
    private String fecha_nacimiento;
    private String numtelefono;
    private String clave;
    private String direccion;
    private String Urbanizacion;
    private String TurnoSerenazgo;
    private String tipo;
    private String rol;
    private Time horaInicio;
    private Time horaFin;
    private Time fechaNacimiento;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getNumtelefono() {
        return numtelefono;
    }

    public void setNumtelefono(String numtelefono) {
        this.numtelefono = numtelefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getUrbanizacion() {
        return Urbanizacion;
    }

    public void setUrbanizacion(String urbanizacion) {
        Urbanizacion = urbanizacion;
    }

    public String getTurnoSerenazgo() {
        return TurnoSerenazgo;
    }

    public void setTurnoSerenazgo(String turnoSerenazgo) {
        TurnoSerenazgo = turnoSerenazgo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public Time getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Time horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Time getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(Time horaFin) {
        this.horaFin = horaFin;
    }

    public Time getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Time fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
}
