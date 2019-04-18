<%@tag description="header for logged in users" pageEncoding="UTF-8"%>
<%@taglib prefix="logged_in_header" tagdir="/WEB-INF/tags" %>


<header>
    <h1>buyMe.com</h1>
    <form>
        <button formmethod="post" type="submit" formaction="index.jsp">Home</button>

        <button formmethod="post" type="submit" formaction="add_alert_to_wishlist_form.jsp">Add an Alert to my Wishlist</button>

        <button formmethod="post" type="submit" formaction="all_active_auctions.jsp">All Auctions</button>

        <button formmethod="post" type="submit" formaction="item_search.jsp">Search</button>

        <button formmethod="post" type="submit" formaction="create_auction_form.jsp">Sell an Item in an Auction</button>

        <button formmethod="post" type="submit" formaction="wishlist_page.jsp">My Wishlist</button>



        <button formmethod="post" type="submit" formaction="#">My Auctions</button>

        <button formmethod="post" type="submit" formaction="list_all_alerts.jsp">My Alerts</button>

        <button formmethod="post" type="submit" formaction="email_inbox.jsp">Email Inbox</button>

        <button formmethod="post" type="submit" formaction="#">Customer Service and Support</button>

        <button formmethod="post" type="submit" formaction="signout.jsp">Sign Out</button>
    </form>
</header>