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
	
				// Query DB for this user
	
				String select = "SELECT COUNT(*) FROM Account WHERE email_address= ? AND account_password= ?";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(select);
	
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, email);
				ps.setString(2, password);
				//Run the query against the DB
				ResultSet result = ps.executeQuery();
				result.next();
				int numberOfAccounts = result.getInt("COUNT(*)");
				if (numberOfAccounts < 1) { // no accounts w this info
					out.print("<p>Account does not exist with that email and password combination.</p>");
					throw new Exception("mismatched name / pass");
				}

				// get account id

				select = "SELECT id FROM Account WHERE email_address= ? AND account_password= ?";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				ps = con.prepareStatement(select);
				ps.setString(1, email);
				ps.setString(2, password);
				result = ps.executeQuery();
				result.next();
				int account_id = result.getInt("id");

	
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();

				// set the cookie so we know they logged in
	
				out.print("<p>Login succeeded! Redirecting...</p>");

				Cookie is_logged_in = new Cookie("logged_in","true");
				Cookie logged_in_account_id =  new Cookie("account_id", Integer.toString(account_id));
				is_logged_in.setMaxAge(60*60*24);
				logged_in_account_id.setMaxAge(60*60*24);
				System.out.print("login yes");

				// Add both the cookies in the response header.
				response.addCookie( is_logged_in );
				response.addCookie( logged_in_account_id );
				response.sendRedirect("index.jsp"); // go back to page that will now be updated with the cookie logged in

			} catch (Exception ex) {
				out.print(ex);
				out.print("<p>Login failed.</p>");
			}
		%>
	</body>
</html>