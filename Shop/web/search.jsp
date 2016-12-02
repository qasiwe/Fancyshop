<%-- 
    Document   : another
    Created on : Nov 20, 2016, 12:32:16 PM
    Author     : k_p0w3r
--%>

<%@page import="java.util.Vector"%>
<%@page import="source.DatabaseClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getSession().getAttribute("logon") != null) {
        if (!((Boolean) request.getSession().getAttribute("logon"))) {
            response.sendRedirect("login.jsp");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <title>Search Results</title>
        <link rel="stylesheet" href="main_css/style.css" type="text/css" media="all" />

        <script src="main_css/js/jquery-1.4.1.min.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.jcarousel.pack.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.slide.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery-func.js" type="text/javascript"></script>
        <script>
            function callSearch() {

                var myText = document.getElementById("find").value;
                document.location.href = "search.jsp?text=" + myText;
            }


            function clickB(id) {
                var elements = document.getElementsByName(id);
                if (elements[0].innerHTML === "<span>Add to Cart</span>") {
                    
                    document.location.href = "Add?id=" + id;
                    elements[0].innerHTML = "<span>Remove</span>";
                    elements[0].className = "button3";
                    elements[1].innerHTML = "<span>Remove</span>";
                    elements[1].className = "button3";
                } else {
                    
                    document.location.href = "Delete?id=" + id;
                    elements[0].innerHTML = "<span>Add to Cart</span>";
                    elements[0].className = "button4";
                    elements[1].innerHTML = "<span>Add to Cart</span>";
                    elements[1].className = "button4";
                }
            }


        </script>
    </head>
    <body>

        <%
            HttpSession ses = request.getSession();
            DatabaseClient db = (DatabaseClient) ses.getAttribute("Database");

            String query = "SELECT * FROM kenessary_koishybay.product;";
            Vector<Vector<Object>> allproducts = db.searchSQL(query);
            int cos_id = (Integer) ses.getAttribute("cos_id");
            Vector<Vector<Object>> cartproducts = (Vector<Vector<Object>>) ses.getAttribute("cos_cart");
        %>

        <!-- Main -->
        <div id="main">
            <div class="shell">

                <!-- Search, etc -->
                <div class="options">
                    <div class="search"> 
                        <span class="field"><input type="text" id="find" class="blink" value="SEARCH" title="SEARCH" /></span> 
                        <img class="search-submit" onclick = "callSearch()" /> 
                    </div>

                    <div class="left">
                        <span class="cart">
                            <a href="main.jsp" class="cart-ico"></a>
                        </span>
                        <span class="left more-links"> 
                            <a href="main.jsp" >                           
                                Main</a>
                        </span>
                    </div>
                    <div class="right">
                        <span class="left more-links"> 
                            <a href="cart.jsp" >                           
                                My Cart</a>
                            <a href="/Logout">Logout</a>
                        </span>
                    </div>
                </div>
                <!-- End Search, etc -->

                <!-- Content -->
                <div id="content">

                    <!-- Tabs -->
                    <div class="tabs">
                        <ul>
                            <li><span>Search Results</span></li>
                        </ul>
                    </div>
                    <!-- Tabs -->
                    <!-- Container -->
                    <div id="container">
                        <%
                            String search = request.getParameter("text");
                            query = "SELECT * FROM product WHERE Name like \'%"+search+"%\';";
                            Vector<Vector<Object>> results = db.searchSQL(query);
                        %>
                        <div class="tabbed">
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            for (int i = 0; i < results.size(); i++) {
                                                Vector<Object> product = results.get(i);
                                                int id = (Integer) product.get(0);
                                        %>
                                        <li>  
                                            <%
                                                query = "SELECT * FROM buy_items WHERE Customer_ID=" + cos_id + " AND Product_ID =" + id + " AND payment_status=0;";
                                                Vector<Vector<Object>> data = db.searchSQL(query);

                                                if (data.size() == 0) {
                                            %>
                                            <button class="button4" name = "<%=id%>" style="vertical-align:middle" onclick="clickB(<%=id%>);"><span>Add to Cart</span></button>
                                            <br />
                                            <br />
                                            <%} else {%>
                                            <button class="button3" name = "<%=id%>" style="vertical-align:middle" onclick="clickB(<%=id%>);"><span>Remove</span></button>
                                            <br />
                                            <br />
                                            <%
                                                }
                                            %>

                                            <div class="image">


                                                <a href="item.jsp?item_id=<%=id%>"><img width="130"
                                                                                        height="90" src="main_css/images/<%=id%>.jpg" alt="" /></a>
                                            </div>
                                            <p>
                                                Name: <span><%=product.get(3)%></span><br />               
                                                Stock : <span><%=product.get(4)%></span><br />
                                                Price: <strong><%=product.get(2)%></strong>
                                            </p>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                    <div class="cl">&nbsp;</div>
                                </div>
                            </div>
                            <%
                                if (results.size() < 1) {

                            %>
                            <div class="noresult">
                                <span class="nofound">Sorry, no results found</span>
                                <br>
                                <img class="sadyface" src="images/sad.ico" alt="Smiley face" height="256" width="256">
                            </div>
                            <%                                        }
                            %>
                            <!-- end of tabs-->
                        </div>


                        <!-- Footer -->
                        <div id="footer">
                            <div class="left">
                                <span>|</span>
                                <a href="main.jsp">The Store</a>
                                <span>|</span>
                            </div>
                            <div class="right">
                                &copy; FancyShop.com 
                            </div>
                        </div>
                        <!-- End Footer -->

                    </div>
                    <!-- End Container -->

                </div>
                <!-- End Content -->

            </div>
        </div>
        <!-- End Main -->

    </body>
</html>
