<%-- 
    Document   : index
    Created on : 19-may-2018, 17:46:50
    Author     : Fernando Chata
--%>

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
        
        <title>Ingreso a Sistema de Gestión de Permisos</title>
        
        <style type="text/css">
            html, body{height:100%; width:100%;}
            .login-block{
                background:rgb(20, 122, 75);
                background:-webkit-linear-gradient(to bottom,rgb(255, 255, 255),rgb(8, 100, 20));
                background:linear-gradient(to bottom,rgb(255, 255, 255),rgb(8, 100, 20));
                float:left;width:100%;height:100%;display:flex;flex-direction: column; justify-content: center;}
            .container{background:#fff; border-radius: 10px; box-shadow:15px 20px 0px rgba(0,0,0,0.1);}
            .banner-horizontal{ display: flex; justify-content: center;}
            .banner-vertical{display: flex; flex-direction: column; justify-content: center;}
            .login-sec{padding: 50px 30px; position:relative;}
            .login-sec .copy-text{position:absolute; width:80%; bottom:20px; font-size:13px; text-align:center;}
            .login-sec .copy-text i{color:#007b5e;} /*#FEB58A*/
            .login-sec .copy-text a{color:#E36262;}
            .login-sec h2{margin-bottom:30px; font-weight:800; font-size:30px; color: rgb(15, 160, 70);}
            .login-sec h2:after{content:" "; width:100px; height:5px; background:rgb(15, 160, 70); display:block; margin-top:20px; border-radius:3px; margin-left:auto;margin-right:auto}
            .btn-login{background: rgb(15, 160, 70); color:#fff; font-weight:600;}

            .modal {display: none;position: fixed;z-index: 1;padding-top: 100px;left: 0;top: 0;overflow: auto;background-color: rgb(0,0,0);background-color: rgba(0,0,0,0.4);}
            .modal-content {background-color: #fefefe;margin: auto;padding: 20px;border: 1px solid #888;width: 80%;}
        </style>
        
    </head>
    <body>
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
        
        <section class="login-block">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 login-sec">
                        <h2 class="text-center">Sistema de Gestión de Permisos</h2>
                        <form class="login-form" name="form" id="form"  action="ValidarIngreso" method="POST">
                            <div class="form-group">
                                <label for="exampleInputEmail1" class="text-uppercase">Rut</label>
                                <input required id="rutUsuario" type="text"  name="rutUsuario" value="" class="form-control" placeholder="Sin digito verificador">  
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1" class="text-uppercase">Clave</label>
                                <input required id="claveUsuario" type="password"  name="claveUsuario" class="form-control" placeholder="Ingrese su clave">
                            </div>
                                <div class="form-check">
                                <button type="submit" class="btn btn-login float-right">Ingresar</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 banner-horizontal">
                        <div class="banner-vertical">
                                <img class="d-block img-fluid" src="imagenes/LogoMunicipalidad.png" alt="logo municipalidad">
                            </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
