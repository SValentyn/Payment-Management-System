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
    <title><fmt:message key="admin.letter.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert unableGetLetterId -->
    <c:if test="${response eq 'unableGetLetterId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetLetterIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert showLetterError -->
    <c:if test="${response eq 'showLetterError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertShowLetterError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert letterWasProcessed -->
    <c:if test="${response eq 'letterWasProcessed'}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p><fmt:message key="admin.page.alertLetterWasProcessedWarning"/></p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert Success -->
    <c:if test="${response eq 'letterProcessedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertLetterProcessedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert letterProcessedError -->
    <c:if test="${response eq 'letterProcessedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertLetterProcessedError"/>
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
                <fmt:message key="admin.letter.title" var="title"/>
                <fmt:message key="admin.letter.letterFromUser" var="letterFromUser"/>
                <fmt:message key="admin.letter.user_bio" var="user_bio"/>
                <fmt:message key="admin.letter.phone" var="user_phone"/>
                <fmt:message key="admin.letter.email" var="user_email"/>
                <fmt:message key="user.support.option.1" var="option_1"/>
                <fmt:message key="user.support.option.2" var="option_2"/>
                <fmt:message key="user.support.option.3" var="option_3"/>
                <fmt:message key="user.support.option.4" var="option_4"/>
                <fmt:message key="user.support.option.5" var="option_5"/>
                <fmt:message key="user.support.option.6" var="option_6"/>
                <fmt:message key="user.support.option.7" var="option_7"/>
                <fmt:message key="user.support.option.8" var="option_8"/>
                <fmt:message key="user.support.option.9" var="option_9"/>
                <fmt:message key="user.support.option.10" var="option_10"/>
                <fmt:message key="admin.support.tooltipTypeOfQuestion" var="typeQuestion"/>
                <fmt:message key="admin.letter.description" var="letter_description"/>
                <fmt:message key="admin.letter.processedButton" var="processedButton"/>
                <fmt:message key="admin.letter.returnToLetters" var="returnToLetters"/>

                <div class="page-content container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 offset-xl-1 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4 style="margin-bottom: 25px;">
                                            ${letterFromUser}
                                        </h4>

                                        <!-- Perhaps there was an error or the letter was processed -->
                                        <c:choose>
                                            <c:when test="${response ne 'unableGetLetterId' &&
                                                            response ne 'showLetterError' &&
                                                            response ne 'letterProcessedSuccess'}">

                                                <form action="" method="POST" role="form">
                                                    <input type="hidden" name="command" value="showLetterInfo"/>

                                                    <!-- Letter Id -->
                                                    <input type="hidden" id="letterId" name="letterId"
                                                           value="${letterId}"/>

                                                    <div class="form-row">
                                                        <div class="col-md-6">

                                                            <!-- User bio -->
                                                            <div>
                                                                <label class="for-form-label">
                                                                        ${user_bio}:
                                                                </label>
                                                                <input id="bio" name="bio" type="text"
                                                                       class="form-control" style="margin-top: 0;"
                                                                       readonly="readonly"
                                                                       value="${bioValue}"/>
                                                                <label for="bio" class="default-label">&nbsp;</label>
                                                            </div>

                                                            <!-- Phone -->
                                                            <div>
                                                                <label class="for-form-label">
                                                                        ${user_phone}:
                                                                </label>
                                                                <input id="phone" name="phone" type="tel"
                                                                       class="form-control"
                                                                       readonly="readonly"
                                                                       value="${phoneValue}"/>
                                                                <label for="phone" class="default-label">&nbsp;</label>
                                                            </div>

                                                            <!-- Email -->
                                                            <div>
                                                                <label class="for-form-label">
                                                                        ${user_email}:
                                                                </label>
                                                                <input id="email" name="email" type="email"
                                                                       class="form-control" style="margin-top: 0;"
                                                                       readonly="readonly"
                                                                       value="${emailValue}"/>
                                                                <label for="email" class="default-label">&nbsp;</label>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">

                                                            <!-- Type Question -->
                                                            <div>
                                                                <label class="for-form-label">
                                                                        ${typeQuestion}:
                                                                </label>

                                                                <c:choose>
                                                                    <c:when test="${typeQuestionValue == 1}">
                                                                        <c:set var="typeQuestion" value="${option_1}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 2}">
                                                                        <c:set var="typeQuestion" value="${option_2}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 3}">
                                                                        <c:set var="typeQuestion" value="${option_3}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 4}">
                                                                        <c:set var="typeQuestion" value="${option_4}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 5}">
                                                                        <c:set var="typeQuestion" value="${option_5}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 6}">
                                                                        <c:set var="typeQuestion" value="${option_6}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 7}">
                                                                        <c:set var="typeQuestion" value="${option_7}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 8}">
                                                                        <c:set var="typeQuestion" value="${option_8}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 9}">
                                                                        <c:set var="typeQuestion" value="${option_9}"/>
                                                                    </c:when>
                                                                    <c:when test="${typeQuestionValue == 10}">
                                                                        <c:set var="typeQuestion" value="${option_10}"/>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:set var="typeQuestion" value=""/>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <input id="typeQuestion" name="typeQuestion" type="text"
                                                                       class="form-control" style="margin-top: 0;"
                                                                       readonly="readonly"
                                                                       value="${typeQuestion}"/>
                                                                <label for="typeQuestion" class="default-label">
                                                                    &nbsp;</label>
                                                            </div>

                                                            <!-- Description -->
                                                            <div class="textarea-parent">
                                                                <label class="for-form-label">
                                                                        ${letter_description}:
                                                                </label>
                                                                <div>
                                                                    <textarea id="description" name="description"
                                                                              class="form-control"
                                                                              style="min-height: 123px; padding-right: .75rem; resize: none;"
                                                                              readonly="readonly"
                                                                    >${descriptionValue}</textarea>
                                                                </div>
                                                                <label for="description" class="default-label">
                                                                    &nbsp;</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Submit -->
                                                    <c:choose>
                                                        <c:when test="${response ne 'letterWasProcessed'}">
                                                            <div class="action" style="padding: 25px 0 10px 0">
                                                                <button id="submit" type="submit"
                                                                        class="btn btn-primary signup"
                                                                        style="width: 62%;">
                                                                        ${processedButton}
                                                                </button>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="action" style="padding: 25px 0 10px 0">
                                                                <button type="submit"
                                                                        class="btn btn-primary signup disabled"
                                                                        disabled="disabled" style="width: 62%;">
                                                                        ${processedButton}
                                                                </button>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </form>

                                                <!-- Return to Letters -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="support"/>
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default"
                                                                style="width: 62%;">
                                                                ${returnToLetters}
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:when>
                                            <c:otherwise>

                                                <!-- Return to Letters -->
                                                <div class="message-block">
                                                    <span class="title-label forward-left-link-img">
                                                        <a href="?command=support" class="float-left">
                                                            <img src="resources/images/return.png"
                                                                 class="icon-return" alt=""/>
                                                                ${returnToLetters}
                                                        </a>
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/validator_adminShowLetterInfo.js"></script>
</html>