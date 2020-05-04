<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="user.page.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>

<!-- Modal window -->
<div id="smallModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    <fmt:message key="user.card.modalHeader"/>
                </h4>
            </div>
            <div class="modal-body">
                <fmt:message key="user.card.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="cardNumberText" class="modal-label">
                        <fmt:message key="user.card.modalCardLabel"/>
                    </label>
                    <input id="cardNumberText" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" data-dismiss="modal">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="detachCard"/>
                        <input type="hidden" name="cardId" id="cardId"/>
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur();">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert blockCardError -->
    <c:if test="${blockCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertCardBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unblockCardAlert -->
    <c:if test="${unblockCardAlert == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><fmt:message key="user.page.alertCardUnblockedError"/>
                <a href="?command=support" class="alert-link"><fmt:message key="user.page.technicalSupport"/></a>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert detachCardError -->
    <c:if test="${detachCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertDetachCardError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <fmt:message key="user.card.allcards" var="allcards"/>
    <fmt:message key="user.card.number" var="cardNumber"/>
    <fmt:message key="user.card.cvv" var="cvv"/>
    <fmt:message key="user.card.date" var="date"/>
    <fmt:message key="user.card.detachCard" var="detachCard"/>
    <fmt:message key="user.card.detach" var="detach"/>
    <fmt:message key="user.account.allAccounts" var="allAccounts"/>
    <fmt:message key="user.account.number" var="number"/>
    <fmt:message key="user.page.showInfo" var="showInfo"/>
    <fmt:message key="user.account.status" var="loop"/>
    <fmt:message key="user.account.status.active" var="statusActive"/>
    <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
    <fmt:message key="user.account.action" var="action"/>
    <fmt:message key="user.account.block" var="block"/>
    <fmt:message key="user.account.unblock" var="unblock"/>

    <c:forEach items="${accounts}" var="account">

        <a href="?command=unblockAccount&accountId=${account.accountId}">
                ${unblock}
            <img src="resources/images/unlocked-link.png"
                 alt="" class="icon">
        </a>
        <c:choose>
            <c:when test="${account.isBlocked}">

            </c:when>
            <c:otherwise>
                <a href="?command=blockAccount&accountId=${account.accountId}">
                        ${block}
                    <img src="resources/images/locked-link.png"
                         alt="" class="icon">
                </a>
            </c:otherwise>
        </c:choose>
        <a href="?command=showAccountInfo&accountId=${account.accountId}">
                ${showInfo}
        </a>
    </c:forEach>

    ${allcards}

    ${cardNumber}
    ${date}
    ${loop}
    ${action}
    ${detachCard}

    <c:forEach items="${cards}" var="card">
        ${card.number}
        ${card.validity}
        <c:choose>
            <c:when test="${card.isActive}">
                ${statusActive}
            </c:when>
            <c:otherwise>
                ${statusBlocked}
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${card.isActive}">
                <a href="?command=blockCard&cardNumber=${card.number}">
                        ${block}
                    <img src="resources/images/locked-link.png"
                         class="icon" alt=""/>
                </a>
            </c:when>
            <c:otherwise>
                <a href="?command=unblockCard&cardNumber=${card.number}">
                        ${unblock}
                    <img src="resources/images/unlocked-link.png"
                         class="icon" alt=""/>
                </a>
            </c:otherwise>
        </c:choose>
        <a href="#smallModal?cardNumber=${card.number}"
           onclick="showModal();">
                ${detach}
        </a>
    </c:forEach>
</div>
</div>
</div>

</div>
</div>
</div>
</div>
</div>
<jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/modalWindow_userShowAccounts.js"></script>
</html>