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
<title>Delete From Wishlist</title>
</head>
<body>

<%
try {
String id_of_item = request.getParameter("item_id");
String id_of_account = request.getParameter("account_id");

//Get the database connection
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();

//Create a SQL statement
				Statement stmt = con.createStatement();
	
				String select = "DELETE FROM Wishlist w WHERE w.account_id = ? and w.item_id=?;";

				
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(select);
			
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, id_of_account);
				ps.setString(3, id_of_item);
				
				//Run the query against the DB
				ps.executeUpdate();
				
				System.out.print("<p>Deletion from Wishlist succeeded! Please refresh</p>");

				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("<p>Delete from Wishlist Failed.</p>");
			}
%>

</body>
</html>