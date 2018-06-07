<%-- 
    Document   : cambiarClave
    Created on : 07-06-2018, 9:46:57
    Author     : Fernando
--%>
<%@page import="DAO.*"%>
<%@page import="DTO.*"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="imagenes/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        
        <title>SGP</title>

        <style>
            html, body{height:100%;width:100%;}

            /* Estilo Modal */
            .modal {display: none;position: fixed;z-index: 1;padding-top: 100px;left: 0;top: 0;overflow: auto;background-color: rgb(0,0,0);background-color: rgba(0,0,0,0.4);}
            .modal-content {background-color: #fefefe;margin: auto;padding: 20px;border: 1px solid #888;width: 80%;} 
        </style>
    </head>
    <body>
<section>
            <%
            ArrayList<PermisoDTO> listaPermisos = (ArrayList<PermisoDTO>)request.getSession().getAttribute("listaPermisos");
            
            UsuarioDTO usuario = (UsuarioDTO)request.getSession().getAttribute("usuario");
            
            UsuarioPerfilDAO usuarioPerfilDAO = new UsuarioPerfilDAO();
            UsuarioDepartamentoDAO usuarioDepartamentoDAO = new UsuarioDepartamentoDAO();
            UsuarioCargoDAO usuarioCargoDAO = new UsuarioCargoDAO();
            
            PermisoEstadoDAO permisoEstadoDAO = new PermisoEstadoDAO();
            PermisoMotivoDAO permisoMotivoDAO = new PermisoMotivoDAO();
            PermisoResolucionDAO permisoResolucionDAO = new PermisoResolucionDAO();
            PermisoTipoDAO permisoTipoDAO = new PermisoTipoDAO();
            %>
        </section>
        
        <!-- INICIO HEADER -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand"><img class="d-block img-fluid" src="imagenes/LogoMunicipalidad-small.png" height="40" width="40" alt="logo municipalidad"></a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link">Bienvenido(a) <%=usuario.getNombres() %> <%= usuario.getApellido_paterno() %> <%=usuario.getApellido_materno()%> <span class="sr-only"></span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Opciones</a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="perfil.jsp">Ver Perfil</a>
                        <a class="dropdown-item" href="cambiarClave.jsp">Cambiar Contraseña</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="CerrarSesion">Cerrar Sesion</a>
                    </div>
                    </li>
                </ul>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                <a href="CerrarSesion">Cerrar Sesion</a>
                </button>
            </div>
        </nav>
        <!-- FIN HEADER -->

        <!-- Inicio Ventana Modal MENSAJE -->
        <% if(request.getSession().getAttribute("mensajeError") != null){ %>
        <div id="modalMensaje" class="modal">
            <div class="modal-content">
                <p><c:out value="${sessionScope.mensajeError}" /></p>
            </div>
        </div>
        <script>
            var modal = document.getElementById('modalMensaje');
            modal.style.display = "block";
            window.onclick = function(event) { if (event.target == modal) { modal.style.display = "none"; } }
        </script>
        <% } %>
        <!-- Final Ventana Modal MENSAJE -->
        <form>
            <div class="container">
                <div class="row">
                    <div class="col-md-10" >
                        <div class="panel panel-info">
                            <div class="panel-heading">
                              <h3 class="panel-title"><%=usuario.getNombres() %> <%=usuario.getApellido_paterno() %> <%=usuario.getApellido_materno() %></h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class=" col-md-9 col-lg-9 "> 
                                    <table class="table table-user-information">
                                        <tbody>
                                        <tr>
                                            <td>Ingrese Clave actual: </td>
                                            <td><input type="password" name="" value="" /></td>
                                        </tr>
                                        <tr>
                                            <td>Ingrese clave nueva</td>
                                            <td><input type="password" name="" value="" /></td>
                                        </tr>
                                        <tr>
                                            <td>Repita clave</td>
                                            <td><input type="password" name="" value="" /></td>
                                        </tr>

                                        <tr>
                                            <td><a href="javascript:history.back()" class="btn btn-primary">Regresar</a></td>
                                            <td><input type="submit" value="" /></td>
                                        </tr>
                                        </tbody>
                                    </table>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>    
    </body>
</html>
