<%-- 
    Document   : menuFuncionario
    Created on : 22-abr-2018, 9:48:43
    Author     : Fernando
--%>

<%@page import="DTO.*"%>
<%@page import="DAO.*"%>
<%@page import="java.util.*"%>

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

            #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
                border-bottom: 4px solid !important; font-size: 20px;}

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
       
        <section id="tabs">
            <div class="container">
                <div class="row-fluid">
                    <div class="col-xs-12 ">
                        <nav>
                            <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                                <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Consultar Permisos</a>
                                <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Generar Permisos</a>
                                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Verificar Resoluciones</a>
                            </div>
                        </nav>
                        <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                <div class="container">
                                    <div class="tab-pane" id="nav-consultar" >
                                        <!--   INICIO CONSULTAR DE PERMISOS    -->
                                        <table border="2">
                                            <thead>
                                                <tr>
                                                    <th>FECHA DE SOLICITUD</th>
                                                    <th>FECHA DESDE</th>
                                                    <th>FECHA HASTA</th>
                                                    <th>DÍAS</th>
                                                    <th>ESTADO</th>
                                                    <th>TIPO</th>
                                                    <th>RESOLUCIÓN</th>
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
                                                    <td><%=permisoEstadoDAO.read(permiso.getEstado()).getEstado() %></td>
                                                    <td><%=permisoTipoDAO.read(permiso.getTipo()).getTipo() %></td>
                                                    <td><% if(permiso.getResolucion() != 0){%>
                                                            <a href="#">Ver Resolucion</a>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <%}%>
                                            </tbody>
                                        </table>
                                        <!--    FIN CONSULTAR DE PERMISOS      -->
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                <div>
                                    <div id="accordion">
                                        <div class="card">
                                            <div class="card-header" id="headingOne">
                                                <h5 class="mb-0">
                                                    <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">Permiso Administrativo</button>
                                                </h5>
                                            </div>
                                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                                                <div class="card-body">
                                                    <div class="container">
                                                        <div class="tab-pane " id="nav-administrativo" >
                                                            <!--   INICIO PERMISO ADMINISTRATIVO   -->
                                                            <form name="formAdministrativo" id="formAdministrativo"  action="ValidarPermisoAdministrativo" method="POST">
                                                            <table border="2">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Dias Disponibles:</td>
                                                                        <td><input disabled type="text" name="disponibles" value="<%=usuario.getDd_administrativos()%>" size="5" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Inicio:</td>
                                                                        <td><input required type="date" name="fechaInicio"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Fin:</td>
                                                                        <td><input required type="date" name="fechaFin"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><input required type="text" name="motivo"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button type="submit">SOLICITAR</button></td>
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
                                                    <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">Permiso por Fallecimiento de Familiar Directo</button>
                                                </h5>
                                            </div>
                                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                                                <div class="card-body">
                                                    <div class="container">
                                                        <div class="tab-pane " id="nav-fallecimiento">
                                                            <!--   INICIO PERMISO FALLECIMIENTO   -->
                                                            <form name="formFallecimiento" id="formFallecimiento"  action="ValidarPermisoFallecimiento">
                                                            <table border="2">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Adjuntar Archivo:</td>
                                                                        <td><input type="file" value="Examinar" name="btnExaminar" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><input required type="text" name="motivo"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button type="submit">Solicitar</button></td>
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
                                                      <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
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
                                                            <table border="2">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Dias Disponibles:</td>
                                                                        <td><input type="text" name="txtDisponibles" value="<%=usuario.getDd_legales() %>" size="5" disabled /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Inicio:</td>
                                                                        <td><input required type="date" name="fechaInicio"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha Fin:</td>
                                                                        <td><input required type="date" name="fechaFin"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><input required type="text" name="motivo"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button type="submit">SOLICITAR</button></td>
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
                                                    <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
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
                                                            <table border="2">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Fecha Inicio:</td>
                                                                        <td><input required type="date" name="fechaInicio"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Adjuntar archivo:</td>
                                                                        <td><input type="file" value="Examinar" name="btnExaminar" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo:</td>
                                                                        <td><input required type="text" name="motivo"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td></td>
                                                                        <td><button type="submit">Solicitar</button></td>
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
                                <div class="container">
                                    <div class="tab-pane " id="nav-verificar">
                                        <!--   INICIO VERIFICAR DE PERMISOS    -->
                                        <form name="form" id="form"  action="#">
                                            <table border="2">
                                                <tr>
                                                    <td>Ingrese código de documento:</td>
                                                    <td><input required id="codigoDocumento" type="text"  name="codigoDocumento" value="" placeholder="Código"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td><button type="submit">Verificar</button></td>
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

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
