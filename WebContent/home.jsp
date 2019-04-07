<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>
<sql:query dataSource="${dataSource}" var="result">
    select a.auction_id,
    if(NOW() > closing_datetime, 1, 0) as auction_closed,
    if(NOW() > closing_datetime and max(b1.amount) > b.current_bid, 1, 0) as lost_auction
    from Auction a,
    Account_Bids_On b,
    Bids b1
    where a.auction_id = b.auction_id
    and b.user_id = 8;
</sql:query>
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


</body>
</html>
