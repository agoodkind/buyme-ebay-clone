<%--
  Created by IntelliJ IDEA.
  User: Alexander Goodkind amg540
  Date: 2019-04-19
  Time: 00:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<html>
<head>
    <title>Delete Auction</title>
</head>
<body>


<t:logged_in_header/>

<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>


<sql:query var="check_auction_matches" dataSource="${dataSource}">
    select account_id from Account_Sells_In_Auction where auction_id = ${param.delete_auction_id};
</sql:query>

<c:choose>
    <c:when test="${check_auction_matches.rows[0].account_id == sessionScope.account_id or sessionScope.account_type == 'Administrator'}">
        <sql:update var="delete_auction" dataSource="${dataSource}">
            delete from Auction where auction_id = ${param.delete_auction_id};
        </sql:update>
        <c:choose>
            <c:when test="${delete_auction > 0}">
                auction deleted successfully
            </c:when>
            <c:otherwise>
                error
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        unauthorized
    </c:otherwise>
</c:choose>


</body>
</html>
