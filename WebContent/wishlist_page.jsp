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
					   user="${initParam['username']}"
					   password="${initParam['password']}"/>
					   
	<sql:query dataSource="${dataSource}" var="result">
		<%--select from wishlist items in lists owned by currently-logged-in user --%>
    	SELECT * FROM Wishlist w, Account a WHERE w.account_id = a.id and a.id = ${cookie.account_id.value};
	</sql:query>
	<div align="center">
        <table border="1" cellpadding="5">
            <caption><h2>Wishlist - buyMe</h2></caption>
            <tr>
                <th>Account ID</th>
                <th>List Name</th>
                <th>Item ID</th>
            </tr>
			<c:forEach var="result" items="${result.rows}">
				<tr>
 	
    			<td><c:out value="${result.account_id}" /></td>
 		
    			<td><c:out value="${result.list_name}" /></td>
 	
    			<td><c:out value="${result.item_id}" /></td>
 
 				</tr>
			</c:forEach>
		</table>
		 <form action="/action_page.php">
  			ItemID <input type="text" name="item_id"><br>
  			ListName <input type="text" name="list_name"><br>
  			AccountID <input type="text" name="account_id"><br>
  			<input type="submit" value="Delete From Wishlist" formaction="delete_from_wishlist.jsp">
		</form> 
    </div>


	</body>
</html>