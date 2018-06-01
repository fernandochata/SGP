package Funciones;

import java.util.Random;

/**
 *
 * 
 * @author Fernando Chata
 * 
 */
public class Clave {
    
    public String crearClave(){
        
        String cadenaReferencia = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        int largoReferencia = 20;
        
        StringBuilder sb = new StringBuilder();
        Random rnd = new Random();
        while (sb.length() < largoReferencia) {
            int index = (int) (rnd.nextFloat() * cadenaReferencia.length());
            sb.append(cadenaReferencia.charAt(index));
        }
        return sb.toString();
        
    }
    
}
