<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<html>
<head>
    <title><fmt:message key="createAccount.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.css" rel="stylesheet">
</head>
<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content" style="height: 800px;">
    <div class="row" style="height: 800px;">
        <div class="col-md-2" style="margin-top: 50px;">
            <jsp:include page="template/sidebar.jsp"/>
        </div>

        <!-- Alert -->
        <c:if test="${created == true}">
            <div id="alert" class="alert alert-success fade in" role="alert" style="width: 272px; margin-top: 20px;">
                <p><strong>Success!</strong> Account created.</p>
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
                                <fmt:message key="createAccount.createNewAccount" var="createNewAccount"/>
                                <fmt:message key="createAccount.numberNewAccount" var="numberNewAccount"/>

                                <h4 style="text-align: center;font-size: 26px; margin-bottom: 30px;">
                                    ${createNewAccount}
                                </h4>
                                <form action="?command=createAccount" method="POST">
                                    <input type="hidden" name="command" value="?command=createAccount"/>
                                    <input id="number" name="number" class="form-control" type="text"
                                           placeholder="${numberNewAccount}*"
                                           value="${numberValue}">
                                    <label for="number" class="create-error-label" style="padding-left: 6px;">
                                        <c:if test="${numberError}">
                                            <fmt:message key="createAccount.numberError"/>
                                        </c:if>
                                    </label>
                                    <label for="number" class="create-error-label">
                                        <c:if test="${numberExistError}">
                                            <fmt:message key="createAccount.numberExistError"/>
                                        </c:if>
                                    </label>
                                    <label for="number" class="create-error-label">
                                        <c:if test="${paymentError}">
                                            <fmt:message key="createAccount.paymentError"/>
                                        </c:if>&nbsp;
                                    </label>

                                    <div class="action">
                                        <button type="submit" class="btn btn-primary signup">
                                            <fmt:message key="createAccount.createNewAccountButton"/>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 350px;">
                    <div class="row">
                        <div class="col-md-12">
                            <fmt:message key="home.allaccounts" var="allaccounts"/>
                            <fmt:message key="home.account.number" var="number"/>
                            <fmt:message key="home.account.balance" var="balance"/>
                            <fmt:message key="home.account.status" var="status"/>
                            <fmt:message key="home.account.action" var="action"/>
                            <fmt:message key="home.account.status.active" var="statusActive"/>
                            <fmt:message key="home.account.status.blocked" var="statusBlocked"/>
                            <fmt:message key="home.account.button.block" var="block"/>
                            <fmt:message key="home.account.button.showInfo" var="showInfo"/>

                            <div class="content-box-header">
                                <div class="panel-title">
                                    ${allaccounts}
                                </div>
                            </div>

                            <div class="content-box-large box-with-header">
                                <table>
                                    <th>${number}</th>
                                    <th>${balance}</th>
                                    <th>${status}</th>
                                    <th>${action}</th>
                                    <th></th>

                                    <c:forEach items="${accounts}" var="account">
                                        <tr>
                                            <td>${account.number}</td>
                                            <td>${account.balance}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${account.isBlocked}">
                                                        ${statusBlocked}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${statusActive}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${!account.isBlocked}">
                                                    <a href="?command=blockAccount&accountId=${account.accountId}">${block}</a>
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="?command=showInfo&accountId=${account.accountId}">${showInfo}</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
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