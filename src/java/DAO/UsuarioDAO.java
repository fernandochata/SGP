package DAO;

import Conexion.Conexion;
import DTO.UsuarioDTO;
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
public class UsuarioDAO {
    
    PreparedStatement ps;
    
    private static final String SQL_UPDATE = "UPDATE USUARIOS SET dv=?, clave=?, nombres=?, apellido_paterno=?, apellido_materno=?, direccion=?, comuna=?, telefono=?, email=?, dd_legales=?, dd_administrativos=?, fecha_contrato=?, perfil=?, cargo=?, departamento=? WHERE rut=?";
    private static final String SQL_READ = "SELECT * FROM Usuarios WHERE rut = ?";
    private static final String SQL_READALL = "SELECT * FROM Usuarios";
    
    private static final Conexion con = Conexion.iniciarConexion();
    
    public boolean update(UsuarioDTO aux) {
        try {           
            ps = con.getCnn().prepareStatement(SQL_UPDATE);
            
            ps.setString(1, aux.getDv());
            ps.setString(2, aux.getClave());
            ps.setString(3, aux.getNombres());
            ps.setString(4, aux.getApellido_paterno());
            ps.setString(5, aux.getApellido_materno());
            ps.setString(6, aux.getDireccion());
            ps.setString(7, aux.getComuna());
            ps.setInt(8, aux.getTelefono());
            ps.setString(9, aux.getEmail());
            ps.setInt(10, aux.getDd_legales());
            ps.setInt(11, aux.getDd_administrativos());
            ps.setDate(12, new java.sql.Date(aux.getFecha_contrato().getTime()));
            ps.setInt(13, aux.getPerfil());
            ps.setInt(14, aux.getCargo());
            ps.setInt(15, aux.getDepartamento());
            ps.setInt(16, aux.getRut());
            
            if (ps.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PermisoDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            con.cerrarConexion();;
        }
        return false;
    }
    
    public UsuarioDTO read(Object key) {
        ResultSet resultado;
        UsuarioDTO usuario = null;
        try {
            ps = con.getCnn().prepareStatement(SQL_READ);
            ps.setString(1, key.toString());
            resultado = ps.executeQuery();
            while (resultado.next()) {
                usuario = new UsuarioDTO(resultado.getInt(1), resultado.getString(2), resultado.getString(3), resultado.getString(4), resultado.getString(5), resultado.getString(6), resultado.getString(7), resultado.getString(8), resultado.getInt(9), resultado.getString(10), resultado.getInt(11), resultado.getInt(12), resultado.getDate(13) , resultado.getInt(14), resultado.getInt(15), resultado.getInt(16));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDTO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            con.cerrarConexion();
        }
        return usuario;
    }
    
    public ArrayList<UsuarioDTO> readAll() {
        ArrayList<UsuarioDTO> usuarios = null;
        try {
            usuarios = new ArrayList<>();            
            ps = con.getCnn().prepareStatement(SQL_READALL);
            ResultSet resultado = ps.executeQuery();
            while (resultado.next()) {
                usuarios.add(new UsuarioDTO(resultado.getInt(1), resultado.getString(2), resultado.getString(3), resultado.getString(4), resultado.getString(5), resultado.getString(6), resultado.getString(7), resultado.getString(8), resultado.getInt(9), resultado.getString(10), resultado.getInt(11), resultado.getInt(12), resultado.getDate(13) , resultado.getInt(14), resultado.getInt(15), resultado.getInt(16)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDTO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            con.cerrarConexion();
        }
        return usuarios;
    }
    
}
