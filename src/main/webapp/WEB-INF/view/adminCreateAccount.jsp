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
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 272px;">
            <p><strong>Success!</strong> Account created.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert numberExistError -->
    <c:if test="${numberExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 438px;">
            <p><strong>Failed!</strong> An account with this number already exists.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert createAccountError -->
    <c:if test="${createAccountError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 355px;">
            <p><strong>Failed</strong> to create new account. Try later.</p>
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
                        <div class="login-wrapper" style="top: 85px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="user.createAccount.createNewAccount" var="createNewAccount"/>
                                    <fmt:message key="admin.createAccount.user_bio" var="user_bio"/>
                                    <fmt:message key="user.createAccount.numberNewAccount" var="numberNewAccount"/>
                                    <fmt:message key="user.createAccount.createAccountButton" var="createAccountButton"/>
                                    <fmt:message key="admin.createAccount.showAccountsButton" var="showAccountsButton"/>
                                    <fmt:message key="admin.createAccount.addCardButton" var="addCardButton"/>
                                    <fmt:message key="user.createAccount.tooltipNumberAccount" var="tooltipNumberAccount"/>
                                    <fmt:message key="admin.createAccount.tooltipUserBio" var="tooltipUserBio"/>

                                    <h4>
                                        ${createNewAccount}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="addAccount"/>

                                        <!-- User Id -->
                                        <input id="userId" name="userId" class="form-control"
                                               type="hidden" value="${userId}"/>

                                        <!-- User bio -->
                                        <div class="form-group" style="margin-bottom: 24px;">
                                            <label class="label-for-form" style="width: 100%; font-size: 18px;">
                                                ${user_bio}

                                                <span tabindex="0" data-toggle="tooltip-right-hover"
                                                      title="${tooltipUserBio}">
                                                    <input id="bio" name="bio" class="form-control"
                                                           type="text" style="margin-top: 3px;"
                                                           disabled="disabled"
                                                           value="${bio}"/>
                                                </span>
                                            </label>
                                        </div>

                                        <!-- Number Account -->
                                        <input id="number" name="number" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipNumberAccount}"
                                               maxlength="20" onkeypress="onlyNumbers();"
                                               placeholder="${numberNewAccount}*"
                                               value="${number}">
                                        <label for="number" class="create-error-label">
                                            <c:if test="${numberError}">
                                                <fmt:message key="user.createAccount.numberError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Submit -->
                                        <div class="action" style="padding: 20px 0 10px 0">
                                            <button type="submit" class="btn btn-primary signup" onfocus="this.blur()">
                                                ${createAccountButton}
                                            </button>
                                        </div>

                                        <!-- Show Accounts Button -->
                                        <div class="action" style="padding: 0 0 10px 0;">
                                            <button type="button" class="btn btn-default signup"
                                                    style=" padding: 0;">
                                                <a href="?command=showAccountInfo">
                                                    ${showAccountsButton}
                                                </a>
                                            </button>
                                        </div>

                                        <!-- AddCard Button -->
                                        <c:choose>
                                            <c:when test="${created == true}">
                                                <div class="action">
                                                    <button type="button" class="btn btn-default signup"
                                                            style=" padding: 0;"
                                                            onfocus="this.blur()">
                                                        <a href="?command=addCard&accountId=${accountId}">
                                                                ${addCardButton}
                                                        </a>
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="action">
                                                    <button type="button" class="btn btn-default signup"
                                                            style=" padding: 0;"
                                                            onfocus="this.blur()" disabled="disabled">
                                                        <a href="?command=addCard&accountId=${accountId}">
                                                                ${addCardButton}
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
</body>
</html>