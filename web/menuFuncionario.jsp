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
                ArrayList<PermisoDTO> listaPermisos = (ArrayList<PermisoDTO>)request.getSession().getAttribute("listaPermisos");
                UsuarioDTO usuario = (UsuarioDTO)request.getSession().getAttribute("usuarioDTO");
                if(usuario.getPerfil() != 2 || usuario == null){
                    mensajeError = "Autentificación incorrecta. Vuelva a ingresar.";
                    request.getSession().setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
                PermisoDAO permisoDAO = new PermisoDAO();
                PermisoEstadoDAO permisoEstadoDAO = new PermisoEstadoDAO();
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
                            <a class="dropdown-item" href="CerrarSesion">Cerrar Sesion</a>
                        </div>
                    </li>
                </ul>
                <a class="btn btn-secondary" href="CerrarSesion">Cerrar Sesion</a>
            </div>
        </nav> <!-- HEADER -->
        <section class="body-block" id="tabs">
            <br>
            <div class="container">
                <div class="row-fluid">
                    <div class="col-xs-12 ">
                        <br>
                        <nav>
                            <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                                <a class="btn btn-success nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Consultar Permisos</a>
                                <a class="btn btn-success nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Crear Permiso</a>
                                <a class="btn btn-success nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Verificar Decreto</a>
                            </div>
                        </nav>
                        <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                <div>
                                    <div class="tab-pane" id="nav-consultar table-responsive col-md-10 col-lg-10 " >
                                        <table id="tabla-permisos">
                                            <thead>
                                                <tr>
                                                    <th>SOLICITUD</th>
                                                    <th>DESDE</th>
                                                    <th>HASTA</th>
                                                    <th>DÍAS</th>
                                                    <th>TIPO</th>
                                                    <th>ESTADO</th>
                                                    <th>DECRETO</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (PermisoDTO permiso: listaPermisos)
                                                {%>
                                                <tr>
                                                    <td><%=permiso.getFecha_creacion() %></td>
                                                    <td><%=permiso.getFecha_desde() %></td>
                                                    <td><%=permiso.getFecha_hasta() %></td>
                                                    <td><%=permiso.getDias() %></td>
                                                    <td><%=permisoTipoDAO.read(permiso.getTipo()).getTipo() %></td>
                                                    <td><%=permisoEstadoDAO.read(permiso.getEstado()).getEstado() %></td>
                                                    <form action="VerResolucion" method="POST">
                                                        <td><% if(permiso.getResolucion() != 0){%>
                                                            <button class="btn btn-link form-control" type="submit" name="id_resolucion" value="<%=permiso.getResolucion()%>">Ver</button>
                                                            <%}%>
                                                        </td>
                                                    </form>
                                                </tr>
                                                <%}%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                <div>
                                    <div id="accordion">
                                        <div class="card">
                                            <div class="card-header" id="headingOne">
                                                <h5 class="mb-0">
                                                    <button class="btn btn-light" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">Permiso Administrativo</button>
                                                </h5>
                                            </div>
                                            <div id="collapseOne" class="collapse " aria-labelledby="headingOne" data-parent="#accordion">
                                                <div class="card-body">
                                                    <div class="container">
                                                        <div class="tab-pane " id="nav-administrativo" >
                                                            <!--   INICIO PERMISO ADMINISTRATIVO   -->
                                                            <form name="formAdministrativo" id="formAdministrativo"  action="ValidarPermisoAdministrativo" method="POST">
                                                            <table class="table">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Dias Disponibles:</td>
                                                                        
                                                                        <td><%=usuario.getDd_administrativos() %></td>
                                                                        <!--<td><%=usuario.getDd_administrativos() - permisoDAO.sum_Usuario_Estado_Tipo(usuario.getRut(), 1, 1) %></td>-->
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Dias pendientes de aprobacion</td>
                                                                        <td><%=permisoDAO.sum_Usuario_Estado_Tipo(usuario.getRut(), 1, 1) %></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Inicio:</td>
                                                                        <td><input class="form-control" required type="date" name="fechaInicio"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Fin:</td>
                                                                        <td><input class="form-control" required type="date" name="fechaFin"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><textarea required class="form-control" name="motivo" id="motivo" aria-label="With textarea" maxlength="200"></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button class="btn btn-primary" type="submit">Solicitar</button></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </form>
                                                            <!--   FIN PERMISO ADMINISTRATIVO   -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingTwo">
                                                <h5 class="mb-0">
                                                    <button class="btn btn-light collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">Permiso por Fallecimiento de Familiar Directo</button>
                                                </h5>
                                            </div>
                                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                                                <div class="card-body">
                                                    <div class="container">
                                                        <div class="tab-pane " id="nav-fallecimiento">
                                                            <!--   INICIO PERMISO FALLECIMIENTO   -->
                                                            <form name="formFallecimiento" id="formFallecimiento"  action="ValidarPermisoFallecimiento">
                                                            <table class="table">
                                                                <tbody>
                                                                    <tr><td>Seleccione grado de parentesco:</td>
                                                                        <td>
                                                                            <select class="form-control" id="parentesco" name="parentesco">
                                                                                <option value="1">Padre o Madre</option>
                                                                                <option value="2">Hijo o Hija</option>
                                                                                <option value="3">Esposo o Esposa</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                    <!--<tr>
                                                                        <td>Adjuntar Archivo (opcional):</td>
                                                                        <td><input class="form-control" type="file" value="Examinar" name="btnExaminar" accept=".pdf"/></td>
                                                                    </tr>-->
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><textarea required name="motivo" id="motivo" class="form-control" aria-label="With textarea" maxlength="200"></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button class="btn btn-primary" type="submit">Solicitar</button></td>
                                                                    </tr>
                                                                </tbody>   
                                                            </table>
                                                            </form>
                                                            <!--   FIN PERMISO FALLECIMIENTO   -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingThree">
                                                <h5 class="mb-0">
                                                      <button class="btn btn-light collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                          Permiso por Feriado Legal
                                                      </button>
                                                </h5>
                                            </div>
                                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                                                <div class="card-body">
                                                    <div class="container">
                                                        <div class="tab-pane" id="nav-legal">
                                                            <!--   INICIO PERMISO LEGAL   -->
                                                            <form name="formLegal" id="formLegal" action="ValidarPermisoLegal" method="POST">
                                                            <table class="table">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Dias Disponibles:</td>
                                                                        <td><%=usuario.getDd_legales() %></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Dias pendientes de aprobacion</td>
                                                                        <td><%=permisoDAO.sum_Usuario_Estado_Tipo(usuario.getRut(), 1, 3) %></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Inicio:</td>
                                                                        <td><input class="form-control" required type="date" name="fechaInicio"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Fin:</td>
                                                                        <td><input class="form-control" required type="date" name="fechaFin"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><textarea required class="form-control" name="motivo" id="motivo" aria-label="With textarea" maxlength="200"></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button class="btn btn-primary" type="submit">Solicitar</button></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table> 
                                                            </form>
                                                            <!--   FIN PERMISO LEGAL   -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingFour">
                                                <h5 class="mb-0">
                                                    <button class="btn btn-light collapsed" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                                        Permiso Parental
                                                    </button>
                                                </h5>
                                            </div>
                                            <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
                                                <div class="card-body">
                                                    <div class="container">
                                                        <div class="tab-pane " id="nav-parental">
                                                            <!--   INICIO PERMISO PARENTAL   -->
                                                            <form name="formParental" id="formParental"  action="ValidarPermisoParental">
                                                            <table class="table">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Fecha Inicio:</td>
                                                                        <td><input class="form-control" required type="date" name="fechaInicio"></td>
                                                                    </tr>
                                                                    <!--<tr>
                                                                        <td>Adjuntar archivo (opcional):</td>
                                                                        <td><input class="form-control" type="file" value="Examinar" name="btnExaminar" /></td>
                                                                    </tr>-->
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><textarea required class="form-control" name="motivo" id="motivo" aria-label="With textarea" maxlength="200"></textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button class="btn btn-primary" type="submit">Solicitar</button></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </form>
                                                            <!--   FIN PERMISO PARENTAL   -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                                <div>
                                    <div class="tab-pane " id="nav-verificar">
                                        <!--   INICIO VERIFICAR DE PERMISOS    -->
                                        <form name="form" id="form" method="POST" action="VerResolucion">
                                            <table class="table">
                                                <tr>
                                                    <td>Ingrese el código del decreto</td>
                                                    <td><input class="form-control" required id="id_resolucion" pattern="[0-9]+" title="Código es númerico." type="text"  name="id_resolucion"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td><button class="btn btn-primary" type="submit">Verificar</button></td>
                                                </tr>
                                            </table>
                                        </form>
                                        <!--    FIN VERIFICAR DE PERMISOS      -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
                                                                    
        <script type="text/javascript">$(document).ready(function(){$('#tabla-permisos').DataTable();});</script>                                                            
        <script type="text/javascript">$('#modalMensaje').modal('show');</script>
    </body>
</html>
