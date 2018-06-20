<%@page import="DTO.*"%>
<%@page import="DAO.*"%>
<%@page import="Funciones.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="imagenes/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js" ></script>
        <script type="text/javascript" src="js/jquery.dataTables.js" ></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js" ></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js" ></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" ></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js" ></script>
        <script type="text/javascript" src="https://editor.datatables.net/extensions/Editor/js/dataTables.editor.min.js" ></script>
        <script type="text/javascript" src="https://cdn.datatables.net/select/1.2.6/js/dataTables.select.min.js" ></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" ></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js" ></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js" ></script>
        <script type="text/javascript" src="js/popper.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.18/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css"/>

        <title>Sistema de Gestión de Permisos</title>

        <style>
            html, body{height:100%; width:100%;}
            #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active { border-bottom: 4px solid !important; }
            
            .body-block{
                background:rgb(20, 122, 75);
                background:-webkit-linear-gradient(to bottom,rgb(8, 100, 20),rgb(255, 255, 255));
                background:linear-gradient(to bottom,rgb(8, 100, 20),rgb(255, 255, 255));
                width:100%;height:100%;
               }
            .container{background:#fff; border-radius: 10px; box-shadow:15px 20px 0px rgba(0,0,0,0.1);}
        </style>
    </head> <!-- HEAD -->
    <body>
        <section>
            <%
                String mensajeError = (String)request.getSession().getAttribute("mensajeError");
                request.getSession().setAttribute("mensajeError", null);
                UsuarioDTO usuario = (UsuarioDTO)request.getSession().getAttribute("usuarioDTO");
                PermisoDTO permiso = (PermisoDTO)request.getSession().getAttribute("permisoDTO");
                
                
                if(permiso == null){
                    request.getRequestDispatcher("CerrarSesion").forward(request, response);
                }
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                //UsuarioPerfilDAO usuarioPerfilDAO = new UsuarioPerfilDAO();
                UsuarioDepartamentoDAO usuarioDepartamentoDAO = new UsuarioDepartamentoDAO();
                UsuarioCargoDAO usuarioCargoDAO = new UsuarioCargoDAO();

                //PermisoEstadoDAO permisoEstadoDAO = new PermisoEstadoDAO();
                PermisoMotivoDAO permisoMotivoDAO = new PermisoMotivoDAO();
                //PermisoResolucionDAO permisoResolucionDAO = new PermisoResolucionDAO();
                PermisoTipoDAO permisoTipoDAO = new PermisoTipoDAO();
            %>
        </section> <!-- CARGAR DATOS -->
        <section>
            <% if(mensajeError != null){ %>
            <div class="modal" id="modalMensaje" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="false">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">SGP</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body">
                      <p><%=mensajeError %></p>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                  </div>
                </div>
              </div>
            <% } %>
        </section> <!-- MODAL -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#"><img class="d-block img-fluid" src="imagenes/LogoMunicipalidad-small.png" height="40" width="40" alt="logo municipalidad"></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link">Bienvenido(a) <%=usuario.getNombres() %> <%= usuario.getApellido_paterno() %> <%=usuario.getApellido_materno()%></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Opciones
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="verPerfil.jsp">Ver Perfil</a>
                            <a class="dropdown-item" href="cambiarClave.jsp">Cambiar Contraseña</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="CerrarSesion">Cerrar Sesión</a>
                        </div>
                    </li>
                </ul>
                <a class="btn btn-secondary" href="CerrarSesion">Cerrar Sesión</a>
            </div>
        </nav> <!-- HEADER -->
        
        <section class="body-block" id="tabs"><br>
            <div class="container">
                <div class="row-fluid table-responsive">

                                  <br>
                                        <form name="formModificarPermiso" action="ActualizarPermiso" method="POST">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th style="font-size:25px; text-align: center" class="text-center" scope="col" colspan="3">Permiso #<%=permiso.getId_permiso() %></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td scope="col">Nombre del Funcionario: </td>
                                                        <td colspan="2"><%=usuarioDAO.read(permiso.getUsuario()).getNombres()%> <%=usuarioDAO.read(permiso.getUsuario()).getApellido_paterno()%> <%=usuarioDAO.read(permiso.getUsuario()).getApellido_materno()%></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Rut del funcionario:</td>
                                                        <td colspan="2"><%=usuarioDAO.read(permiso.getUsuario()).getRut()%>-<%=usuarioDAO.read(permiso.getUsuario()).getDv() %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Cargo del funcionario:</td>
                                                        <td colspan="2"><%=usuarioCargoDAO.read(usuarioDAO.read(permiso.getUsuario()).getCargo()).getCargo() %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Departamento del funcionario:</td>
                                                        <td colspan="2"><%=usuarioDepartamentoDAO.read(usuarioDAO.read(permiso.getUsuario()).getDepartamento()).getDepartamento() %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Fecha de Creación:</td>
                                                        <td colspan="2"><%=Fechas.toStringFecha(permiso.getFecha_creacion()) %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Fecha de Inicio del Permiso:</td>
                                                        <td colspan="2"><%=Fechas.toStringFecha(permiso.getFecha_desde()) %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Fecha de Fin del Permiso</td>
                                                        <td colspan="2"><%=Fechas.toStringFecha(permiso.getFecha_hasta()) %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Dias  Hábiles Totales</td>
                                                        <td colspan="2"><%=permiso.getDias() %></td>
                                                    </tr>
                                                        <td>Tipo de Permiso:</td>
                                                        <td colspan="2"><%=permisoTipoDAO.read(permiso.getTipo()).getTipo() %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Motivo:</td>
                                                        <td colspan="2"><%=permisoMotivoDAO.read(permiso.getMotivo()).getMotivo() %></td> 
                                                    </tr>
                                                    <tr>
                                                        <td>Observación</td>
                                                        <td colspan="2"><textarea required class="form-control" name="observacion" id="observacion" maxlength="200"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center"><a href="Regresar" class="btn btn-primary ">Regresar</a></td>
                                                        <td class="text-center"><button name="boton" value="2" type="submit" class="btn btn-danger ">Rechazar Permiso</button></td>
                                                        <td class="text-center"><button name="boton" value="1" type="submit" class="btn btn-success ">Autorizar Permiso</button></td>                                                
                                                        
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </form>
                                    
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        
       
        
        
        
        <script type="text/javascript">$('#modalMensaje').modal('show');</script>
    </body>
</html>
