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
    <title><fmt:message key="user.createAccount.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${attached == true}">
        <div id="alert" class="alert alert-success fade in" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertAccountAttached"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert attachAccountError -->
    <c:if test="${attachAccountError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertAttachAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="page-content container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-wrapper">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="admin.attachAccount.formHeader" var="formHeader"/>
                                    <fmt:message key="admin.attachAccount.user_bio" var="user_bio"/>
                                    <fmt:message key="user.createAccount.numberNewAccount" var="numberNewAccount"/>
                                    <fmt:message key="admin.attachAccount.attachAccountButton"
                                                 var="attachAccountButton"/>
                                    <fmt:message key="admin.attachAccount.backToAccountsButton"
                                                 var="backToAccountsButton"/>
                                    <fmt:message key="admin.attachAccount.attachCardButton"
                                                 var="attachCardButton"/>
                                    <fmt:message key="user.createAccount.numberError" var="numberError"/>
                                    <fmt:message key="admin.attachAccount.tooltipUserBio" var="tooltipUserBio"/>
                                    <fmt:message key="registration.correct" var="correct"/>

                                    <h4 style="margin-bottom: 30px;">
                                        ${formHeader}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="attachAccount"/>

                                        <!-- User Id -->
                                        <input id="userId" name="userId" class="form-control"
                                               type="hidden" value="${userId}"/>

                                        <!-- User bio -->
                                        <div class="form-group" style="margin-bottom: 24px;">
                                            <label class="for-form-label" style="width: 100%;">
                                                ${user_bio}

                                                <span tabindex="0" data-toggle="tooltip-right-hover"
                                                      title="${tooltipUserBio}">
                                                    <input id="bio" name="bio" class="form-control"
                                                           type="text" style="margin-top: 0;"
                                                           disabled="disabled" onfocus="this.blur()"
                                                           value="${bio}"/>
                                                </span>
                                            </label>
                                        </div>

                                        <!-- Account Number -->
                                        <label class="for-form-label">
                                            ${numberNewAccount}
                                        </label>
                                        <div class="form-group" style="display: flex; margin-bottom: 0;">
                                            <input id="number" name="number" class="form-control"
                                                   type="text" readonly="readonly"
                                                   style="height: 46px; margin-top: 0; text-align: center; font-size: 18px;"
                                                   value="${numberValue}"/>
                                            <i id="repeat" class="glyphicon glyphicon-repeat" onfocus="this.blur()"></i>
                                        </div>
                                        <label for="number" class="default-label">
                                            <span id="valid-msg-accountNumber" class="hide">${correct} ✓</span>
                                            <span id="error-msg-accountNumber" class="hide">${numberError}</span>
                                            <c:if test="${numberExistError}">
                                                <span>
                                                    <fmt:message key="user.createAccount.numberExistError"/>
                                                </span>
                                                <script>
                                                    document.querySelector("#valid-msg-accountNumber").classList.add("hide");
                                                    document.querySelector("#error-msg-accountNumber").classList.add("hide");
                                                </script>
                                            </c:if>
                                        </label>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 25px 0 10px 0">
                                            <button id="submit" type="submit" class="btn btn-primary signup"
                                                    onfocus="this.blur()">
                                                ${attachAccountButton}
                                            </button>
                                        </div>

                                        <!-- Show Accounts Button -->
                                        <div class="action" style="padding: 0 0 10px 0;">
                                            <button type="button" class="btn btn-default signup" style="padding: 0;"
                                                    onfocus="this.blur()">
                                                <a href="?command=showAccountInfo">
                                                    ${backToAccountsButton}
                                                </a>
                                            </button>
                                        </div>

                                        <!-- AddCard Button -->
                                        <c:choose>
                                            <c:when test="${attached == true}">
                                                <div class="action">
                                                    <button type="button" class="btn btn-default signup"
                                                            style=" padding: 0;"
                                                            onfocus="this.blur()">
                                                        <a href="?command=attachCard&accountId=${accountId}">
                                                                ${attachCardButton}
                                                        </a>
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="action">
                                                    <button type="button" class="btn btn-default signup"
                                                            style="padding: 0;"
                                                            onfocus="this.blur()" disabled="disabled">
                                                        <a href="?command=attachCard&accountId=${accountId}">
                                                                ${attachCardButton}
                                                        </a>
                                                    </button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
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
<script src="resources/js/validator_adminAttachAccount.js"></script>
</body>
</html>