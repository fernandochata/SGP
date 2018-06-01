package Funciones;

import DAO.FeriadoDAO;
import DTO.FeriadoDTO;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Fernando Chata
 */
public class Fechas {
    
    static public int diasHabiles(Date fechaInicio, Date fechaFin) {
        
        FeriadoDAO feriadoDAO = new FeriadoDAO();
        //ArrayList<FeriadoDTO> listaFechasNoLaborables = feriadoDAO.read();
        List<Date> listaFechasNoLaborables = feriadoDAO.read();
        
        int habiles = 0;
        boolean diaHabil = false;
        
        Calendar fechaInicial = Calendar.getInstance();
        fechaInicial.setTime(fechaInicio);

        Calendar fechaFinal = Calendar.getInstance();
        fechaFinal.setTime(fechaFin);
        
        while (fechaInicial.before(fechaFinal) || fechaInicial.equals(fechaFinal)) {
            if (!listaFechasNoLaborables.isEmpty()) {
                //for (FeriadoDTO date : listaFechasNoLaborables) {
                for (Date date : listaFechasNoLaborables) {
                    Date fechaNoLaborablecalendar = fechaInicial.getTime();
                    if (fechaInicial.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && fechaInicial.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY && !fechaNoLaborablecalendar.equals(date)) {
                        diaHabil = true;
                    } else {
                        diaHabil = false;
                        break;
                    }
                }
            } else {
                if (fechaInicial.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && fechaInicial.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
                    habiles++;
                }
            }
            if (diaHabil == true) {
                habiles++;
            }
            fechaInicial.add(Calendar.DATE, 1);
        }
        return habiles;
    }
    
}
