/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import DAO.UsuarioDAO;
import DTO.UsuarioDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ValidarIngreso", urlPatterns = {"/ValidarIngreso"})
public class ValidarIngreso extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.getSession().setAttribute("mensajeError", null);

            String rutUsuario = request.getParameter("rutUsuario");
            String claveUsuario = request.getParameter("claveUsuario");

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            UsuarioDTO usuarioDTO = usuarioDAO.read(rutUsuario);

            if(usuarioDTO == null){
                String mensajeError = "Usuario no existe en la base de datos";
                request.getSession().setAttribute("mensajeError", mensajeError);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }else{
                if(claveUsuario.compareTo(usuarioDTO.getClave()) != 0){
                    String mensajeError = "Clave incorrecta, intentelo nuevamente";
                    request.getSession().setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }else{
                    request.getSession().setAttribute("usuario", usuarioDTO);
                    switch (usuarioDTO.getPerfil()) {
                        //case 1:
                        //    request.getRequestDispatcher("MenuAdministrador").forward(request, response);
                        //    break;
                        case 2:
                            request.getRequestDispatcher("MenuFuncionario").forward(request, response);
                            break;
                        case 3:
                            request.getRequestDispatcher("MenuInterno").forward(request, response);
                            break;
                        case 4:
                            request.getRequestDispatcher("MenuSuperior").forward(request, response);
                            break;
                        case 5:
                            request.getRequestDispatcher("MenuAlcalde").forward(request, response);
                            break;
                    }
                }
            }
        }catch (IOException | ServletException ex) {
            request.getSession().setAttribute("mensajeError", ex.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
