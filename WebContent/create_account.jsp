<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Create Account</title>
	</head>
	<body>
		<%
			try {
	
				//Get the database connection
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
	
				//Create a SQL statement
				Statement stmt = con.createStatement();
	
				//Get parameters from the HTML form at the HelloWorld.jsp
				String email = request.getParameter("email");
				String password = request.getParameter("password");
	
				if (email.length() == 0) { //if field is empty
					throw new InvalidFieldException("<p>Email field left empty.</p>");
				}
				if (password.length() == 0) {
					throw new InvalidFieldException("<p>Password field left empty.</p>");
				}
				
				PreparedStatement ps;
				
				
				// check if emaila already exists
				String checkString = "SELECT COUNT(*) FROM account WHERE email_address = ?";
				ps = con.prepareStatement(checkString);
				ps.setString(1, email);
				ResultSet result = ps.executeQuery();
				
				result.next();
				int numberOfAccounts = result.getInt("COUNT(*)");
				if (numberOfAccounts > 0) { // no accounts with this info
					con.close();
					throw new Exception("<p>Account already exists!</p>");
				}
				//Make an insert statement for the Sells table
				String insert = "INSERT INTO account(email_address, password)" + "VALUES (?, ?)";
	
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query

				ps = con.prepareStatement(insert);
	
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, email);
				ps.setString(2, password);
				//Run the query against the DB
				ps.executeUpdate();
				
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
	
				out.print("<p>Account created!</p>");
	
			} catch (Exception ex) {
				out.print(ex);
				out.print("<p>Account creation failed</p>");
			}
		%>
	</body>
</html>