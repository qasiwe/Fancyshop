<%-- 
    Document   : index
    Created on : Nov 19, 2016, 5:19:31 AM
    Author     : k_p0w3r
--%>
<%@page import="java.util.Vector"%>
<%@page import="source.*"%>
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
        <script src="javascript.js"></script>
    </head>

    <body>
        <div class="container">
            <div class="top"> 
                <h1 id="title" class="hidden"><div id="logo"><img src="images/F.png" alt="Logo" height="250" width="250"></div></h1> 
            </div>
            <form action="NewServlet">
                <%
                    HttpSession ses = request.getSession();
                    ses.setAttribute("RegError", "");
                    if (ses.getAttribute("logon") != null) {
                        response.sendRedirect("main.jsp");
                    }
                    ses.setAttribute("from", "login");
                    if (ses.getAttribute("from") != null && !ses.getAttribute("from").equals("login")) {
                        ses.setAttribute("LogError", "");
                    }
                    if (ses.getAttribute("LogError") == null) {
                        ses.setAttribute("LogError", "");
                    }
                %>
                <div class="login-box animated fadeInUp">
                    <div class="box-header">
                        <h2>Log In</h2>
                    </div>
                    <span id="logerror" class="error"><%=ses.getAttribute("LogError")%></span>
                    </br>
                    <label for="username">Email</label>
                    <br/>
                    <span id="email_validation" class="error"></span>
                    </br>
                    <input type="text" placeholder="example@mail.com" name="email" id="username">
                    <br/>
                    <label for="password">Password</label>
                    <br/>
                    <input name="pass" type="password" placeholder="Your Password" id="password">
                    <br/>
                    <button type="submit" margin="5">Sign In</button>
                    </br>
                    </br>
                    <button type="button" onclick="location.href = 'registration.jsp';">Registration</button>
                    <br/>

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

