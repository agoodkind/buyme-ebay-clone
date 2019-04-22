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
<link rel="stylesheet" type="text/css" href="style.css">
   
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
    select account_id from Account_Sells_In_Auction where auction_id = ${param.end_auction_id};
</sql:query>


        <sql:update var="end_auction" dataSource="${dataSource}">
            Update Auction
            set closing_datetime = NOW()
            where auction_id = ${param.end_auction_id};
        </sql:update>
        <c:choose>
            <c:when test="${end_auction > 0}">
                auction ended successfully
            </c:when>
            <c:otherwise>
                error
            </c:otherwise>
        </c:choose>

</body>
</html>
