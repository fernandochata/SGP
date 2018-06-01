<%-- 
    Document   : menuInterno
    Created on : 20-may-2018, 3:14:29
    Author     : SGP
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
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ArrayList<PermisoDTO> permisosDepartamento = (ArrayList<PermisoDTO>)request.getSession().getAttribute("permisosDepartamento");
            ArrayList<PermisoDTO> permisosEstadoDepartamento = (ArrayList<PermisoDTO>)request.getSession().getAttribute("permisosEstadoDepartamento");
            
            UsuarioDTO usuario = (UsuarioDTO)request.getSession().getAttribute("usuario");
            
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            UsuarioPerfilDAO usuarioPerfilDAO = new UsuarioPerfilDAO();
            UsuarioDepartamentoDAO usuarioDepartamentoDAO = new UsuarioDepartamentoDAO();
            UsuarioCargoDAO usuarioCargoDAO = new UsuarioCargoDAO();
            
            PermisoEstadoDAO permisoEstadoDAO = new PermisoEstadoDAO();
            PermisoMotivoDAO permisoMotivoDAO = new PermisoMotivoDAO();
            PermisoResolucionDAO permisoResolucionDAO = new PermisoResolucionDAO();
            PermisoTipoDAO permisoTipoDAO = new PermisoTipoDAO();
        %>

        <p>
            <h1>Bienvenido(a)</h1>

            <br>
            <h3><label name="mensaje" id="mensaje" for="mensaje"><c:out value="${sessionScope.mensajeError}" /></label></h3>

            <br>
            <table border="2">
                <thead>
                    <tr>
                        <td>Nombre:</td>
                        <td><%=usuario.getNombres() %> <%= usuario.getApellido_paterno() %> <%=usuario.getApellido_materno()%></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><a href="CerrarSesion">Cerrar Sesión</a></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Perfil:</td>
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
                </tbody>
            </table>
        </p>
        
        
        
        <br>
        <h3>AUTORIZACION DE PERMISOS</h3>
        <div>
        <table border="2">
            <thead>
                <tr>
                    <th>IDENTIFICADOR</th>
                    <th>FUNCIONARIO</th>
                    <th>SOLICITUD</th>
                    <th>DESDE</th>
                    <th>HASTA</th>
                    <th>DIAS</th>
                    <th>MOTIVO</th>
                    <th>DOCUMENTO</th>
                    <th>ESTADO</th>
                    <th>TIPO</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <% for (PermisoDTO permiso: permisosEstadoDepartamento)
                {%>
                <tr>
                    <form name="formAutorizar" id="formParental"  action="AutorizarPermiso">
                        <td><input type="text" name="id_permiso" id="id_permiso" value="<%=permiso.getId_permiso() %>"></td>
                        <td><%=usuarioDAO.read(permiso.getUsuario()).getNombres() %> <%=usuarioDAO.read(permiso.getUsuario()).getApellido_paterno() %> <%=usuarioDAO.read(permiso.getUsuario()).getApellido_materno() %></td>
                        <td><%=permiso.getFecha_creacion() %></td>
                        <td><%=permiso.getFecha_desde() %></td>
                        <td><%=permiso.getFecha_hasta() %></td>
                        <td><%=permiso.getDias() %></td>
                        <td><a href="#">Detalle Motivo</a></td>
                        <td><a href="#">Ver Documento</a></td>
                        <td><%=permisoEstadoDAO.read(permiso.getEstado()).getEstado() %></td>
                        <td><%=permisoTipoDAO.read(permiso.getTipo()).getTipo() %></td>
                        <td><button type="submit">AUTORIZAR</button></td>
                    </form>
                </tr>
                <%}%>
            </tbody>
        </table>
        </div>
            
            
        <h3>CONSULTAR PERMISOS</h3>
        <div>
            <table border="2">
            <thead>
                <tr>
                    <th>FUNCIONARIO</th>
                    <th>SOLICITUD</th>
                    <th>DESDE</th>
                    <th>HASTA</th>
                    <th>DIAS</th>
                    <th>ESTADO</th>
                    <th>TIPO</th>
                </tr>
            </thead>
            <tbody>
                <% for (PermisoDTO permiso: permisosDepartamento)
                {%>
                <tr>
                    <td><%=usuarioDAO.read(permiso.getUsuario()).getNombres() %> <%=usuarioDAO.read(permiso.getUsuario()).getApellido_paterno() %> <%=usuarioDAO.read(permiso.getUsuario()).getApellido_materno() %></td>
                    <td><%=permiso.getFecha_creacion() %></td>
                    <td><%=permiso.getFecha_desde() %></td>
                    <td><%=permiso.getFecha_hasta() %></td>
                    <td><%=permiso.getDias() %></td>
                    <td><%=permisoEstadoDAO.read(permiso.getEstado()).getEstado() %></td>
                    <td><%=permisoTipoDAO.read(permiso.getTipo()).getTipo() %></td>
                </tr>
                <%}%>
            </tbody>
        </table>
        </div>
            
            
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
