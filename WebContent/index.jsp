<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Group 37 DB 336 - buyMe.com</title>
	</head>
	<body>

	<sql:setDataSource var="dataSource"
					   driver="${initParam['driverClass']}"
					   url="${initParam['connectionURL']}"
					   user="${initParam['username']}"
					   password="${initParam['password']}"/>

	<c:choose>
		<c:when test="${cookie.containsKey('logged_in')}">
			<sql:query dataSource="${dataSource}" var="result">
				select a.auction_id,
				if(NOW() > closing_datetime, 1, 0) as auction_closed,
				if(NOW() > closing_datetime and max(b1.amount) > b.current_bid, 1, 0) as lost_auction
				from Auction a,
				Account_Bids_On_Auction b,
				Bids b1
				where a.auction_id = b.auction_id
				and b.account_id = ${cookie.account_id.value};
			</sql:query>

			<sql:query dataSource="${dataSource}" var="account_details">
				select *
				from Account
				where id = ${cookie.account_id.value};
			</sql:query>


			<h3>Welcome <c:out value="${account_details.rows[0].first_name} ${account_details.rows[0].last_name}!"></c:out></h3>

			<table>
				<tr>
					<th>auct ID</th>
					<th>auction status</th>
				</tr>

				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td><c:out value="${row.auction_id}"/></td>
						<td><c:choose>
							<c:when test="${row.auction_closed == 1 && row.lost_auction == 1}">
								you lost the auction
							</c:when>

							<c:when test="${row.auction_closed == 1 && row.lost_auction == 0}">
								You won the auction
							</c:when>

							<c:otherwise>
								Auction has not ended
							</c:otherwise>
						</c:choose></td>
					</tr>
				</c:forEach>
			</table>
			<form>
				<button type="submit" formaction="signout.jsp">Sign Out</button>
			</form>
		</c:when>

		<c:otherwise>
			<form>
				<button type="submit" formaction="login_form.jsp">Login</button>
				<button type="submit" formaction="signup_form.jsp">Sign Up</button>
				<button type="submit" formaction="Wishlist_Page.jsp">View Wishlist</button>
			</form>
		</c:otherwise>
	</c:choose>

	</body>
</html>