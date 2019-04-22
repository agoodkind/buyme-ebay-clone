<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%--
Contributers:
Alexander Goodkind amg540,
Michael Wang mtw95
--%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
   
    <meta charset="UTF-8">
    <title>Wishlist - buyMe</title>
</head>
<body>

<t:logged_in_header/>


<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<h2>My Wishlist</h2>

<c:if test="${not empty param.item_id}">
    <sql:transaction dataSource="${dataSource}">
        <sql:query var="delete_result">
            select item_name from Clothing_Item where item_id = ${param.item_id};
        </sql:query>
        <sql:update var="delete_query">
            delete from Wishlist
            where account_id = ${cookie.account_id.value}
            and
            item_id = ${param.item_id};
        </sql:update>
        <h5>Deleted &quot;<c:out value="${delete_result.rows[0].item_name}"/>&quot; from your wishlist
            successfully.</h5>
    </sql:transaction>
</c:if>

<sql:query dataSource="${dataSource}" var="result">
    <%--select from wishlist items in lists owned by currently-logged-in user --%>
    select ci.item_name, w.item_id
    from Clothing_Item ci,
    Wishlist w
    where ci.item_id = w.item_id
    and w.account_id = ${cookie.account_id.value};
</sql:query>

<div>
    <table border="1" cellpadding="5">
        <tr>
            <th>Item Name</th>
            <th></th>
            <th></th>
        </tr>
        <c:forEach var="result" items="${result.rows}">
            <tr>
                <td><c:out value="${result.item_name}"/></td>
                <td>
                    <form>
                        <button formmethod="post" value="${result.item_id}" name="item_id"
                                formaction="individual_item.jsp">
                            View Item
                        </button>
                    </form>
                </td>
                <td>
                    <form>
                        <button formmethod="post" value="${result.item_id}" name="item_id"
                                formaction="wishlist_page.jsp">
                            Delete from my wishlist
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>


</body>
</html>