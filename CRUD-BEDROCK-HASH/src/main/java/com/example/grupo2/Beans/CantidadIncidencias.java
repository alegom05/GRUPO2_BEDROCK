package com.example.grupo2.Beans;

public class CantidadIncidencias {

    private int cantidadTotal;
    private int cantidadNuevas;
    private int cantidadEnProceso;
    private int catidadFalsasAlarmas;
    private int cantidadCerradas;

    public int getCantidadCerradas() {
        return cantidadCerradas;
    }

    public void setCantidadCerradas(int cantidadCerradas) {
        this.cantidadCerradas = cantidadCerradas;
    }

    public int getCatidadFalsasAlarmas() {
        return catidadFalsasAlarmas;
    }

    public void setCatidadFalsasAlarmas(int catidadFalsasAlarmas) {
        this.catidadFalsasAlarmas = catidadFalsasAlarmas;
    }

    public int getCantidadEnProceso() {
        return cantidadEnProceso;
    }

    public void setCantidadEnProceso(int cantidadEnProceso) {
        this.cantidadEnProceso = cantidadEnProceso;
    }

    public int getCantidadNuevas() {
        return cantidadNuevas;
    }

    public void setCantidadNuevas(int cantidadNuevas) {
        this.cantidadNuevas = cantidadNuevas;
    }

    public int getCantidadTotal() {
        return cantidadTotal;
    }

    public void setCantidadTotal(int cantidadTotal) {
        this.cantidadTotal = cantidadTotal;
    }
}
