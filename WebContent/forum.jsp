<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.group37db336.pkg.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%--
Contributers:
Alexander Goodkind amg540
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A for Auction #${param.auction_id} - buyMe</title>
</head>
<body>
<t:logged_in_header/>

<%--input param.auction_id--%>


<sql:setDataSource var="dataSource"
                   driver="${initParam['driverClass']}"
                   url="${initParam['connectionURL']}"
                   user="${initParam['username']}"
                   password="${initParam['password']}"/>




<sql:query var="all_q_and_a" dataSource="${dataSource}">
    select f.auction_id,
    f.question,
    f.answer,
    f.asked_by_account_id,
    f.answered_by_account_id,
    a.first_name as asker_first_name,
    a.last_name as asker_last_name,
    a2.first_name as answerer_first_name,
    a2.last_name as answerer_last_name
    from Forum f
    left join Account a on f.asked_by_account_id = a.id
    left join Account a2 on f.answered_by_account_id = a2.id
    where auction_id = ${param.auction_id};
</sql:query>

<c:choose>
    <c:when test="${all_q_and_a.rowCount > 0}">
        <table border="1" cellpadding="5">
            <tr>
                <th>Asked By</th>
                <th>Question</th>
                <th>Answered By</th>
                <th>Answer</th>
            </tr>
            <c:forEach var="row" items="${all_q_and_a.rows}">
                <tr>
                    <td><c:out value="${row.asker_first_name}"/> <c:out value="${row.asker_last_name}"/></td>
                    <td style="word-wrap: break-word;"><c:out value="${row.question}"/></td>
                    <c:choose>
                        <c:when test="${not empty row.answer}">
                            <td>CSR: <c:out value="${row.answerer_first_name}"/> <c:out value="${row.answerer_last_name}"/></td>
                            <td style="word-wrap: break-word;"><c:out value="${row.answer}"/></td>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${sessionScope.account_type == 'Customer Service Representative' or sessionScope.account_type == 'Administrator'}">
                                    <td>No Answer yet</td>
                                    <td style="background-color: blue">
                                        <form>
                                            <input type="text" name="csr_answer"/>
                                            <input type="hidden" value="${param.auction_id}" name="auction_id"/>
                                            <button formmethod="post" name="csr_reply_to_question_id" value="${sessionScope.account_id}" type="submit" formaction="forum.jsp">Reply to this question</button>
                                        </form>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td>No answer yet</td>
                                    <td>
                                        <button disabled>Only CSR's can reply to questions</button>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </c:when>

    <c:when test="${not empty param.user_asked_question_id}">
        <sql:update dataSource="${dataSource}" var="user_asked_question_query">
            update Forum
            set question            = '<c:out value="${param.user_question}" escapeXml="true"/>',
            asked_by_account_id = ${param.user_asked_question_id}
            where auction_id =  ${param.auction_id};
        </sql:update>
        <c:choose>
            <c:when test="${user_asked_question_query > 0}">
                Question asked successfully.
            </c:when>
            <c:otherwise>
                Error asking question.
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${not empty param.csr_reply_to_question_id}">
        <sql:update dataSource="${dataSource}" var="csr_answered_question_query">
            update Forum
            set answer ='<c:out value="${param.csr_answer}" escapeXml="true"/>',
            answered_by_account_id= ${param.csr_reply_to_question_id}
            where auction_id = ${param.auction_id};
        </sql:update>
        <c:choose>
            <c:when test="${csr_answered_question_query > 0}">
                Question asked successfully.
            </c:when>
            <c:otherwise>
                Error asking question.
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <%--post question--%>
        No questions have been asked yet.<br/>
        Be the first!:<br/>
    </c:otherwise>
</c:choose>
<c:if test="${empty param.user_asked_question_id and empty param.csr_reply_to_question_id}">
    Ask a question:<br/>
    <form>
        <input type="text" name="user_question" placeholder="Ask question here"/><br/>
        <input type="hidden" value="${param.auction_id}" name="auction_id"/>
        <button formmethod="post" name="user_asked_question_id" value="${sessionScope.account_id}" type="submit" formaction="forum.jsp">Ask</button>
    </form>
</c:if>
<%--view a list of all questions--%>
<%--answer question if CSR or Admin--%>


</body>
</html>