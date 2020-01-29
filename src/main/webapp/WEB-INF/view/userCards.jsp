<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<html>
<head>
    <title><fmt:message key="admin.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.css" rel="stylesheet">
</head>

<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content">
    <div class="row">
        <div class="col-md-2">
            <jsp:include page="template/sidebar.jsp"/>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">

                            <fmt:message key="home.account.number" var="number"/>
                            <fmt:message key="home.account.status" var="status"/>
                            <fmt:message key="home.account.status.active" var="statusActive"/>
                            <fmt:message key="home.account.button.addFunds" var="addFunds"/>
                            <fmt:message key="home.account.status.blocked" var="statusBlocked"/>

                            <div class="content-box-header">
                                <div class="panel-title">
                                    <fmt:message key="admin.accounts"/>
                                </div>
                            </div>

                            <div class="content-box-large box-with-header">
                                <table border="1" width="100%" cellpadding="4" cellpacing="3">
                                    <th>
                                        ${number}
                                    </th>
                                    <th>
                                        <fmt:message key="admin.balance"/>
                                    </th>
                                    <th>
                                        ${status}
                                    </th>
                                    <th>
                                        <fmt:message key="userCards.action"/>
                                    </th>
                                    <th></th>
                                    <th></th>
                                    <th></th>

                                    <c:forEach items="${accounts}" var="account">
                                        <tr align="center">
                                            <td>${account.number}</td>
                                            <td>${account.balance}</td>
                                            <td>
                                                <c:if test="${!account.isBlocked}">
                                                    ${statusActive}
                                                </c:if>
                                                <c:if test="${account.isBlocked}">
                                                    ${statusBlocked}
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${account.isBlocked}">
                                                    <form action="accounts" method="POST">
                                                        <input type="hidden" name="command" value="unblock">
                                                        <fmt:message key="admin.unblock" var="unblockAccount"/>
                                                        <input type="hidden" name="accountId"
                                                               value="${account.accountId}">
                                                        <input type="submit" value="${unblockAccount}">
                                                    </form>
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="?command=showcards&accountId=${account.accountId}">
                                                    <fmt:message key="admin.showCards"/>
                                                </a>
                                            </td>
                                            <td>
                                                <a href="#my_modal" data-toggle="modal"
                                                   data-account-id="${account.accountId}">
                                                        ${addFunds}
                                                </a>
                                            </td>
                                            <td>
                                                <form method="GET">
                                                    <input type="hidden" name="command" value="addCard">
                                                    <fmt:message key="userCards.addCard" var="addNewCard"/>
                                                    <input type="hidden" name="accountId" value="${account.accountId}"/>
                                                    <input type="submit" value="${addNewCard}"/>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="content-box-header">
                                <div class="panel-title">
                                    <fmt:message key="home.allcards"/>
                                </div>
                            </div>
                            <div class="content-box-large box-with-header">
                                <fmt:message key="home.account.number" var="number"/>
                                <table border="1" width="100%" cellpadding="4" cellpacing="3">
                                    <th>${number}</th>
                                    <th><fmt:message key="home.card.cvv"/></th>
                                    <th><fmt:message key="home.card.date"/></th>
                                    <th>${status}</th>
                                    <th><fmt:message key="userCards.action"/></th>
                                    <th></th>

                                    <c:forEach items="${cards}" var="card">
                                        <tr align="center">
                                            <td>${card.number}</td>
                                            <td>${card.cvv}</td>
                                            <td>${card.validity}</td>
                                            <td>
                                                <c:if test="${card.isActive}">${statusActive}</c:if>
                                                <c:if test="${!card.isActive}">${statusBlocked}</c:if>
                                            </td>
                                            <td>
                                                <c:if test="${!card.isActive}">
                                                    <a href="?command=unblockCard&cardNumber=${card.number}">
                                                        <fmt:message key="admin.unblock"/>
                                                    </a>
                                                </c:if>
                                            </td>
                                            <td>
                                                <form action="accounts" method="POST">
                                                    <fmt:message key="userCards.delete" var="deleteCard"/>
                                                    <input type="hidden" name="command" value="deleteCard">
                                                    <input type="hidden" name="cardId" value="${card.cardId}">
                                                    <input type="submit" value="${deleteCard}">
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>

<div class="modal" id="my_modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="accounts" method="POST">
                <div class="modal-header">
                    <input type="hidden" name="command" value="add-funds">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">
                        <fmt:message key="home.modal.close"/></span>
                    </button>
                    <h4 class="modal-title">
                        <fmt:message key="home.modal.addfunds"/>
                    </h4>
                </div>

                <div class="modal-body">
                    <p>
                        <fmt:message key="home.modal.enterSum"/>
                    </p>
                    <input type="hidden" name="accountId" value=""/>
                    <input type="text" name="summa">
                </div>

                <div class="modal-footer">
                    <button type="submit" id="send" class="btn btn-primary">
                        <fmt:message key="home.modal.send"/>
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <fmt:message key="home.modal.close"/>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>

<script type="text/javascript">
    $('#my_modal').on('show.bs.modal', function (e) {
        let accountId = $(e.relatedTarget).data('account-id');
        $(e.currentTarget).find('input[name="accountId"]').val(accountId);
    });
</script>
</body>
</html>