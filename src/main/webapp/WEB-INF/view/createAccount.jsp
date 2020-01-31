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
    <title><fmt:message key="home.createAccount.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content" style="height: 800px;">
    <div class="row" style="height: 800px;">
        <div class="col-md-2" style="margin-top: 50px;">
            <jsp:include page="template/sidebar.jsp"/>
        </div>

        <!-- Alert Success -->
        <c:if test="${created == true}">
            <div id="alert" class="alert alert-success fade in" role="alert" style="width: 272px; margin-top: 20px;">
                <p><strong>Success!</strong> Account created.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <!-- Alert createAccountError -->
        <c:if test="${createAccountError == true}">
            <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 357px; margin-top: 20px;">
                <p><strong>Failed </strong> to create new account. Try later.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper" style="top: 0px; margin-top: 50px;margin-bottom: 30px;">
                        <div class="box" style="padding-bottom: 0px;">
                            <div class="content-wrap">
                                <fmt:message key="home.createAccount.createNewAccount" var="createNewAccount"/>
                                <fmt:message key="home.createAccount.numberNewAccount" var="numberNewAccount"/>

                                <h4 style="text-align: center;font-size: 26px; margin-bottom: 30px;">
                                    ${createNewAccount}
                                </h4>
                                <form action="?command=createAccount" method="POST">
                                    <input type="hidden" name="command" value="?command=createAccount"/>
                                    <input id="number" name="number" class="form-control" type="text"
                                           placeholder="${numberNewAccount}*"
                                           value="${numberValue}">
                                    <label for="number" class="create-error-label">
                                        <c:if test="${numberError}">
                                            <fmt:message key="home.createAccount.numberError"/>
                                        </c:if>
                                    </label>
                                    <label for="number" class="create-error-label">
                                        <c:if test="${numberExistError}">
                                            <fmt:message key="home.createAccount.numberExistError"/>
                                        </c:if>
                                    </label>
                                    <label for="number" class="create-error-label">
                                        <c:if test="${paymentError}">
                                            <fmt:message key="home.createAccount.paymentError"/>
                                        </c:if>&nbsp;
                                    </label>

                                    <div class="action">
                                        <button type="submit" class="btn btn-primary signup">
                                            <fmt:message key="home.createAccount.createNewAccountButton"/>
                                        </button>
                                    </div>
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
</body>
</html>