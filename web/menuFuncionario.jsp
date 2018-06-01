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
        <title>MENÚ FUNCIONARIO</title>
        <meta charset="utf-8">
        <link rel="shortcut icon" type="image/x-icon" href="imagenes/favicon.ico">
    </head>
    <body>
        
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
            
        <p>
            <h1>Bienvenido(a) <%=usuario.getNombres() %> <%= usuario.getApellido_paterno() %> <%=usuario.getApellido_materno()%></h1>
            <div style="text-align:right"> <a href="CerrarSesion">Cerrar Sesión</a> </div>
            <br>
            <h3><label name="mensaje" id="mensaje" for="mensaje"><c:out value="${sessionScope.mensajeError}" /></label></h3>

            <br>
            <table border="2">
                <tr>
                    <td>Perfil</td>
                    <td><%=usuarioPerfilDAO.read(usuario.getPerfil()).getPerfil() %></td>
                </tr>
                <tr>
                    <td>Cargo:</td>
                    <td><%=usuarioCargoDAO.read(usuario.getCargo()).getCargo() %></td>
                </tr>
                <tr>
                    <td>Departamento:</td>
                    <td><%=usuarioDepartamentoDAO.read(usuario.getDepartamento()).getDepartamento() %></td>
                </tr>
            </table>
        </p>
            
        

        <hr>

        <h3>GENERACIÓN DE PERMISOS</h3>
        
        <div>
            
        <form name="formAdministrativo" id="formAdministrativo"  action="ValidarPermisoAdministrativo" method="POST">
        <table border="2">
            <thead>
                <tr>
                    <td>PERMISO</td><td>ADMINISTRATIVO</td>
                </tr>
            </thead>
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
             
        <br>
        <form name="formFallecimiento" id="formFallecimiento"  action="ValidarPermisoFallecimiento">
        <table border="2">
            <thead>
                <tr>
                    <td>PERMISO</td>
                    <td>FALLECIMIENTO DE FAMILIAR DIRECTO</td>
                </tr>
            </thead>
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

        <br>
        <form name="formLegal" id="formLegal" action="ValidarPermisoLegal" method="POST">
        <table border="2">
            <thead>
                <tr>
                    <td>PERMISO</td><td>FERIADO LEGAL ANUAL</td>
                </tr>
            </thead>
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
     
        <br>
        <form name="formParental" id="formParental"  action="ValidarPermisoParental">
        <table border="2">
            <thead>
                <tr>
                    <td>PERMISO</td><td>PARENTAL</td>
                </tr>
            </thead>
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
                
        </div>
        <hr>
                        
        <h3>CONSULTAR PERMISOS</h3>
        <div>
            <table border="2">
            <thead>
                <tr>
                    <th>FECHA DE SOLICITUD</th>
                    <th>FECHA DESDE</th>
                    <th>FECHA HASTA</th>
                    <th>DIAS</th>
                    <th>ESTADO</th>
                    <th>TIPO</th>
                    <th>RESOLUCION</th>
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
                    <td><a href="#">Ver Resolucion</a></td>
                </tr>
                <%}%>
            </tbody>
        </table>
        </div>
            
            
            
        <hr>
        
        <h3>VERIFICACIÓN DE DOCUMENTOS</h3>
        <div>
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
        </div>
</body>
</html>
