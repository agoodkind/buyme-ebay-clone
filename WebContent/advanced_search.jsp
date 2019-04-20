<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


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



    Size: <input type="text" maxlength="10" required name="size"><br/>
    Gender:
    <select name="gender" value="Male">
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Unisex">Unisex</option>
    </select><br/>
    Item Type:
    <select name="item_type">
        <option value="Accessories">Accessories</option>
        <option value="Pants">Pants</option>
        <option value="Shirts">Shirts</option>
        <option value="Undergarments">Undergarments</option>
    </select><br/>
    <%
        Cookie forward_to = new Cookie("forward_to", "advanced_search_results.jsp");
        response.addCookie(forward_to);
    %>
    <c:if test="${param.advanced == 'true'}">
        <c:set var="s_query" value="${param.s_query}" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${empty param.auction_search_continue}">
            Max price of current bid: <input type="number" required="required" name="auction_current_bid_below"><br/>
            Minimum number of days until auction ends: <input type="number" required="required"
                                                              name="auction_ends_num_days_from_now"><br/>
            <c:set var="auction_search" value="true" scope="session"/>
            <%
                session.setAttribute("size", request.getParameter("size"));
                session.setAttribute("gender", request.getParameter("gender"));
                session.setAttribute("item_name", request.getParameter("item_name"));
                String item_type = request.getParameter("item_type");

                if (request.getParameterMap().containsKey("order_by")) {
                    session.setAttribute("order_by", request.getParameter("order_by"));
                }
                if (request.getParameterMap().containsKey("column_name")) {
                    item_type = (String) session.getAttribute("column_name");
                }

            %>
            <button formmethod="get" value="true" name="auction_search_continue" formaction="advanced_search.jsp">
                Continue
            </button>
        </c:when>
        <c:when test="${param.auction_search_continue == 'true'}">
            <c:set var="auction_current_bid_below" value="${param.auction_current_bid_below}" scope="session"/>
            <c:set var="auction_ends_num_days_from_now" value="${param.auction_ends_num_days_from_now}"
                   scope="session"/>
            <%--  set session stuff for auction deets and forward to select_item_details --%>

            <jsp:forward page="select_item_details.jsp"/>
        </c:when>
    </c:choose>

</form>


</body>
</html>