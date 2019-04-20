<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--
Contributers:
Amulya Mummaneni asm229,
Madhumitha Sivaraj ms2407
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<t:logged_in_header/>
<%
    try {

        //Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        //Create a SQL statement
        Statement stmt = con.createStatement();
        //Get parameters from the HTML form at the HelloWorld.jsp
        String message_subject = request.getParameter("message_subject");
        String content = request.getParameter("content");
        String message_recipient = request.getParameter("message_recipient");

        PreparedStatement ps;
       	ps=con.prepareStatement("select * from Account where email_address=?");
       	ps.setString(1, message_recipient);
       	
       
        ResultSet result = ps.executeQuery();
        result.next();
        String email = result.getString("email_address");
       	if(email==null){
       		con.close();
       		out.print("User does not exist");
       		throw new Exception("User does not exist");
       	}

       	String to_account_id=result.getString("id");

        Cookie cookie = null;
        Cookie[] cookies = null;
        int account_id = 0;
        // Get an array of Cookies associated with this domain
        cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                if (cookie != null && (cookie.getName()).compareTo("account_id") == 0) {
                    account_id = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }

        if(account_id == 0){
       		con.close();
       		out.print("Cannot send email when not logged in");
       		throw new Exception("Cannot send email when not logged in");
       	}

    	ps = con.prepareStatement("insert into Email (message_subject, content, timesent, from_account_id, to_account_id) values(?, ?, NOW(), ?, ?)");
    	
        ps.setString(1, message_subject);
        ps.setString(2, content);
        ps.setString(3, Integer.toString(account_id));
        ps.setString(4, to_account_id);

		//Run the query against the DB
		ps.executeUpdate();
       
        //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();

        out.print("<p>Email Sent!</p>");

    } catch (Exception ex) {
        out.print(ex);
        out.print("<p>Email creation failed</p>");
    }
%>
</body>
</html>