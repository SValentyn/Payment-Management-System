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
    <title><fmt:message key="admin.support.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminSupport.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert showLettersError -->
    <c:if test="${response eq 'showLettersError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowLettersError"/>
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
                <fmt:message key="admin.support.allLetters" var="formHeader"/>
                <fmt:message key="admin.support.status" var="status"/>
                <fmt:message key="admin.support.notProcessed" var="notProcessed"/>
                <fmt:message key="admin.support.timeToReceive" var="timeToReceive"/>
                <fmt:message key="admin.support.typeQuestion" var="typeQuestion"/>
                <fmt:message key="admin.support.showInfo" var="showInfo"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>

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
                                                    <c:when test="${response ne 'showLettersError' && lettersEmpty == false}">
                                                        <div class="row">
                                                            <div class="col-lg-3 col-xl-3">
                                                                <div style="text-align: center; margin: 0 0 30px 0;">
                                                                    <label style="margin-bottom: 30px; font-size: 16px; text-transform: uppercase;">
                                                                            ${searchCriteria}:
                                                                    </label>
                                                                    <form action="/" method="GET" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="searchLetters">
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
                                                                    <div class="card-container">
                                                                        <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1 row-cols-xl-1">
                                                                            <c:forEach items="${letters}" var="letter">
                                                                                <div class="col mb-4">
                                                                                    <div class="card bg-light">
                                                                                        <div class="card-body"
                                                                                             style="padding: 0.75rem 1.25rem;">
                                                                                            <p class="card-title text-muted">
                                                                                                <span>
                                                                                                    #${letter.letterId}
                                                                                                </span>
                                                                                                <span style="padding-left: 28px;">
                                                                                                        ${letter.date}
                                                                                                </span>
                                                                                                <span class="type-question">
                                                                                                        ${letter.typeQuestion}
                                                                                                </span>
                                                                                                <span class="forward-right-link-img"
                                                                                                      style="padding-left: 28px;">
                                                                                                    <a href="?command=showLetterInfo&letterId=${letter.letterId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/forward.png"
                                                                                                             alt="${showInfo}">
                                                                                                    </a>
                                                                                                </span>
                                                                                            </p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="message-block">
                                                            <span class="title-label">
                                                                <label>
                                                                    <fmt:message key="admin.support.noLetters"/>
                                                                </label>
                                                            </span>
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
