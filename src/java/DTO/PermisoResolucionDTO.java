package DTO;

/**
 *
 * @author Fernando Chata
 */
public class PermisoResolucionDTO {
    
    private int id_resolucion;
    private String detalle;
    private String codigo;
    private String ruta_documento;

    public PermisoResolucionDTO() {
    }

    public PermisoResolucionDTO(int id_resolucion, String detalle, String codigo, String ruta_documento) {
        this.id_resolucion = id_resolucion;
        this.detalle = detalle;
        this.codigo = codigo;
        this.ruta_documento = ruta_documento;
    }

    public int getId_resolucion() {
        return id_resolucion;
    }

    public void setId_resolucion(int id_resolucion) {
        this.id_resolucion = id_resolucion;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getRuta_documento() {
        return ruta_documento;
    }

    public void setRuta_documento(String ruta_documento) {
        this.ruta_documento = ruta_documento;
    }

    @Override
    public String toString() {
        return "PermisoResolucionDTO{" + "id_resolucion=" + id_resolucion + ", detalle=" + detalle + ", codigo=" + codigo + ", ruta_documento=" + ruta_documento + '}';
    }
}
