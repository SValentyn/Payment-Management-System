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
    <style>
        @media (min-width: 1342px) {
            .footer {
                position: fixed;
            }
        }
    </style>
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${processed == true}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertLetterProcessed"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert letterError -->
    <c:if test="${letterError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertLetterError"/>
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
                <div class="page-content container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 offset-xl-1 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <fmt:message key="admin.letter.title" var="title"/>
                                        <fmt:message key="admin.letter.letterFromUser" var="letterFromUser"/>
                                        <fmt:message key="admin.letter.user_bio" var="user_bio"/>
                                        <fmt:message key="admin.letter.phone" var="user_phone"/>
                                        <fmt:message key="admin.letter.email" var="user_email"/>
                                        <fmt:message key="admin.support.typeQuestion" var="typeQuestion"/>
                                        <fmt:message key="admin.letter.description" var="letter_description"/>
                                        <fmt:message key="admin.letter.processedButton" var="processedButton"/>
                                        <fmt:message key="admin.letter.backButton" var="backButton"/>

                                        <h4 style="margin-bottom: 25px">
                                            ${letterFromUser}
                                        </h4>

                                        <form action="" role="form" method="POST">
                                            <input type="hidden" name="command" value="showLetterInfo">

                                            <!-- Letter Id -->
                                            <input id="letterId" name="letterId" type="hidden" value="${letterId}"/>

                                            <div class="form-row">
                                                <div class="col-md-6">

                                                    <!-- User bio -->
                                                    <div>
                                                        <label class="for-form-label">
                                                            ${user_bio}
                                                        </label>
                                                        <div>
                                                            <input id="bio" name="bio" type="text" class="form-control"
                                                                   style="margin-top: 0;" readonly="readonly"
                                                                   value="${bioValue}"/>
                                                            <label for="bio" class="default-label"></label>
                                                        </div>
                                                    </div>

                                                    <!-- Phone -->
                                                    <div>
                                                        <label class="for-form-label">
                                                            ${user_phone}
                                                        </label>
                                                        <div>
                                                            <input id="phone" name="phone" type="tel"
                                                                   class="form-control" readonly="readonly"
                                                                   value="${phoneValue}"/>
                                                            <label for="phone" class="default-label"></label>
                                                        </div>
                                                    </div>

                                                    <!-- Email -->
                                                    <div>
                                                        <label class="for-form-label">
                                                            ${user_email}
                                                        </label>
                                                        <div>
                                                            <input id="email" name="email" type="email"
                                                                   class="form-control" style="margin-top: 0;"
                                                                   readonly="readonly"
                                                                   value="${emailValue}"/>
                                                            <label for="email" class="default-label"></label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">

                                                    <!-- Type Question -->
                                                    <div>
                                                        <label class="for-form-label">
                                                            ${typeQuestion}:
                                                        </label>
                                                        <div>
                                                            <input id="typeQuestion" name="typeQuestion" type="text"
                                                                   class="form-control" style="margin-top: 0;"
                                                                   readonly="readonly"
                                                                   value="${typeQuestionValue}"/>
                                                            <label for="typeQuestion" class="default-label"></label>
                                                        </div>
                                                    </div>

                                                    <!-- Description -->
                                                    <div class="textarea-parent">
                                                        <label class="for-form-label">
                                                            ${letter_description}
                                                        </label>
                                                        <div>
                                                    <textarea id="description" name="description" class="form-control"
                                                              style="min-height: 123px; padding-right: .75rem; resize: none;"
                                                              readonly="readonly"
                                                    >${descriptionValue}</textarea>
                                                            <label for="description" class="default-label"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Submit -->
                                            <div class="action" style="padding: 25px 0 10px 0">
                                                <button id="submit" type="submit" class="btn btn-primary signup"
                                                        style="width: 62%;">
                                                    ${processedButton}
                                                </button>
                                            </div>
                                        </form>

                                        <!-- Back Button -->
                                        <div class="action back-btn">
                                            <form action="/" method="GET" role="form">
                                                <input type="hidden" name="command" value="support">
                                                <input type="submit" class="btn btn-default signup"
                                                       style="width: 62%;"
                                                       value="${backButton}">
                                            </form>
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
<script src="resources/js/validator_adminLetterInfo.js"></script>
</html>