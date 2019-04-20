<%--
  Created by IntelliJ IDEA.
  User: Alexander Goodkind amg540
  Date: 2019-04-17
  Time: 20:03
  To change this template use File | Settings | File Templates.


--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--Contributers: Alexander Goodkind amg540--%>
<!DOCTYPE html>
<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>
<sql:query dataSource="${dataSource}" var="account_details">
    select *
    from Account
    where id = ${param.account_id};
</sql:query>

<html>
<head>
    <meta charset="UTF-8">
    <title><c:out value="${account_details.rows[0].first_name} ${account_details.rows[0].last_name} " />'s Profile - buyMe</title>
</head>
<body>

<t:logged_in_header/>



<sql:query dataSource="${dataSource}" var="all_items">
    select *
    from List_Active_Auctions where account_id = ${param.account_id};
</sql:query>

<h3><c:out value="${account_details.rows[0].first_name} ${account_details.rows[0].last_name}" />'s Profile</h3>

<p>Here are the auctions that this user has started:</p>

<table border="1" cellpadding="5">
    <tr>
        <th>Item Name</th>
        <th>Item Category</th>
        <th>Current Bid</th>
        <th>End Date</th>
        <th></th>
    </tr>

    <c:forEach var="row" items="${all_items.rows}">
        <tr>
            <td><c:out value="${row.item_name}"/></td>
            <td><c:out value="${row.item_type}"/></td>
            <td><c:out value="${row.current_bid}"/></td>
            <td><c:out value="${row.closing_datetime}"/></td>
            <td>
                <form>
                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">View Auction
                    </button>
                </form>
            </td>
            <td><c:if test="${row.auction_closed == 1}">
                Auction Closed
            </c:if></td>

        </tr>
    </c:forEach>
</table>

<sql:query dataSource="${dataSource}" var="result">
    select ci.item_name,
    a.auction_id,
    if(NOW() > closing_datetime, 1, 0) as auction_closed,
    if(NOW() > closing_datetime and max(b1.amount) > b.current_bid, 1, 0) as lost_auction,
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
    and b.account_id = ${param.account_id};
</sql:query>


<p>Here are the auctions that this user has participated in as a buyer (bidder):<p>

<table border="1" cellpadding="5">
    <tr>
        <th>Item</th>
        <th></th>
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

            <c:if test="${row.auction_closed == 1}">
                <td>
                    Winner: ${row.highest_bidder_first_name} ${row.highest_bidder_last_name}
                    <form>
                        <button value="${row.highest_bidder_email_address}" name="email_address"
                                formaction="contact_form.jsp">
                        </button>
                    </form>
                </td>
            </c:if>

            <td>
                <form>
                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">View
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>