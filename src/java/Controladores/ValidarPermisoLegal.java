/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import DAO.PermisoDAO;
import DAO.UsuarioDAO;
import DTO.PermisoDTO;
import DTO.UsuarioDTO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author SGP
 */
@WebServlet(name = "ValidarPermisoLegal", urlPatterns = {"/ValidarPermisoLegal"})
public class ValidarPermisoLegal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            String mensajeError = "";
            UsuarioDTO usuario = (UsuarioDTO)request.getSession().getAttribute("usuario");
            
            Date fechaInicio = sdf.parse(request.getParameter("fechaInicio"));
            Date fechaFin = sdf.parse(request.getParameter("fechaFin"));
            String motivo = request.getParameter("motivo");
            
            int disponibles = usuario.getDd_legales();
            int solicitados = diasHabiles(fechaInicio, fechaFin, feriadosChilenos());
            
            if(fechaInicio.before(new Date())){
                mensajeError = "Fecha De incio anterior a hoy dia";
                request.getSession().setAttribute("mensajeError", mensajeError);
                request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
            }else{
                if(fechaFin.before(fechaInicio)){
                    mensajeError = "Fecha De fin no puede ser anterior a fecha de inicio";
                    request.getSession().setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
                }else{
                    if(disponibles < solicitados){
                        mensajeError = "No se cuentan con dias administrativos suficientes";
                        request.getSession().setAttribute("mensajeError", mensajeError);
                        request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
                    }else{
                        if(motivo == null || motivo == ""){
                            mensajeError = "debe ingresar un motivo";
                            request.getSession().setAttribute("mensajeError", mensajeError);
                            request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
                        }else{
                            request.getSession().setAttribute("mensajeError", null);
                            
                            PermisoDTO permiso = new PermisoDTO();
                            
                            permiso.setFecha_creacion(new Date());
                            permiso.setFecha_desde(sdf.parse(request.getParameter("fechaInicio")));
                            permiso.setFecha_hasta(sdf.parse(request.getParameter("fechaFin")));
                            permiso.setDias(diasHabiles(fechaInicio, fechaFin, feriadosChilenos()));
                            permiso.setUsuario(usuario.getRut());
                            permiso.setAdjunto(0);
                            permiso.setResolucion(0);
                            permiso.setEstado(1);
                            permiso.setTipo(3);
                            permiso.setMotivo(2);
                            
                            PermisoDAO permisoDAO = new PermisoDAO();
                            
                            if(permisoDAO.create(permiso)){
                                
                                usuario.setDd_legales(usuario.getDd_legales() - solicitados);
                                UsuarioDAO usuarioDAO = new UsuarioDAO();
                                
                                if(usuarioDAO.update(usuario)){
                                    mensajeError = "SE INGRESO PERMISO LEGAL";
                                    request.getSession().setAttribute("mensajeError", mensajeError);
                                    request.getRequestDispatcher("MenuFuncionario").forward(request, response);
                                }else{
                                    mensajeError = "ERROR AL MODIFICAR USUARIO" + permiso.toString();
                                    request.getSession().setAttribute("mensajeError", mensajeError);
                                    request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
                                }
                            }else{
                                mensajeError = "ERROR AL MODIFICAR PERMISO" + permiso.toString();
                                request.getSession().setAttribute("mensajeError", mensajeError);
                                request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
                            }
                        }
                    }
                }
            }
        } catch (ParseException ex) {
            //ERROR AL PASEAR ALGUNA FECHA
            String mensajeError = "Error en las fechas. " + ex.getMessage();
            request.getSession().setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("menuFuncionario.jsp").forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private int diasHabiles(Date fechaInicio, Date fechaFin, List<Date> listaFechasNoLaborables) {
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

    private static List<Date> feriadosChilenos() throws ParseException {
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        List<Date> lista = new ArrayList<>();
        
        lista.add(sdf.parse("01-01-2018"));
        lista.add(sdf.parse("30-03-2018"));
        lista.add(sdf.parse("31-03-2018"));
        lista.add(sdf.parse("01-04-2018"));
        lista.add(sdf.parse("21-04-2018"));
        lista.add(sdf.parse("02-07-2018"));
        lista.add(sdf.parse("16-07-2018"));
        lista.add(sdf.parse("15-08-2018"));
        lista.add(sdf.parse("17-09-2018"));
        lista.add(sdf.parse("18-09-2018"));
        lista.add(sdf.parse("19-09-2018"));
        lista.add(sdf.parse("15-10-2018"));
        lista.add(sdf.parse("01-11-2018"));
        lista.add(sdf.parse("02-11-2018"));
        lista.add(sdf.parse("08-12-2018"));
        lista.add(sdf.parse("25-12-2018"));
            
        return lista;
    }
}
