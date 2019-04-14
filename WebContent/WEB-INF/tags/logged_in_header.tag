<%@tag description="header for logged in users" pageEncoding="UTF-8"%>
<%@taglib prefix="logged_in_header" tagdir="/WEB-INF/tags" %>


<header>

<form>
    <button formmethod="post" type="submit" formaction="/">Home</button>

    <button formmethod="post" type="submit" formaction="#">Search for Something</button>

    <button formmethod="post" type="submit" formaction="#">View Alerts</button>

    <button formmethod="post"  type="submit" formaction="#">Emails</button>

    <button formmethod="post" type="submit" formaction="signout.jsp">Sign Out</button>
</form>
</header>