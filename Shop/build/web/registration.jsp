<%-- 
    Document   : index
    Created on : Nov 19, 2016, 5:19:31 AM
    Author     : k_p0w3r
--%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /* */
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Login Page</title>

        <!-- Google Fonts -->
        <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700|Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

        <link rel="stylesheet" href="css/animate.css">
        <!-- Custom Stylesheet -->
        <link rel="stylesheet" href="css/style.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    </head>

    <body>
        <div class="container">
            <div class="top"> 
                <h1 id="title" class="hidden"><div id="logo"><img src="images/F.png" alt="Logo" height="250" width="250"></div></h1> 
            </div>
            <form action="NewServlet">
                <div class="login-box animated fadeInUp">
                    <div class="box-header">
                        <h2>Registration</h2>
                    </div>
                    <%
                        HttpSession ses = request.getSession();
                        ses.setAttribute("LogError", "");
                        if (ses.getAttribute("from") != null && ses.getAttribute("from").equals("login")) {
                            ses.setAttribute("RegError", "");
                        }
                        ses.setAttribute("from", "registration");
                        if (ses.getAttribute("RegError") == null) {
                            ses.setAttribute("RegError", "");
                        }
                    %>
                    <span class="error"><%=ses.getAttribute("RegError")%></span>
                    </br>
                    <label for="username">Email</label>
                    <br/>
                    <input name="reg_email" type="text" placeholder="example@mail.com"  id="username">
                    <br/>
                    <label for="password">Password</label>
                    <br/>
                    <input name="reg_pass" type="password" placeholder="password" id="password">
                    <br/>
                    <label for="payment">Payment Info</label>
                    <br/>
                    <input name="payment" type="text" placeholder="Payment details" id="payment">
                    <br/>
                    <button type="submit">Sign up</button>

                </div>
            </form>
        </div>
    </body>

    <script>
        $(document).ready(function () {
            $('#logo').addClass('animated fadeInDown');
            $("input:text:visible:first").focus();
        });
        $('#username').focus(function () {
            $('label[for="username"]').addClass('selected');
        });
        $('#username').blur(function () {
            $('label[for="username"]').removeClass('selected');
        });
        $('#password').focus(function () {
            $('label[for="password"]').addClass('selected');
        });
        $('#password').blur(function () {
            $('label[for="password"]').removeClass('selected');
        });
    </script>

</html>

