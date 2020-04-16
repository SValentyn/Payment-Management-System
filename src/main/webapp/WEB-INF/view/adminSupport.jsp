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
                <c:choose>
                    <c:when test="${showLetters}">
                        <div class="row">
                            <div class="col-lg-12">
                                <fmt:message key="admin.support.allLetters" var="allLetters"/>
                                <fmt:message key="admin.support.status" var="status"/>
                                <fmt:message key="admin.support.notProcessed" var="notProcessed"/>
                                <fmt:message key="admin.support.timeToReceive" var="timeToReceive"/>
                                <fmt:message key="admin.support.typeQuestion" var="typeQuestion"/>
                                <fmt:message key="admin.support.showInfo" var="showInfo"/>

                                    ${allLetters}
                                User ID:

                                    ${timeToReceive}
                                    ${typeQuestion}
                                    ${showInfo}

                                <c:forEach items="${letters}" var="letter">
                                    ${letter.letterId}
                                    ${letter.date}
                                    ${letter.typeQuestion}

                                    <a href="?command=showLetterInfo&letterId=${letter.letterId}">
                                            ${showInfo}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="message-block">
                            <label class="title-label float-left">
                                <fmt:message key="admin.support.noLetters"/>
                            </label>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>
