<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%--
Contributers:
Alexander Goodkind amg540,
Amulya Mummaneni asm229,
Madhumitha Sivaraj ms2407,
Michael Wang mtw95
--%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>My Dashboard - buyMe.com</title>
</head>
<body>


<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<c:choose>
    <c:when test="${cookie.containsKey('logged_in')}">
        <t:logged_in_header/>

        <sql:query dataSource="${dataSource}" var="result">
            select
            ci.item_name,
            a.auction_id,
            if(NOW() > closing_datetime, 1, 0) as auction_closed,
            if(NOW() > closing_datetime and max(b1.amount) > b.current_bid, 1, 0) as lost_auction
            from Auction a,
            Account_Bids_On_Auction b,
            Bids b1,
            Clothing_Item ci
            where a.auction_id = b.auction_id
            and ci.item_id = a.item_id
            and b.account_id = ${cookie.account_id.value};
        </sql:query>

        <sql:query dataSource="${dataSource}" var="account_details">
            select *
            from Account
            where id = ${cookie.account_id.value};
        </sql:query>

        <h1>My Dashboard</h1>
        <h3>Welcome <c:out
                value="${account_details.rows[0].first_name} ${account_details.rows[0].last_name}!"/></h3>
        <%--        add customer representative stuff here if account_type is correct--%>
        <%--        add admin  stuff here if account_type is correct--%>
        <c:if test="${sessionScope.account_type == 'Administrator'}">
            <p style="background-color: red">You are an Administrator</p>
            Admin Account stuff goes here
        </c:if>

        <c:if test="${sessionScope.account_type == 'Customer Service Representative'}">
            <p style="background-color: blue">You are a Customer Service Representative (CSR)</p>
        </c:if>

        <c:if test="${sessionScope.account_type == 'Administrator' or sessionScope.account_type == 'Customer Service Representative'}">
csr stuff here
        </c:if>

        <p>Here is the auctions you are bidding in:
        <p>

        <table border="1" cellpadding="5">
            <tr>
                <th>Item</th>
                <th>Status</th>
                <th></th>
            </tr>

            <c:forEach var="row" items="${result.rows}">
                <tr>
                    <td><c:out value="${row.item_name}"/></td>
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
                    <td>
                        <form>
                            <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">View
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>


    </c:when>

    <c:otherwise> <!-- if logged out -->
        <form>
            <button formmethod="post" type="submit" formaction="login_form.jsp">Login</button>
            <button formmethod="post" type="submit" formaction="signup_form.jsp">Sign Up</button>
        </form>
    </c:otherwise>
</c:choose>

</body>
</html>