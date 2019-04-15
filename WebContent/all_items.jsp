<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Items - buyMe</title>
</head>
<body>

<t:logged_in_header />

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="all_items">
    select *
    from Clothing_Items;
</sql:query>

<table border="1" cellpadding="5">
    <tr>
    	<th>Item ID</th>
        <th>Item Name</th>
        <th>Item Category</th>
        <th>Size</th>
        <th>Gender</th>
    </tr>

    <c:forEach var="row" items="${all_items.rows}">
        <tr>
            <td><c:out value="${row.item_id}"/></td>
            <td><c:out value="${row.item_name}"/></td>
            <td><c:out value="${row.item_type}"/></td>
            <td><c:out value="${row.size}"/></td>
            <td><c:out value="${row.gender}"/></td>
            <td><form><button value="${row.item_id}" name="item_id" formaction="add_to_wishlist.jsp">Add to Wishlist</button></form></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>