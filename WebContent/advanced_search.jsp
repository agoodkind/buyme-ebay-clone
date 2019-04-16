<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

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
    <input type="text" minlength="3" name="s_query" value="${param.s_query}"/>
    <input type="checkbox" name="advanced" value="true">Advanced Search<br/>
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
    <button formmethod="post" formaction="continue_advanced_search.jsp">Continue</button>
</form>


</body>
</html>