<%-- 
    Document   : index
    Created on : 19-may-2018, 17:46:50
    Author     : SGP
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso a Sistema de Gestión de Permisos</title>
    </head>
    <body>
        <h1>Ingreso a Sistema de Gestión de Permisos</h1>

        <img src="imagenes/LogoMunicipalidad.png" alt="Logo Municipalidad" style="width:200px;height:150px;">
                 
        <form name="form" id="form"  action="ValidarIngreso" method="POST">
            <input required id="rutUsuario" type="text"  name="rutUsuario" value="" placeholder="Rut">                                        
            <input required id="claveUsuario" type="password"  name="claveUsuario" placeholder="Clave">
            <label name="mensaje" id="mensaje" for="mensaje"><c:out value="${sessionScope.mensajeError}" /></label>
            <button type="submit"> Ingrese</button> 
        </form>
    </body>
</html>
