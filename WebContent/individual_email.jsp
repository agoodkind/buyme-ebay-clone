<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--Contributers:
Amulya Mummaneni asm229,
Madhumitha Sivaraj ms2407,
--%>
<t:logged_in_header/>
<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>

<sql:query dataSource="${dataSource}" var="result">
    select e.from_account_id,
    e.timesent,
    e.message_subject,
    e.message_id,
    e.content,
    a.first_name,
    a.last_name,
    a.email_address
    from Email e, Account a
    where e.from_account_id = a.id and message_id = ${param.message_id} and e.to_account_id = ${cookie.account_id.value};
</sql:query>


<h2></h2>
<b>From:</b> <c:out value="${result.rows[0].first_name} ${result.rows[0].last_name}"/>&comma;&nbsp;<i>&lt;<c:out
        value="${result.rows[0].email_address}"/>&gt;</i><br/>
<b>Subject:</b> <c:out value="${result.rows[0].message_subject}"/><br/>
<b>Time received:</b> <fmt:formatDate value="${result.rows[0].timesent}" pattern="h:mm a 'on' MM/dd/yyyy"/><br/>
<p style="padding: 20px; border-color: black; border-width: 2px;border-style: solid;"><c:out
        value="${result.rows[0].content}"/></p>
<button value="${result.rows[0].email_address}" name="email_address" formaction="contact_form.jsp">Reply</button>
<%--                    TODO: add delete button --%>