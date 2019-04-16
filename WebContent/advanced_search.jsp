<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

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
    <h1>Advanced Search with query '${param.s_query}'</h1>



    Size: <input type="number" required="required" name="size">
    Gender:
    <select name="gender" value="Male">
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Unisex">Unisex</option>
    </select>
    Item Type:
    <select name="item_type">
        <option value="Accessories">Accessories</option>
        <option value="Pants">Pants</option>
        <option value="Shirts">Shirts</option>
        <option value="Undergarments">Undergarments</option>
    </select>
    <%
        Cookie forward_to = new Cookie("forward_to", "advanced_search_results.jsp");
        response.addCookie(forward_to);
    %>
    <c:if test="${empty param.auction_search_continue}">
        <c:set var="s_query" value="${param.s_query}" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${not empty param.auction_search and empty param.auction_search_continue }">

            doing auction search
            Max price of current bid: <input type="number" required="required" name="auction_current_bid_below">
            Minimum number of days until auction ends: <input type="number" required="required"
                                                              name="auction_ends_num_days_from_now">
            <c:set var="auction_search" value="true" scope="session"/>
            <%
                session.setAttribute("size", request.getParameter("size"));
                session.setAttribute("gender", request.getParameter("gender"));
                session.setAttribute("item_name", request.getParameter("item_name"));
                String item_type = request.getParameter("item_type");
                session.setAttribute("item_type", item_type);
            %>
            <button formmethod="post" value="true" name="auction_search_continue" formaction="advanced_search.jsp">
                Continue
            </button>
        </c:when>
        <c:when test="${param.auction_search_continue == 'true'}">
            <c:set var="auction_current_bid_below" value="${param.auction_current_bid_below}" scope="session"/>
            <c:set var="auction_ends_num_days_from_now" value="${param.auction_ends_num_days_from_now}"
                   scope="session"/>
            <%--  set session stuff for auction deets and forward to get_item_details --%>

            <jsp:forward page="get_item_details.jsp"/>
        </c:when>
        <c:when test="${empty cookie.auction_search and empty param.auction_search_continue}">
            not doing auction search
            <button formmethod="post" formaction="get_item_details.jsp">Continue</button>
        </c:when>
    </c:choose>

</form>


</body>
</html>