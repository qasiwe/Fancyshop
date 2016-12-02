<%-- 
    Document   : item
    Created on : Nov 23, 2016, 1:27:19 PM
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
        <title>Item Page</title>
        <link rel="stylesheet" href="css_item/style.css" type="text/css" media="all" />
        <script>
            function clickB(id) {
                var button = document.getElementById('myButton');
                if (button.innerHTML === "<span>Add to Cart</span>") {
                    button.innerHTML = "<span>Remove</span>";
                    button.className = "button2";
                    document.location.href = "Add?id=" + id;
                } else {
                    button.innerHTML = "<span>Add to Cart</span>";
                    button.className = "button1";
                    document.location.href = "Delete?id=" + id;
                }
            }

            function callSearch() {

                var myText = document.getElementById("find").value;
                document.location.href = "search.jsp?text=" + myText;
            }
        </script>
        <script src="main_css/js/jquery-1.4.1.min.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.jcarousel.pack.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.slide.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery-func.js" type="text/javascript"></script>
    </head>
    <body>
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
                            <li><a href="#" class="active"><span>Description</span></a></li>

                        </ul>
                    </div>
                    <!-- Tabs -->

                    <%
                        HttpSession ses = request.getSession();
                        DatabaseClient db = (DatabaseClient) ses.getAttribute("Database");

                        int prod_id = Integer.valueOf(request.getParameter("item_id"));
                        int cos_id = (Integer) ses.getAttribute("cos_id");
                        String query = "SELECT * FROM kenessary_koishybay.product WHERE ID = " + prod_id + ";";
                        Vector<Object> product = db.searchSQL(query).get(0);
                        System.out.println(product.toString());
                    %>

                    <!-- Container -->
                    <div id="container">

                        <div class="tabbed">

                            <!-- First Tab Content -->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <div id="w">
                                        <!-- CODE   -->
                                        <div class="w1">
                                            <img class="tovar" src="main_css/images/<%=prod_id%>.jpg" alt="Smiley face"  width="300px">

                                        </div>

                                        <div class="w2">
                                            <table style="width:100%">
                                                <tr>
                                                    <td class="lef">ID:</td>
                                                    <td class="rig"><%=prod_id%></td>
                                                </tr>

                                                <tr>
                                                    <td class="lef">Name:</td>
                                                    <td class="rig"><%=product.get(3)%></td>
                                                </tr>
                                                <tr>
                                                    <td class="lef">Description:</td>
                                                    <td class="rig"><%=product.get(1)%></td>
                                                </tr>
                                                <tr>
                                                    <td class="lef">Stock:</td>
                                                    <td class="rig"><%=product.get(4)%></td>
                                                </tr>
                                                <tr>
                                                    <td class="lef">Price:</td>
                                                    <td class="rig"><%=product.get(2)%> tg</td>
                                                </tr>
                                            </table>

                                        </div>


                                        <div class="cl">&nbsp;</div>
                                        <!-- END CODE   --> 
                                        <div class="w3">
                                            <%
                                                query = "SELECT * FROM buy_items WHERE Customer_ID=" + cos_id + " AND Product_ID =" + prod_id + " AND payment_status=0;";
                                                Vector<Vector<Object>> data = db.searchSQL(query);

                                                if (data.size() == 0) {
                                            %>
                                            <button class="button1" id = "myButton" style="vertical-align:middle" onclick="clickB(<%=prod_id%>);"><span>Add to Cart</span></button>
                                            <%
                                            } else {
                                            %>
                                            <button class="button2" id = "myButton" style="vertical-align:middle" onclick="clickB(<%=prod_id%>);"><span>Remove</span></button>
                                            <%}
                                            %>

                                        </div>
                                        <hr>
                                    </div>
                                </div>
                                <!-- End First Tab Content -->



                            </div>

                            <!-- Brands -->


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
