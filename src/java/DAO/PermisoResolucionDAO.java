package DAO;

import Conexion.Conexion;
import DTO.PermisoResolucionDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Fernando Chata
 */
public class PermisoResolucionDAO {
    
    PreparedStatement ps;
    
    private static final String SQL_READ = "SELECT * FROM PERMISO_RESOLUCIONES WHERE ID_RESOLUCION = ?";
    private static final String SQL_READALL = "SELECT * FROM PERMISO_RESOLUCIONES";
    
    private static final Conexion con = Conexion.iniciarConexion();
    
    public PermisoResolucionDTO read(Object key) {
        ResultSet rs;
        PermisoResolucionDTO permisoResolucion = null;
        try {
            ps = con.getCnn().prepareStatement(SQL_READ);
            ps.setString(1, key.toString());
            rs = ps.executeQuery();
            while (rs.next()) {
                permisoResolucion = new PermisoResolucionDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
            }
        } catch (SQLException ex) {
            Logger.getLogger(PermisoResolucionDTO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            con.cerrarConexion();
        }
        return permisoResolucion;
    }
    
    public ArrayList<PermisoResolucionDTO> readAll() {
        ArrayList<PermisoResolucionDTO> listado = null;
        try {
            listado = new ArrayList<>();            
            ps = con.getCnn().prepareStatement(SQL_READALL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listado.add(new PermisoResolucionDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(PermisoResolucionDTO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            con.cerrarConexion();
        }
        return listado;
    }
}
