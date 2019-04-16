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
    <input type="text" minlength="3" name="s_query" placeholder="Search.."/>
    <input type="checkbox" name="auction_search" value="true">Search Auctions
    <button formmethod="post" formaction="item_search.jsp">Search</button>
    <button formmethod="post" name="advanced" value="true" formaction="item_search.jsp">Continue to Advanced Search
    </button>
</form>
<c:choose>
    <c:when test="${not empty param.advanced}">
        <c:set var="s_query" value="${param.s_query}" scope="session"/>
        <jsp:forward page="advanced_search.jsp"/>
    </c:when>
    <c:when test="${not empty param.s_query and empty param.advanced and empty param.forwarded_from}">
        <sql:query var="results">
            select item_name, item_type, item_id from
            Clothing_Item
            where item_name LIKE '%${param.s_query}';
        </sql:query>

        <c:choose>
            <c:when test="${not empty results}">
                <table border="1" cellpadding="5">
                    <tr>
                        <th>Item Name</th>
                        <th>Item Category</th>
                        <th></th>
                    </tr>

                    <c:forEach var="row" items="${results.rows}">
                        <td><c:out value="${row.item_name}"/></td>
                        <td><c:out value="${row.item_type}"/></td>
                        <td>
                            <form>
                                <button value="${row.item_id}" name="auction_id" formaction="individual_item.jsp">View
                                    Item
                                </button>
                            </form>
                        </td>
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
        <sql:query var="advanced_results">
            ${advanced_query}
        </sql:query>

        <table border="1" cellpadding="5">
            <tr>
                <th>Item Name</th>
                <th>Item Category</th>
                <c:forEach var="field_name" items="${field_list}">
                    <th>${field_name}</th>
                </c:forEach>
                <c:choose>
                    <c:when test="${auction_search == 'true' and row.auction_id > 0}">
                        <td><c:out value="${row.}"</td>
                    </c:when>
                </c:choose>
            </tr>

            <c:forEach var="row" items="${results.rows}">
                <td><c:out value="${row.item_name}"/></td>
                <td><c:out value="${row.item_type}"/></td>
                <td>
                    <form>
                        <c:choose>
                            <c:when test="${auction_search == 'true' and row.auction_id > 0}">
                                <button value="${row.auction_id}" name="auction_id" formaction="individual_item.jsp">
                                    View
                                    Auction
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button value="${row.item_id}" name="item_id" formaction="individual_item.jsp">View
                                    Item
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </td>
                <c:choose>
                    <c:when test="${auction_search == 'true' and row.auction_id > 0}">
                        <td><c:out value="${row.}"</td>
                    </c:when>
                </c:choose>

            </c:forEach>
        </table>


    </c:if>
</c:when>
</c:choose>


</body>
</html>