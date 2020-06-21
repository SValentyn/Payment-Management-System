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
    <title><fmt:message key="admin.page.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_admin.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert noUsersError -->
    <c:if test="${totalUsers == null || totalUsers == 0}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertNoUsersError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert userDeletedSuccess -->
    <c:if test="${response eq 'userDeletedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertUserDeletedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchUsersSuccess -->
    <c:if test="${response eq 'searchUsersSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchUsersSuccess"/>
                    ${numberOfUsers}
                <fmt:message key="admin.users.users"/>.
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchUsersSuccess -->
    <c:if test="${response eq 'searchUsersWarning'}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchUsersWarning"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchUsersError -->
    <c:if test="${response eq 'searchUsersError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertSearchUsersError"/>
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
                <fmt:message key="admin.page.allUsers" var="allUsers"/>
                <fmt:message key="admin.page.allAccounts" var="allAccounts"/>
                <fmt:message key="admin.users.user" var="user_rank"/>
                <fmt:message key="admin.users.admin" var="admin_rank"/>
                <fmt:message key="admin.users.gotoProfile" var="gotoProfile"/>
                <fmt:message key="registration.name" var="name"/>
                <fmt:message key="registration.surname" var="surname"/>
                <fmt:message key="registration.email" var="email"/>
                <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                <fmt:message key="registration.tooltipOnlyDigits" var="tooltipOnlyDigits"/>
                <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">

                                    <div class="card-header">
                                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center"
                                            role="tablist">
                                            <li class="nav-item-active">
                                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="true"
                                                   onclick="document.getElementById('form-showUsers').submit(); return false;">
                                                    <img src="resources/images/all-users.png"
                                                         class="icon-sidebar"
                                                         style="width: 21px; height: 21px; top: -1px;" alt=""/>
                                                    ${allUsers}
                                                    <span class="badge badge-pill badge-light">
                                                        ${totalUsers}
                                                    </span>
                                                </a>
                                                <form action="/" method="GET" id="form-showUsers" role="form"></form>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link nav-link-hover" role="tab" data-toggle="tab"
                                                   aria-selected="false"
                                                   onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                                    <img src="resources/images/show-accounts.png" class="icon-sidebar"
                                                         style="width: 20px; height: 20px;" alt=""/>
                                                    ${allAccounts}
                                                    <span class="badge badge-pill badge-light">
                                                        ${totalAccounts}
                                                    </span>
                                                </a>
                                                <form action="/" method="GET" role="form" id="form-showAccounts">
                                                    <input type="hidden" name="command" value="showAccounts"/>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>

                                    <c:choose>
                                        <c:when test="${totalUsers != null && totalUsers != 0}">
                                            <div class="card-body" style="margin-top: 25px;">
                                                <div class="row" style="padding: 0 20px 0 35px;">
                                                    <div class="col-lg-3 col-xl-3">
                                                        <div class="search-block">
                                                            <label>
                                                                    ${searchCriteria}:
                                                            </label>
                                                            <form action="/" method="POST" role="form">
                                                                <input type="hidden" name="command"
                                                                       value="searchUsers"/>

                                                                <div>
                                                                    <input id="name" name="name" type="text"
                                                                           class="form-control"
                                                                           data-toggle="tooltip-left"
                                                                           data-title="${tooltipOnlyLetters}"
                                                                           maxlength="24" placeholder="${name}"
                                                                           value="${nameValue}"/>
                                                                    <label for="name"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <!-- Surname -->
                                                                <div>
                                                                    <input id="surname" name="surname" type="text"
                                                                           class="form-control"
                                                                           data-toggle="tooltip-left"
                                                                           data-title="${tooltipOnlyLetters}"
                                                                           maxlength="32" placeholder="${surname}"
                                                                           value="${surnameValue}"/>
                                                                    <label for="surname"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <!-- Phone -->
                                                                <div style="margin-top: 8px">
                                                                    <input id="phone" name="phone" type="text"
                                                                           class="form-control"
                                                                           data-toggle="tooltip-left"
                                                                           data-title="${tooltipOnlyDigits}"
                                                                           onkeypress="inputOnlyNumbers();"
                                                                           value="${phoneValue}"/>
                                                                    <label for="phone"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <!-- Email -->
                                                                <div>
                                                                    <input id="email" name="email" type="text"
                                                                           class="form-control"
                                                                           data-toggle="tooltip-left"
                                                                           data-title="${tooltipEmail}"
                                                                           maxlength="45" placeholder="${email}"
                                                                           value="${emailValue}"/>
                                                                    <label for="email"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <div class="action" style="padding: 15px 0 10px 0">
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
                                                            <div class="card-container">
                                                                <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 row-cols-lg-2 row-cols-xl-3">

                                                                    <c:forEach items="${users}" var="user">
                                                                        <c:choose>
                                                                            <c:when test="${user.role.roleId == 1}">
                                                                                <div class="col mb-4">
                                                                                    <div class="card bg-light">
                                                                                        <div class="card-body">
                                                                                            <h5 class="card-title">
                                                                                                    ${user.name} ${user.surname}
                                                                                            </h5>
                                                                                            <small class="text-muted">
                                                                                                User ID: ${user.userId}
                                                                                            </small>
                                                                                        </div>
                                                                                        <div class="card-footer">
                                                                                            <span class="forward-right-link-img">
                                                                                                <a href="?command=showUser&userId=${user.userId}">
                                                                                                    ${gotoProfile}
                                                                                                    <img src="resources/images/forward.png"
                                                                                                         alt=""/>
                                                                                                </a>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="col mb-4">
                                                                                    <div class="card text-white bg-primary">
                                                                                        <div class="card-body">
                                                                                            <h5 class="card-title">
                                                                                                    ${user.name} ${user.surname}
                                                                                                <img src="resources/images/shield-white.png"
                                                                                                     style="width: 14px; height: 14px; margin: 0 0 3px 0; cursor: text;"
                                                                                                     alt=""/>
                                                                                            </h5>
                                                                                            <small>
                                                                                                    ${admin_rank}
                                                                                            </small>
                                                                                        </div>
                                                                                        <div class="card-footer">
                                                                                            <span class="forward-right-link-img">
                                                                                                <a href="?command=showUser&userId=${user.userId}"
                                                                                                   class="text-white">
                                                                                                    ${gotoProfile}
                                                                                                    <img src="resources/images/forward-white.png"
                                                                                                         alt=""/>
                                                                                                </a>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="card-body" style="min-height: 280px; padding: 35px;">
                                                <div class="message-block">
                                                    <span>
                                                        <label>
                                                             <fmt:message key="admin.users.noUsers"/>
                                                        </label>
                                                    </span>
                                                    <div class="w-100" style="height:172px;">
                                                        <img src="resources/images/error.png" alt=""
                                                             style="width: 172px; height: 172px; position: absolute; bottom: 35px; right: 55px;"/>
                                                    </div>
                                                </div>
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/searcher_admin.js"></script>
</html>