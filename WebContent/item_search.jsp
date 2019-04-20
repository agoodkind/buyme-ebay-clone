<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--
Contributers:
Alexander Goodkind amg540
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search for an item - buyMe</title>
</head>
<body>

<t:logged_in_header/>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>


<form>
    Search query: <input type="text" minlength="3" name="s_query" placeholder="Search.."/><br/>
    Filter by:
    <select>
        <option name="column_name" value="item_type">Item Type</option>
        <option name="column_name" value="size">Size</option>
        <option name="column_name" value="gender">Gender</option>
        <option name="column_name" value="current_bid">Current Bid</option>
        <option name="column_name" value="closing_datetime">Closing Date</option>
    </select><br>
    Order:
    <select>
        <option name="order" value="asc">Ascending</option>
        <option name="order" value="desc">Descending</option>
    </select>
    <button formmethod="get" formaction="item_search.jsp">Search</button>
    <br/>
    <button formmethod="get" name="advanced" value="true" formaction="item_search.jsp">Continue to Advanced Search
    </button><br><br>
</form>
<c:choose>
    <c:when test="${not empty param.advanced}">
        <c:set var="auction_search" value="${param.auction_search}"/>
        <c:set var="s_query" value="${param.s_query}" scope="session"/>
        <jsp:forward page="advanced_search.jsp"/>
    </c:when>
    <c:when test="${not empty param.s_query and empty param.advanced and empty param.forwarded_from}">
        <sql:query dataSource="${dataSource}" var="results">
            select *
            from List_Active_Auctions l join Clothing_Item c
            where NOW() < closing_datetime
            and l.item_id = c.item_id
            and closing_datetime > NOW()
            and c.item_name LIKE '%<c:out value="${param.s_query}" escapeXml="true"/>%'
            <c:if test="${not empty param.column_name}">
                order by ${param.column_name}  <c:out value="${param.order}"/>
            </c:if>
            ;
        </sql:query>


        <c:choose>
            <c:when test="${not empty results}">
                <table border="1" cellpadding="5">

                    <tr>
                        <th>Auction Name</th>
                        <th>Item Category</th>
                    </tr>

                    <c:forEach var="row" items="${results.rows}">
                        <tr>
                            <td><c:out value="${row.item_name}"/></td>
                            <td><c:out value="${row.item_type}"/></td>

                            <td>
                                <form>
                                    <c:set var="forward_to" value="individual_item.jsp" scope="session"/>
                                    <%
                                        Cookie forward_to = new Cookie("forward_to", "individual_item.jsp");
                                        response.addCookie(forward_to);
                                    %>
                                    <button value="${row.auction_id}" name="auction_id" formaction="view_auction.jsp">
                                        View Auction
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                No results found.
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${not empty advanced_query}">
        <%--store SQL in session and retrieve here and run--%>
        <sql:query dataSource="${dataSource}" var="advanced_results">
            ${advanced_query}
        </sql:query>
        <c:choose>
            <c:when test="${not empty advanced_results}">
                <table border="1" cellpadding="5">
                    <tr>
                        <th>Item Name</th>
                        <th>Item Type</th>
                        <c:forEach var="field_name" items="${field_list}">
                            <th>${field_name}</th>
                        </c:forEach>
                        <c:if test="${auction_search == 'true'}">
                            <th>Current Bid</th>
                            <th>Seller</th>
                            <th>End date</th>
                        </c:if>
                    </tr>

                    <c:forEach var="row" items="${advanced_results.rows}">
                        <tr>
                            <td><c:out value="${row.item_name}"/></td>
                            <td><c:out value="${row.item_type}"/></td>
                            <c:forEach var="field_value" items="${field_values}">
                                <td>${field_value}</td>
                            </c:forEach>
                            <c:choose>

                                <c:when test="${auction_search == 'true' and not empty row.auction_id}">
                                    <td>$<c:out value="${row.current_bid}"/></td>
                                    <sql:query dataSource="${dataSource}" var="row_result">
                                        select a.first_name, a.last_name, a.email_address
                                        from Account_Sells_In_Auction asia, Account a
                                        where asia.auction_id = ${row.auction_id};
                                    </sql:query>
                                    <td><c:out value="${row_result.rows[0].first_name}"/> <c:out
                                            value="${row_result.rows[0].last_name}"/> <c:out
                                            value="${row_result.rows[0].email_address}"/></td>

                                    <td><c:out value="${row.closing_datetime}"/></td>
                                </c:when>
                            </c:choose>
                            <td>
                                <form>
                                    <c:choose>

                                        <c:when test="${auction_search == 'true' and not empty row.auction_id}">
                                            ${row.auction_id}
                                            <button value="${row.auction_id}" name="auction_id"
                                                    formaction="view_auction.jsp">View Auction
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button value="${row.item_id}" name="item_id"
                                                    formaction="individual_item.jsp">View Item
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </td>

                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                No results found.
            </c:otherwise>
        </c:choose>
        <c:remove var="field_list" scope="session"/>
        <c:remove var="field_values" scope="session"/>
        <c:remove var="advanced_query" scope="session"/>
    </c:when>
</c:choose>

</body>
</html>