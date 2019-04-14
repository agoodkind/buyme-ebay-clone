<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
	<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Wishlist - buyMe</title>
	</head>
	<body>
	
	<sql:setDataSource var="dataSource"
					   driver="${initParam['driverClass']}"
					   url="${initParam['connectionURL']}"
					   user="${initParam['michael@wang']}"
					   password="${initParam['test1234']}"/>
					   
	<sql:query dataSource="${dataSource}" var="result">
    	SELECT * FROM Wishlist;
	</sql:query>
	<div align="center">
        <table border="1" cellpadding="5">
            <caption><h2>Wishlist - buyMe</h2></caption>
            <tr>
                <th>Account ID</th>
                <th>List Name</th>
                <th>Item ID</th>
            </tr>
	<c:forEach var="Wishlist" items="${Wishlist.rows}">
 
    	<c:out value="${Wishlist.account_id}" />
 
    	<c:out value="${Wishlist.list_name}" />
 
    	<c:out value="${Wishlist.item_id}" />
 
	</c:forEach>
	</table>
    </div>

	</body>
</html>