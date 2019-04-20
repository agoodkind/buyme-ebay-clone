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
    <c:when test="${not empty sessionScope.account_id and not empty sessionScope}">
        <t:logged_in_header/>

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
        <c:if test="${sessionScope.account_type == 'Administrator' or  sessionScope.account_type == 'Customer Service Representative'}">
            <p style="background-color: red; color: white;">
                <c:if test="${sessionScope.account_type == 'Customer Service Representative'}">
                    You are a Customer Service Representative.
                </c:if>
                <c:if test="${sessionScope.account_type == 'Administrator'}">
                    You are an Administrator.<br/>
                </c:if>
                A red background indicates an Administrative-<b>ONLY</b> area, potentially destructive actions are
                possible.<br/></p>
            <form style="background-color: red;">
                <c:if test="${sessionScope.account_type == 'Administrator'}">
                    <button formmethod="get" type="submit" formaction="manage_accounts.jsp">View and Manage Accounts
                    </button>
                    <br/>
                </c:if>
                <button formmethod="post" type="submit" formaction="sales_report_page.jsp">Sales Reports & Metrics</button>
                <br/>
            </form>
        </c:if>

        <sql:query dataSource="${dataSource}" var="result">
            select ci.item_name,
            a.auction_id,
            a.closing_datetime,
            if(NOW() > a.closing_datetime, 1, 0) as auction_closed,
            if(NOW() > a.closing_datetime and max(b1.amount) > b.current_bid, 1, 0) as lost_auction,
            a.current_bid,
            b.account_id,
            (select distinct b.account_id
            from Bids b2
            where b2.auction_id = a.auction_id
            and b2.amount =
            (select max(amount) from Bids b3 where b3.auction_id = a.auction_id)) as highest_bidder_account_id,
            (select a1.first_name
            from Account a1
            where a1.id = (select distinct b.account_id
            from Bids b2
            where b2.auction_id = a.auction_id
            and b2.amount =
            (select max(amount) from Bids b3 where b3.auction_id = a.auction_id))) as highest_bidder_first_name,
            (select a1.last_name
            from Account a1
            where a1.id = (select distinct b.account_id
            from Bids b2
            where b2.auction_id = a.auction_id
            and b2.amount =
            (select max(amount) from Bids b3 where b3.auction_id = a.auction_id))) as highest_bidder_last_name,
            (select a1.email_address
            from Account a1
            where a1.id = (select distinct b.account_id
            from Bids b2
            where b2.auction_id = a.auction_id
            and b2.amount =
            (select max(amount) from Bids b3 where b3.auction_id = a.auction_id))) as highest_bidder_email_address
            from Auction a,
            Account_Bids_On_Auction b,
            Bids b1,
            Clothing_Item ci
            where a.auction_id = b.auction_id
            and ci.item_id = a.item_id
            and b.account_id = ${cookie.account_id.value}
            order by closing_datetime desc;
        </sql:query>

        <c:choose>
            <c:when test="${result.rowCount > 0}">
                <p>Here are the auctions you have participated in as a buyer (bidder):
                <p>
                <table border="1" cellpadding="5">
                    <tr>
                        <th>Item</th>
                        <th>Current Bid</th>
                        <th></th>
                    </tr>

                    <c:forEach var="row" items="${result.rows}">
                        <tr>
                            <td><c:out value="${row.item_name}"/></td>
                            <td>
                                <c:out value="${row.current_bid}"/>
                            </td>
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

                            <c:if test="${row.auction_closed == 1}">
                                <td>
                                    Winner: ${row.highest_bidder_first_name} ${row.highest_bidder_last_name}
                                    <form>
                                        <button value="${row.highest_bidder_email_address}" name="email_address"
                                                formaction="contact_form.jsp">contact
                                        </button>
                                    </form>
                                </td>
                            </c:if>
                            <td>
                                <form>
                                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">
                                        View
                                        Auction
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                You have not participated in any auctions.
            </c:otherwise>
        </c:choose>


        <sql:query dataSource="${dataSource}" var="all_items">
            select *
            from List_Active_Auctions
            where account_id = ${cookie.account_id.value}
            order by closing_datetime desc;
        </sql:query>

        <c:choose>
            <c:when test="${all_items.rowCount > 0}">
                <p>Here are the auctions that you have started:</p>

                <table border="1" cellpadding="5">
                    <tr>
                        <th>Item Name</th>
                        <th>Item Category</th>
                        <th>Current Bid</th>
                        <th>End Date</th>
                    </tr>

                    <c:forEach var="row" items="${all_items.rows}">
                        <tr>
                            <td><c:out value="${row.item_name}"/></td>
                            <td><c:out value="${row.item_type}"/></td>
                            <td><c:out value="${row.current_bid}"/></td>
                            <td><c:out value="${row.closing_datetime}"/></td>

                            <td>
                                <form>
                                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">
                                        View
                                        Auction
                                    </button>
                                </form>
                            </td>
                            <c:if test="${row.auction_closed == 1}">
                                <td>Auction Closed</td>
                            </c:if>
                            <c:if test="${row.auction_closed == 1 and row.current_bid >= row.min_price}">
                                <td>
                                    <form>
                                        <button value="${row.highest_bidder_email_address}" name="email_address"
                                                formaction="contact_form.jsp">Contact Winner
                                        </button>
                                    </form>
                                </td>
                            </c:if>
                            <c:if test="${row.auction_closed != 1}">
                                <td>
                                    <form>
                                        <button name="end_auction_id" formaction="end_auction.jsp"
                                                value="${row.auction_id}">End Auction
                                        </button>
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                You have not started any auctions.
            </c:otherwise>
        </c:choose>
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