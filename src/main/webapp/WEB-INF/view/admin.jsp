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
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert noUsers -->
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

    <!-- Alert Success -->
    <c:if test="${response eq 'userDeletedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertUserDeleted"/>
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
                <fmt:message key="admin.users.allUsers" var="allUsers"/>
                <fmt:message key="admin.users.user" var="user_rank"/>
                <fmt:message key="admin.users.admin" var="admin_rank"/>
                <fmt:message key="admin.users.gotoProfile" var="gotoProfile"/>
                <fmt:message key="admin.users.noUsers" var="noUsers"/>

                <div class="card shadow-none">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center" role="tablist">
                            <li class="nav-item-active">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="true"
                                   onclick="document.getElementById('form-showUsers').submit(); return false;">
                                    <img src="resources/images/show-users.png"
                                         alt="" class="sidebar-icon" style="opacity: 0.6;">
                                    ${allUsers} <span class="badge badge-pill badge-light">${totalUsers}</span>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <form action="" method="GET" id="form-showUsers" role="form"></form>

                    <c:choose>
                        <c:when test="${totalUsers != null && totalUsers != 0}">
                            <div class="card-body">
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 row-cols-lg-3 row-cols-xl-4">
                                    <c:forEach items="${users}" var="user">
                                        <c:choose>
                                            <c:when test="${user.role.id == 1}">
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
                                                            <a href="?command=showUser&userId=${user.userId}">
                                                                    ${gotoProfile}<span class="arrow-link-symbol-right">→</span>
                                                            </a>
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
                                                            </h5>
                                                            <small>
                                                                    ${admin_rank}
                                                            </small>
                                                        </div>
                                                        <div class="card-footer">
                                                            <a class="text-white"
                                                               href="?command=showUser&userId=${user.userId}">
                                                                    ${gotoProfile}<span class="arrow-link-symbol-right">→</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="card-body">
                                <div class="message-block">
                                    <label class="title-label">
                                            ${noUsers}
                                    </label>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>