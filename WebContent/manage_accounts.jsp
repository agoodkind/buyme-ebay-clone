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
    <title>Manage Accounts</title>
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
            <c:when test="${not empty param.update_account_id}">
                <sql:query var="edit_account" dataSource="${dataSource}">
                    select * from Account where id = ${param.update_account_id};
                </sql:query>
                <form>

                    <h3>editing account with ID: <c:out value="${edit_account.rows[0].id}"/></h3>
                    <c:if test="${sessionScope.account_type != 'Administrator'}">only Administrators can edit first_name, last_name, and account_type<br/></c:if>
                    First Name: <input
                        <c:if test="${sessionScope.account_type != 'Administrator'}">disabled</c:if> type="text"
                        value="${edit_account.rows[0].first_name}" name="first_name"><br>
                    Last Name: <input
                        <c:if test="${sessionScope.account_type != 'Administrator'}">disabled</c:if>
                        value="${edit_account.rows[0].last_name}" type="text" name="last_name"><br>
                    Email Address: <input type="email"
                                          name="email_address" value="${edit_account.rows[0].email_address}"><br>
                    Password: <input type="password"
                                     name="password"><br>
                    <div style="background-color: red">Account Type: <select
                            <c:if test="${sessionScope.account_type != 'Administrator'}">disabled</c:if>
                            value="${edit_account.rows[0].account_type}" name="account_type">
                        <option value="End User">End User</option>
                        <option value="Customer Service Representative">Customer Service Representative</option>
                        <option value="Administrator">Administrator</option>
                    </select></div>
                    <br/>
                    <input type="hidden" name="update_account_id_with_new_values" value="${edit_account.rows[0].id}">
                    <input type="submit" value="Submit">
                </form>
            </c:when>
            <c:when test="${not empty param.update_account_id_with_new_values}">
                <sql:update var="updated_account_id" dataSource="${dataSource}">
                    update Account
                    <%
                        String queryBuilder = "SET ";

                        HashMap<String, String> params = new HashMap<String, String>();

                        if (request.getParameter("first_name") != null && !request.getParameter("first_name").isEmpty()) {
                            params.put("first_name", request.getParameter("first_name"));
                        }

                        if (request.getParameter("last_name") != null && !request.getParameter("last_name").isEmpty()) {
                            params.put("last_name", request.getParameter("last_name"));
                        }

                        if (request.getParameter("email_address") != null && !request.getParameter("email_address").isEmpty()) {
                            params.put("email_address", request.getParameter("email_address"));
                        }

                        if (request.getParameter("account_type") != null && !request.getParameter("account_type").isEmpty()) {
                            params.put("account_type", request.getParameter("account_type"));
                        }

                        if (request.getParameter("password") != null && !request.getParameter("password").isEmpty()) {
                            params.put("password", request.getParameter("password"));
                        }

                        int index = 0;

                        for (Map.Entry<String, String> entry : params.entrySet()) {
                            if (index > 0) {
                                queryBuilder += ",";
                            }
                            index++;
                            String key = entry.getKey();
                            String value = entry.getValue();
                            queryBuilder += " `" + key + "` = '" + value + "' ";
                        }

                        pageContext.setAttribute("edit_query", queryBuilder);
                    %>
                    ${edit_query}  WHERE id = ${param.update_account_id_with_new_values};
                </sql:update>

                <c:choose>
                    <c:when test="${updated_account_id > 0}">
                        Account with ID ${param.update_account_id_with_new_values} updated successfully
                    </c:when>
                </c:choose>
            </c:when>
            <c:when test="${not empty param.create_account}">

                <form method="post">
                    <table>
                        <tr>
                            <td>First Name</td>
                            <td><input type="text" required="required" name="first_name"></td>
                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td><input type="text" required="required" name="last_name"></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input type="email" required="required" minlength="5" name="email"></td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td><input type="password" required="required" minlength="8" name="password"></td>
                        </tr>
                        <tr>
                            <td>
                                <select
                                        value="${edit_account.rows[0].account_type}" name="account_type">
                                    <option value="End User">End User</option>
                                    <option value="Customer Service Representative">Customer Service Representative
                                    </option>
                                    <c:if test="${sessionScope.account_type == 'Administrator'}">
                                        <option value="Administrator">Administrator</option>
                                    </c:if>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <button formaction="manage_accounts.jsp" value="submit_create_account" type="submit">Submit</button>
                </form>
            </c:when>
            <c:when test="${not empty param.delete_account_id}">
                <sql:update dataSource="${dataSource}" var="delete_account">
                    delete from Account where id = ${param.delete_account_id};
                </sql:update>
                <c:choose>
                    <c:when test="${delete_account > 0}">
                        ${param.delete_account_id} successfully deleted
                    </c:when>
                    <c:otherwise>
                        error deleting
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <button formaction="manage_accounts.jsp" value="true" name="create_account" type="submit">Create Account</button><br/>
                <sql:query var="all_accounts" dataSource="${dataSource}">
                    select * from Account;
                </sql:query>
                <c:if test="${sessionScope.account_type != 'Administrator'}">
                    Only administrators can delete accounts
                </c:if>

                <table border="1" cellpadding="5">
                    <tr>
                        <th>Account ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email Address</th>
                        <th>Account Type</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>

                    <c:forEach var="row" items="${all_accounts.rows}">
                        <tr>
                            <td><c:out value="${row.id}"></c:out></td>
                            <td><c:out value="${row.first_name}"/></td>
                            <td><c:out value="${row.last_name}"/></td>
                            <td><c:out value="${row.email_address}"/></td>
                            <td><c:out value="${row.account_type}"/></td>
                            <td>
                                <form>
                                    <button value="${row.id}" name="update_account_id" formaction="manage_accounts.jsp">
                                        edit account
                                    </button>
                                </form>
                            </td>

                            <td style="background-color: red">
                                <form style="background-color: red">
                                    <button
                                            <c:if test="${sessionScope.account_type != 'Administrator'}">disabled</c:if>
                                            value="${row.id}" name="delete_account_id"
                                            formaction="manage_accounts.jsp">delete
                                        account
                                    </button>
                                </form>
                            </td>
                            <td>
                                <form>
                                    <button value="${row.id}" name="view_account_id" formaction="view_user.jsp">view user
                                    </button>
                                </form>
                            </td>

                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
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
