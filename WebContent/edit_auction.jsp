<%--
  Created by IntelliJ IDEA.
  User: Alexander Goodkind amg540
  Date: 2019-04-18
  Time: 22:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <title>Edit Auction</title>
</head>
<body>


<t:logged_in_header/>

<c:choose>
    <c:when test="${sessionScope.account_type == 'Administrator' or sessionScope.account_type == 'Customer Service Representative'}">
        <sql:setDataSource var="dataSource"
                           driver="${initParam['driverClass']}"
                           url="${initParam['connectionURL']}"
                           user="${initParam['username']}"
                           password="${initParam['password']}"/>
        <c:choose>
            <c:when test="${not empty param.update_auction_id}">
                <sql:query var="edit_account" dataSource="${dataSource}">
                    select * from Auction where auction_id = ${param.update_auction_id};
                </sql:query>
                <form>

                    <h3>editing auction with ID: <c:out value="${edit_account.rows[0].auction_id}"/></h3>
                    Current Bid: <input type="number" name="current_bid"
                                        value="${edit_account.rows[0].current_bid}"><br>
                    Days to end from now (closing date): <input value="${edit_account.rows[0].closing_datetime}"
                                                                type="number" name="days_to_end"><br>
                    Min Price: <input type="number" value="${edit_account.rows[0].min_price}" name="min_price"><br>
                    Item ID: <input type="number" value="${edit_account.rows[0].item_id}" name="item_id"><br>
                    <input type="hidden" name="update_auction_id_with_new_values" value="${param.update_auction_id}">
                    <input type="submit" value="Submit">
                </form>
            </c:when>
            <c:when test="${not empty param.update_auction_id_with_new_values}">
                <sql:update var="updated_auction_id" dataSource="${dataSource}">
                    update Auction
                    <%
                        String queryBuilder = "SET ";

                        HashMap<String, String> params = new HashMap<String, String>();

                        if (request.getParameter("current_bid") != null && !request.getParameter("current_bid").isEmpty()) {
                            params.put("current_bid", request.getParameter("current_bid"));
                        }

                        if (request.getParameter("days_to_end") != null && !request.getParameter("days_to_end").isEmpty()) {
                            params.put("closing_datetime", "DATE_ADD(NOW(), INTERVAL " + request.getParameter("days_to_end") + " DAY)");
                        }

                        if (request.getParameter("min_price") != null && !request.getParameter("min_price").isEmpty()) {
                            params.put("min_price", request.getParameter("min_price"));
                        }

                        if (request.getParameter("item_id") != null && !request.getParameter("item_id").isEmpty()) {
                            params.put("item_id", request.getParameter("item_id"));
                        }

                        int index = 0;

                        for (Map.Entry<String, String> entry : params.entrySet()) {
                            if (index > 0) {
                                queryBuilder += ",";
                            }
                            index++;
                            String key = entry.getKey();
                            String value = entry.getValue();
                            queryBuilder += " `" + key + "` = " + value + " ";
                        }

                        pageContext.setAttribute("edit_query", queryBuilder);
                    %>
                    ${edit_query}  WHERE auction_id = ${param.update_auction_id_with_new_values};
                </sql:update>

                <c:choose>
                    <c:when test="${updated_auction_id > 0}">
                        Auction with ID ${param.update_auction_id_with_new_values} updated successfully
                    </c:when>
                </c:choose>
            </c:when>
        </c:choose>
    </c:when>
    <c:otherwise>
        You are not authorized to view this page, redirecting in 5 seconds..
        <meta http-equiv="refresh" content="5;url=index.jsp"/>
    </c:otherwise>
</c:choose>

<%--edit account info--%>

</body>
</html>
