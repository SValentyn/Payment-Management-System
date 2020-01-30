<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key="makepayment.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.css" rel="stylesheet">
</head>
<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content">
    <div class="row">
        <div class="col-md-2" style="margin-top: 50px;">
            <jsp:include page="template/sidebar.jsp"/>
        </div>

        <!-- Alert Success -->
        <c:if test="${created == true}">
            <div id="alert" class="alert alert-success fade in" role="alert" style="width: 302px; margin-top: 20px;">
                <p><strong>Success!</strong> Payment completed.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <!-- Alert Danger -->
        <c:if test="${numberNotExistError == true}">
            <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 430px; margin-top: 20px;">
                <p><strong>Failed!</strong> Perhaps such a card is not in the system.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <!-- Alert Danger -->
        <c:if test="${paymentError == true}">
            <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 260px; margin-top: 20px;">
                <p><strong>Failed!</strong> Insufficient funds.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper" style="top: 0px; display: inline-block; margin-top: 50px;">
                        <div class="box" style="height: 530px;">
                            <div class="content-wrap">
                                <fmt:message key="makepayment.createNewPayment" var="createNewPayment"/>
                                <fmt:message key="makepayment.fromAccount" var="from"/>
                                <fmt:message key="makepayment.toCreditCard" var="to"/>
                                <fmt:message key="makepayment.number" var="number"/>
                                <fmt:message key="makepayment.amount" var="amount"/>
                                <fmt:message key="makepayment.appointment" var="appointment"/>

                                <h4 style="font-size: 26px; margin-bottom: 30px; text-align: center;">
                                    ${createNewPayment}
                                </h4>

                                <form action="?command=makePayment" class="form-horizontal" role="form" method="POST">
                                    <input type="hidden" name="command" value="makePayment">

                                    <select name="accountId" class="form-control"
                                            style="text-align: center; height: 42px; margin-bottom: 2px; font-size: 18px;">
                                        <option>
                                            ${from}
                                        </option>
                                        <c:forEach items="${accounts}" var="account">
                                            <option value="${account.accountId}">${account.number}</option>
                                        </c:forEach>
                                    </select>
                                    <label class="create-error-label"> <!-- for="accountId" -->
                                        <c:if test="${accountIdError}">
                                            <fmt:message key="makepayment.accountIdError"/>
                                        </c:if>
                                    </label>

                                    <div style="width: 100%;">
                                        <label for="number">
                                            ${to}
                                        </label>
                                        <input type="text" name="number" class="form-control"
                                               id="number" placeholder="${number}*"
                                               value="${numberValue}"
                                        />
                                    </div>
                                    <label for="number" class="create-error-label">
                                        <c:if test="${numberError}">
                                            <fmt:message key="makepayment.numberError"/>
                                        </c:if>
                                    </label>&nbsp;

                                    <input type="text" name="amount" class="form-control"
                                           id="amount" placeholder="${amount}*"
                                           value="${amountValue}"
                                    />
                                    <label for="amount" class="create-error-label">
                                        <c:if test="${amountError}">
                                            <fmt:message key="makepayment.amountError"/>
                                        </c:if>
                                    </label>&nbsp;

                                    <div style="width: 100%;">
                                        <label for="appointment">
                                            ${appointment}
                                        </label>
                                        <textarea name="appointment" id="appointment" class="form-control"
                                                  style="width: 100%; height: 75px; resize: none; outline: none; overflow-x: hidden;"
                                        ></textarea>
                                        <div class="counter" style="color: #929292; font-size: 14px; text-align: right; padding-right: 3px;">
                                            < <span id="counter"></span> >
                                        </div>
                                    </div>

                                    <div class="action" style="padding-bottom: 0px;padding-top: 30px;">
                                        <button type="submit" class="btn btn-primary signup">
                                            <fmt:message key="makepayment.makePayment"/>
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