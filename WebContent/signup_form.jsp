<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.group37db336.pkg.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Create Account - buyMe</title>
	</head>
	<body>
		<form method="post">
			<table>
				<tr>
					<td>First Name</td>
					<td><input type="email" required="required" name="first_name"></td>
				</tr>
				<tr>
					<td>Last Name</td>
					<td><input type="email" required="required" name="last_name"></td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type="email" required="required" minlength="5" name="email"></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" required="required" minlength="8" name="password"></td>
				</tr>
			</table>
			<button formaction="create_account.jsp" type="submit">Sign Up</button>
		</form>
	</body>
</html>