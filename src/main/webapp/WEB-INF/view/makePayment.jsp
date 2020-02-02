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
    <title><fmt:message key="home.makepayment.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 302px;">
            <p><strong>Success!</strong> Payment completed.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountFromBlockedError -->
    <c:if test="${accountFromBlockedError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 357px;">
            <p><strong>Failed!</strong> The selected account is locked.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert numberNotExistError -->
    <c:if test="${numberNotExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 432px;">
            <p><strong>Failed!</strong> Such a recipient card is not in the system.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert receiverAccountOrCardBlockedError -->
    <c:if test="${receiverAccountOrCardBlockedError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 408px;">
            <p><strong>Failed!</strong> Recipient's account or card is blocked.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert insufficientFundsError -->
    <c:if test="${insufficientFundsError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 378px;">
            <p><strong>Failed!</strong> Not enough funds in your account.</p>
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
                        <div class="login-wrapper" style="top: 40px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="home.makepayment.createNewPayment" var="createNewPayment"/>
                                    <fmt:message key="home.makepayment.fromAccount" var="from"/>
                                    <fmt:message key="home.makepayment.toCreditCard" var="to"/>
                                    <fmt:message key="home.makepayment.number" var="number"/>
                                    <fmt:message key="home.makepayment.amount" var="amount"/>
                                    <fmt:message key="home.makepayment.appointment" var="appointment"/>

                                    <h4>
                                        ${createNewPayment}
                                    </h4>

                                    <form action="?command=makePayment" role="form" method="POST">
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
                                                <fmt:message key="home.makepayment.accountIdError"/>
                                            </c:if>
                                        </label>

                                        <div style="width: 100%;">
                                            <label for="number" class="label-for-form">
                                                ${to}
                                            </label>
                                            <input type="text" name="number" class="form-control"
                                                   id="number" placeholder="${number}*"
                                                   value="${numberValue}"
                                            />
                                        </div>
                                        <label for="number" class="create-error-label">
                                            <c:if test="${numberError}">
                                                <fmt:message key="home.makepayment.numberError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <input type="text" name="amount" class="form-control"
                                               id="amount" placeholder="${amount}*"
                                               value="${amountValue}"
                                        />
                                        <label for="amount" class="create-error-label">
                                            <c:if test="${amountError}">
                                                <fmt:message key="home.makepayment.amountError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <div style="width: 100%; height:105px; position: relative;">
                                            <label for="appointment" class="label-for-form">
                                                ${appointment}
                                            </label>
                                            <div style="width: 100%; position: absolute; ">
                                            <textarea name="appointment" id="appointment" class="form-control"
                                                      style="height: 75px; resize: none; outline: none; overflow-x: hidden;"
                                            >${appointmentValue}</textarea>
                                            </div>
                                            <div class="counter">
                                                <span id="counter"></span>
                                            </div>
                                        </div>

                                        <div class="action" style="padding-bottom: 0px;padding-top: 30px;">
                                            <button type="submit" class="btn btn-primary signup">
                                                <fmt:message key="home.makepayment.makePayment"/>
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
</div>
</body>
</html>