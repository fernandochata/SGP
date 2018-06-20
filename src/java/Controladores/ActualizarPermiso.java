package Controladores;

import DTO.*;
import DAO.*;
import Funciones.Clave;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ActualizarPermiso", urlPatterns = {"/ActualizarPermiso"})
public class ActualizarPermiso extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            UsuarioDTO usuarioDTO = (UsuarioDTO)request.getSession().getAttribute("usuarioDTO");
            PermisoDTO permisoDTO = (PermisoDTO)request.getSession().getAttribute("permisoDTO");
            
            int rut = usuarioDTO.getRut();
            int administrativo = usuarioDTO.getDd_administrativos();
            int legal = usuarioDTO.getDd_legales();
            int dias = permisoDTO.getDias();
            
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            PermisoDAO permisoDAO = new PermisoDAO();
            
            String observacion = request.getParameter("observacion");
            int boton = Integer.parseInt(request.getParameter("boton"));
            
            switch(boton){
                case 1: // SE AUTORIZA EL PERMISO
                    // SE DEBE CREAR LA RESOLUCION
                    PermisoResolucionDAO permisoResolucionDAO = new PermisoResolucionDAO();
                    PermisoResolucionDTO permisoResolucionDTO = new PermisoResolucionDTO();

                    permisoResolucionDTO.setCodigo(Clave.createNewCode(5));
                    permisoResolucionDTO.setDetalle("");
                    permisoResolucionDTO.setRuta_documento("");
                    permisoResolucionDTO.setFecha_creacion(new Date());

                    if(permisoResolucionDAO.create(permisoResolucionDTO)){
                        // SE CREA CORRECTAMENTE LA RESOLUCION
                        permisoDTO.setEstado(2); // ESTADO APROBADO
                        permisoDTO.setObservacion(observacion);
                        permisoDTO.setResolucion(permisoResolucionDAO.last().getId_resolucion());

                        if(permisoDAO.update(permisoDTO)){
                            // SE APRUEBA EL PERMISO
                            String mensajeError = "Se aprobó el permiso.";
                            request.getSession().setAttribute("mensajeError", mensajeError);
                            request.getRequestDispatcher("MenuInterno").forward(request, response);
                        }else{
                            String mensajeError = "No se pudo aprobar el permiso.";
                            request.getSession().setAttribute("mensajeError", mensajeError);
                            request.getRequestDispatcher("MenuInterno").forward(request, response);
                        }
                    }else{
                        String mensajeError = "Error al crear resolución del permiso.";
                        request.getSession().setAttribute("mensajeError", mensajeError);
                        request.getRequestDispatcher("MenuInterno").forward(request, response);
                    }
                    break;
                case 2: // SE RECHAZA EL PERMISO
                    String mensajeError;
                    switch(permisoDTO.getTipo()){
                        case 1: // PERMISO ADMINISTRATIVO
                            permisoDTO.setEstado(3); // ESTADO RECHAZADO
                            permisoDTO.setObservacion(observacion);
                            if(permisoDAO.update(permisoDTO)){
                                if(usuarioDAO.update_Administrativo(administrativo, rut)){
                                    UsuarioDTO usuario = usuarioDAO.read(rut);
                                    request.getSession().setAttribute("usuarioDTO", usuario); 
                                    mensajeError = "Se rechazó el permiso administrativo.";
                                    request.getSession().setAttribute("mensajeError", mensajeError);
                                    request.getRequestDispatcher("MenuInterno").forward(request, response);
                                }else{
                                    mensajeError = "No se pudo actualizar el usuario al rechazar el permiso legal.";
                                    request.getSession().setAttribute("mensajeError", mensajeError);
                                    request.getRequestDispatcher("MenuInterno").forward(request, response);
                                }
                            }else{
                                mensajeError = "No se pudo rechazar el permiso.";
                                request.getSession().setAttribute("mensajeError", mensajeError);
                                request.getRequestDispatcher("MenuInterno").forward(request, response);
                            }
                            break;
                        case 2: // PERMISO POR FALLECIMIENTO
                            mensajeError = "No se puede rechazar un permiso por fallecimiento.";
                            request.getSession().setAttribute("mensajeError", mensajeError);
                            request.getRequestDispatcher("autorizarPermiso.jsp").forward(request, response);
                            break;
                        case 3: // PERMISO LEGAL
                            permisoDTO.setEstado(3); // ESTADO RECHAZADO
                            permisoDTO.setObservacion(observacion);
                            if(permisoDAO.update(permisoDTO)){
                                if(usuarioDAO.update_Legal(legal, rut)){
                                    UsuarioDTO usuario = usuarioDAO.read(rut);
                                    request.getSession().setAttribute("usuarioDTO", usuario); 
                                    mensajeError = "Se rechazó el permiso legal.";
                                    request.getSession().setAttribute("mensajeError", mensajeError);
                                    request.getRequestDispatcher("MenuInterno").forward(request, response);
                                }else{
                                    mensajeError = "No se pudo actualizar el usuario al rechazar el permiso legal.";
                                    request.getSession().setAttribute("mensajeError", mensajeError);
                                    request.getRequestDispatcher("MenuInterno").forward(request, response);
                                }
                            }else{
                                mensajeError = "No se pudo rechazar el permiso.";
                                request.getSession().setAttribute("mensajeError", mensajeError);
                                request.getRequestDispatcher("MenuInterno").forward(request, response);
                            }
                            break;
                        case 4: // PERMISO PARENTAL
                            mensajeError = "No se puede rechazar un permiso parental.";
                            request.getSession().setAttribute("mensajeError", mensajeError);
                            request.getRequestDispatcher("autorizarPermiso.jsp").forward(request, response);
                            break;
                    }
                    break;
             }
        } catch(NullPointerException ex) {
            String mensajeError = "Error inesperado (ActualizarPermiso) | " + ex.getMessage();
            request.getSession().setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("CerrarSesion").forward(request, response);
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

}
