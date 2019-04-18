<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>




<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sales Report</title>
	</head>
	<body>
		<%
			try {
	
				//Get the database connection
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				Statement stmt = con.createStatement();
				
				double earnings;
				int count=0;
				
				ResultSet result=stmt.executeQuery("SELECT SUM(winner) as earnings FROM (SELECT B.Auction_id, MAX(amount) AS winner, upper_limit FROM Bids B, Auction A WHERE A.Auction_id = B.Auction_id AND (NOW() > closing_datetime) GROUP BY B.auction_number) AS closed WHERE winner >= upper_limit");
			    if(result.next()){
			    	earnings = result.getDouble("earnings");
			    }else{
			    	earnings = 0;
			    }
			    out.print("Total Earnings: $" + earnings + "<br>");
			    Statement stmt2 = con.createStatement();
			    ResultSet result2 = stmt2.executeQuery("SELECT COUNT(*) AS number_of_items FROM Auction");
			    if(result2.next()){
			    	count = result2.getInt("number_of_items");
			    }else{
			    	count = 1;
			    }
			    out.print("Earnings per Item: $" + (earnings/count)+"<br>");
			    
			    PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS number_of_items FROM Clothing_Item WHERE item_name = ?");
			    ps.setString(1, "Pants");
			    ResultSet result3 = ps.executeQuery();
			    if(result3.next()){
			    	count = result3.getInt("number_of_items");
			    }else{
			    	count = 1;
			    }
			    out.print("Earnings per Pants: $" + (earnings/count)+"<br><br>");
			    ps.setString(1, "Accessories");
			    ResultSet result4 = ps.executeQuery();
			    if(result4.next()){
			    	count = result4.getInt("number_of_items");
			    }else{
			    	count = 1;
			    }
			    out.print("Earnings per Accessories: $"+ (earnings/count) +"<br><br>");
			    
			    ps.setString(1, "Undergarments");
			    ResultSet result5 = ps.executeQuery();
			    if(result5.next()){
			    	count = result5.getInt("number_of_items");
			    }else{
			    	count = 1;
			    }
			    if(count == 0){
			    	count = 1;
			    }
			    out.print("Earnings per Undergarments: $"+ (earnings/count)+ "<br><br>");
			    
			    ps.setString(1, "Shirts");
			    ResultSet result6 = ps.executeQuery();
			    if(result6.next()){
			    	count = result6.getInt("number_of_items");
			    }else{
			    	count = 1;
			    }
			    out.print("Earnings per Shirts: $"+ (earnings/count)+ "<br><br>");
			    
				
			 	con.close();
			}catch (Exception ex) {
				out.print(ex);
				out.print("<p>Sales Report failed to generate.</p>");
			}
		%>
	</body>
</html>