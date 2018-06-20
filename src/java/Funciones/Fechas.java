package Funciones;

import DAO.FeriadoDAO;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Fernando Chata
 */
public class Fechas {
    
    public static Calendar toCalendar(Date date){ 
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar;
    }
    public static Date toDate(Calendar calendar){
        //Calendar cal = Calendar.getInstance();
        //Date date = cal.getTime();
        return calendar.getTime();
    }
    public static int workingDays(Date fechaInicio, Date fechaFin) {
        
        FeriadoDAO feriadoDAO = new FeriadoDAO();
        List<Date> listaFechasNoLaborables = feriadoDAO.read();
        
        int habiles = 0;
        boolean diaHabil = false;
        
        Calendar fechaInicial = Calendar.getInstance();
        fechaInicial.setTime(fechaInicio);

        Calendar fechaFinal = Calendar.getInstance();
        fechaFinal.setTime(fechaFin);
        
        while (fechaInicial.before(fechaFinal) || fechaInicial.equals(fechaFinal)) {
            if (!listaFechasNoLaborables.isEmpty()) {
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
    public static Date addWorkingDays(Date inicio, int dias){
        Date finalDate = new Date();
        int working = 0, counter = 1;
        while (working < dias) {
            finalDate = addDays(inicio, counter);
            working = workingDays(inicio, finalDate);
            counter++;
        } 
        return finalDate;
    }
    public static Date addDays(Date fecha, int dias){
        // Si variable dias es POSITIVO se SUMAN dias
        // Si variable dias es NEGATIVO se RESTAN dias
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);
        calendar.add(Calendar.DAY_OF_YEAR, dias);
        return calendar.getTime();
    }
    public static Date addMonths(Date fecha, int meses){
        // Si variable meses es POSITIVO se SUMAN meses
        // Si variable meses es NEGATIVO se RESTAN meses
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);
        calendar.add(Calendar.MONTH, meses);
        return calendar.getTime();
    }
    public static String toStringFecha(Date date){
        String monthArray[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};

        Calendar calendario = toCalendar(date);
        
        int year = calendario.get(Calendar.YEAR);
        String month = monthArray[calendario.get(Calendar.MONTH)];
        int day = calendario.get(Calendar.DAY_OF_MONTH);
        return day + " de " + month + " del "+ year;
    }
    public static String toStringHora(Date date){
        String minuteString;
        Calendar calendario = toCalendar(date);
        
        int hour = calendario.get(Calendar.HOUR);
        int minuteInt = calendario.get(Calendar.MINUTE);
        if(minuteInt < 10){
            minuteString = "0" + minuteInt;
        }else{
            minuteString = String.valueOf(minuteInt);
        }
        return hour + ":" + minuteString;
    }
}
