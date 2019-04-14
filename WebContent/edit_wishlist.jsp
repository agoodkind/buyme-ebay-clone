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
<meta charset="ISO-8859-1">
<title>Edit Wishlist</title>
</head>
<body>

<%
int id_of_item = Integer.parseInt(request.getParameter("item_id"));
String listname = request.getParameter("list_name");
int id_of_account = Integer.parseInt(request.getParameter("account_id"));
%>
<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="result">
INSERT INTO Wishlist(listname, item_id, account_id)
VALUES (listname, id_of_item, id_of_account)
</sql:query>

</body>
</html>