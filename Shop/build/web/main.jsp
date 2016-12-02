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
        <title>Main Catalogue</title>
        <link rel="stylesheet" href="main_css/style.css" type="text/css" media="all" />

        <script>
            
            
            function callSearch(){               
                
                var myText = document.getElementById("find").value;
                document.location.href="search.jsp?text="+myText;
            }
            
            
            function clickB(id) {
                var elements = document.getElementsByName(id);
                if (elements[0].innerHTML === "<span>Add to Cart</span>") {
                    elements[0].innerHTML = "<span>Remove</span>";
                    elements[0].className = "button3";
                    elements[1].innerHTML = "<span>Remove</span>";
                    elements[1].className = "button3";
                    document.location.href = "Add?id=" + id;
                } else {
                    elements[0].innerHTML = "<span>Add to Cart</span>";
                    elements[0].className = "button4";
                    elements[1].innerHTML = "<span>Add to Cart</span>";
                    elements[1].className = "button4";
                    document.location.href = "Delete?id=" + id;
                }
            }
            

        </script>
        <script src="main_css/js/jquery-1.4.1.min.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.jcarousel.pack.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery.slide.js" type="text/javascript"></script> 
        <script src="main_css/js/jquery-func.js" type="text/javascript"></script>
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
                            <li><a href="#" class="active"><span>Electronics</span></a></li>
                            <li><a href="#" class="red"><span>Mobile Gadgets</span></a></li>
                            <li><a href="#" class="red"><span>Computers</span></a></li>
                            <li><a href="#" class="active"><span>Software</span></a></li>
                            <li><a href="#" class="red"><span>Operating systems</span></a></li>
                            <li><a href="#" class="red"><span>Games</span></a></li>
                        </ul>
                    </div>
                    <!-- Tabs -->
                    <!-- Container -->
                    <div id="container">

                        <div class="tabbed">
                            <!-- Electronics Tab Content -->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            query = "SELECT * FROM kenessary_koishybay.electronics;";
                                            Vector<Vector<Object>> electronics = db.searchSQL(query);
                                            for (int i = 0; i < electronics.size(); i++) {
                                                Vector<Object> electronic = electronics.get(i);
                                                int id = (Integer) electronic.get(4);
                                                int j = 0;
                                                for (; j < allproducts.size(); j++) {
                                                    int m = (Integer) allproducts.get(j).get(0);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> product = allproducts.get(j);
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
                                                Manufacturer: <a href="#"><%=electronic.get(3)%></a><br />
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
                            <!-- End First Tab Content -->

                            <!-- Mobile Tab Content -->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            query = "SELECT * FROM kenessary_koishybay.mobile_gadgets;";
                                            Vector<Vector<Object>> mobiles = db.searchSQL(query);
                                            System.out.println(mobiles.toString());
                                            for (int i = 0; i < mobiles.size(); i++) {
                                                Vector<Object> mobile = mobiles.get(i);
                                                int id = (Integer) mobile.get(1);
                                                int j = 0;
                                                for (; j < allproducts.size(); j++) {
                                                    int m = (Integer) allproducts.get(j).get(0);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                int k = 0;
                                                for (; k < electronics.size(); k++) {
                                                    int m = (Integer) electronics.get(k).get(4);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> elc = electronics.get(k);

                                                Vector<Object> product = allproducts.get(j);
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
                                                Manufacturer: <a href="#"><%=elc.get(3)%></a><br />
                                                Stock : <span><%=product.get(4)%></span><br />
                                                Price: <strong><%=product.get(2)%></strong>
                                            </p><br/>

                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                    <div class="cl">&nbsp;</div>
                                </div>
                            </div>
                            <!-- End Second Tab Content -->

                            <!-- Computers Tab Content -->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            query = "SELECT * FROM kenessary_koishybay.computers;";
                                            Vector<Vector<Object>> comps = db.searchSQL(query);
                                            System.out.println(comps.toString());
                                            for (int i = 0; i < comps.size(); i++) {
                                                Vector<Object> comp = comps.get(i);
                                                int id = (Integer) comp.get(1);
                                                int j = 0;
                                                for (; j < allproducts.size(); j++) {
                                                    int m = (Integer) allproducts.get(j).get(0);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                int k = 0;
                                                for (; k < electronics.size(); k++) {
                                                    int m = (Integer) electronics.get(k).get(4);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> elc = electronics.get(k);
                                                Vector<Object> product = allproducts.get(j);
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
                                                Manufacturer: <a href="#"><%=elc.get(3)%></a><br />
                                                Type : <span><%=comp.get(0)%></span><br />
                                                Stock : <span><%=product.get(4)%></span><br />
                                                Price: <strong><%=product.get(2)%></strong>
                                            </p><br/>

                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                    <div class="cl">&nbsp;</div>
                                </div>
                            </div>
                            <!-- End Third Tab Content -->


                            <!-- Software Tab Content-->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            query = "SELECT * FROM kenessary_koishybay.software;";
                                            Vector<Vector<Object>> software = db.searchSQL(query);
                                            for (int i = 0; i < software.size(); i++) {
                                                Vector<Object> soft = software.get(i);
                                                int id = (Integer) soft.get(1);
                                                int j = 0;
                                                for (; j < allproducts.size(); j++) {
                                                    int m = (Integer) allproducts.get(j).get(0);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> product = allproducts.get(j);
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
                                                Requirements:<span> <%=soft.get(0)%></span><br />
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

                            <!-- Operating Systems Tab Content-->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            query = "SELECT * FROM kenessary_koishybay.operating_systems;";
                                            Vector<Vector<Object>> ops = db.searchSQL(query);
                                            for (int i = 0; i < ops.size(); i++) {
                                                Vector<Object> os = ops.get(i);
                                                int id = (Integer) os.get(2);
                                                int j = 0;
                                                for (; j < allproducts.size(); j++) {
                                                    int m = (Integer) allproducts.get(j).get(0);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> product = allproducts.get(j);

                                                int k = 0;
                                                for (; k < allproducts.size(); k++) {
                                                    int m = (Integer) software.get(k).get(1);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> soft = software.get(k);
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
                                                Requirements:<span> <%=soft.get(0)%></span><br />                                                
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

                            <!-- Games Tab Content-->
                            <div class="tab-content" style="display:block;">
                                <div class="items">
                                    <div class="cl">&nbsp;</div>
                                    <ul>
                                        <%
                                            query = "SELECT * FROM kenessary_koishybay.games;";
                                            Vector<Vector<Object>> games = db.searchSQL(query);
                                            for (int i = 0; i < games.size(); i++) {
                                                Vector<Object> game = games.get(i);
                                                int id = (Integer) game.get(2);
                                                int j = 0;
                                                for (; j < allproducts.size(); j++) {
                                                    int m = (Integer) allproducts.get(j).get(0);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> product = allproducts.get(j);

                                                int k = 0;
                                                for (; k < allproducts.size(); k++) {
                                                    int m = (Integer) software.get(k).get(1);
                                                    if (m == id) {
                                                        break;
                                                    }
                                                }
                                                Vector<Object> soft = software.get(k);
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
                                                Requirements:<span> <%=soft.get(0)%></span><br />    
                                                Type:<span> <%=game.get(0)%></span><br /> 
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
