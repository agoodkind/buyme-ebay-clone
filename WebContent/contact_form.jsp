<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--Contributers:
Amulya Mummaneni asm229,
Madhumitha Sivaraj ms2407,
--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Email Form - buyMe</title>
</head>
<body>

<t:logged_in_header/>
<form method="post">
    <table>
        <tr>
            <td>Message Recipient</td>
            <td><input type="email" maxlength="40" required="required" value="${param.email_address}"
                       name="message_recipient"></td>
        </tr>
        <tr>
            <td>Message Subject</td>
            <td><input type="text" maxlength="50" required="required" name="message_subject"></td>
        </tr>
        <tr>
            <td>Content</td>
            <td><textarea name="content" style="width: 500px; height:400px;"></textarea></td>
        </tr>


    </table>
    <button formaction="send_email.jsp" type="submit">Send Email</button>
</form>
</body>
</html>

<!-- INSERT INTO auction (Auction_id, initial_price, min_price, start_datetime, closing_datetime) VALUES (@auction_id, @user_id, @start_datetime, @closing_datetime);
-->