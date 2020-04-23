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
    <title><fmt:message key="admin.user_accounts.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowUserAccounts.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert unableGetUserId -->
    <c:if test="${response eq 'unableGetUserId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetUserIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert showUserAccountsError -->
    <c:if test="${response eq 'showUserAccountsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowUserAccountsError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <fmt:message key="admin.user_accounts.formHeader" var="formHeader"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="user.account.balance" var="balance"/>
                <fmt:message key="admin.attachAccount.returnToUserProfile" var="returnToUserProfile"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <div class="row justify-content-center">
                                            <div class="col-xl-12">

                                                <h4>
                                                    ${formHeader}
                                                </h4>

                                                <c:choose>
                                                    <c:when test="${response ne 'unableGetUserId' && response ne 'showUserAccountsError'}">
                                                        <div class="row">
                                                            <div class="col-lg-3 col-xl-3">
                                                                <div>
                                                                    <form action="/" method="GET" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="showUser">
                                                                        <input type="hidden" name="userId"
                                                                               value="${userId}">
                                                                        <div class="action" style="text-align: unset;">
                                                                            <button id="submit" type="submit"
                                                                                    class="btn btn-primary signup btn-default"
                                                                                    style="width: 100%;">
                                                                                    ${returnToUserProfile}
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </div>

                                                                <div style="text-align: center; margin: 20px 0 30px 0;">
                                                                    <label style="margin-bottom: 30px; font-size: 16px; text-transform: uppercase;">
                                                                            ${searchCriteria}:
                                                                    </label>
                                                                    <form action="/" method="GET" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="searchAccounts">
                                                                        <div class="action" style="text-align: unset;">
                                                                            <button id="search" type="submit"
                                                                                    class="btn btn-primary signup">
                                                                                    ${searchButton}
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-9 col-xl-9">
                                                                <div class="col-xl-12">
                                                                    <c:choose>
                                                                        <c:when test="${!accountsEmpty}">
                                                                            <div class="form-row">
                                                                                <div class="card-container"
                                                                                     style="width: 100%;">
                                                                                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-2 row-cols-xl-2">
                                                                                        <c:forEach items="${accounts}"
                                                                                                   var="account">
                                                                                            <div class="col mb-4">
                                                                                                <div class="card bg-light">
                                                                                                    <div class="card-header">
                                                                                                        <c:choose>
                                                                                                            <c:when test="${account.isBlocked}">
                                                                                                                <small class="text-danger float-right">
                                                                                                                        ${statusBlocked}
                                                                                                                </small>
                                                                                                            </c:when>
                                                                                                            <c:otherwise>
                                                                                                                <small class="text-success float-right">
                                                                                                                        ${statusActive}
                                                                                                                </small>
                                                                                                            </c:otherwise>
                                                                                                        </c:choose>
                                                                                                    </div>
                                                                                                    <div class="card-body"
                                                                                                         style="padding: 0.75rem 1.25rem;">
                                                                                                        <p class="card-title text-muted">
                                                                                                                ${account.number}<br/>
                                                                                                                ${balance}: ${account.balance} ${account.currency}
                                                                                                            <a href="?command=showAccountInfo&accountId=${account.accountId}"
                                                                                                               class="float-right">
                                                                                                                <img src="resources/images/info.png"
                                                                                                                     alt="">
                                                                                                            </a>
                                                                                                        </p>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="title-label">
                                                                                <label style="font-size: 22px;">
                                                                                    <fmt:message
                                                                                            key="admin.user.accountsEmpty"/>
                                                                                </label>
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>

                                                        <!-- Return to Users -->
                                                        <div class="message-block">
                                                            <label class="title-label">
                                                                <a href="/" class="float-left">
                                                                    <span class="forward-left-link-img">←</span>
                                                                        ${returnToUsers}
                                                                </a>
                                                            </label>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
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
</html>