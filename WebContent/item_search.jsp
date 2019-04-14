<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item List - buyMe</title>
</head>
<body>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="all_items">
    select *
    from Clothing_Item;
</sql:query>



 <% String filter = request.getParameter("item_type");
 if (filter == null) { %>
<h3>Filter results</h3>
<form method="post" action="item_search.jsp">
    <input type="radio" name="item_type" value="accessories">Accessories<br>
    <input type="radio" name="item_type" value="pants" >Pants<br>
    <input type="radio" name="item_type" value="shirts" >Shirts<br>
    <input type="radio" name="item_type" value="undergarments" >Undergarments<br>
    <input type="submit" value="Apply Filters">
</form>
<%
    } else {
     switch(filter) {
         case pants:
         case accessories:
         case shirts:
         case undergarments:
     }
%>
<%--            <input type="dropdown" name="pant_cut" value="pants" >Pants<br>--%>
<%--  <input type="...... --%>


<%
    } // last submit will send a post request to itemResults.jsp
 %>

</body>
</html>