package com.example.grupo2.Beans;

public class Usuario {
    private String id;
    private String nombre;
    private String apellido;
    private int dni;
    private String correo;
    private String fecha_nacimiento;
    private int numtelefono;
    private String contrasenia;
    private String direccion;
    private String Urbanización;
    private String TurnoSerenazgo;
    private String tipo;
    private String rol;

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getUrbanización() {
        return Urbanización;
    }

    public void setUrbanización(String urbanización) {
        Urbanización = urbanización;
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

    public int getNumtelefono() {
        return numtelefono;
    }

    public void setNumtelefono(int numtelefono) {
        this.numtelefono = numtelefono;
    }
}
