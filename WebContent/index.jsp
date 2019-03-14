<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<br>
	<form method="post">
	<table>
	<tr>
	<td>Email</td><td><input type="email" name="email"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input id="loginButton" formaction="login_account.jsp" type="submit" value="login">
	<input id="createAccountButton" formaction="create_account.jsp" type="submit" value="create account">
	</form>
<br>


</body>
</html>