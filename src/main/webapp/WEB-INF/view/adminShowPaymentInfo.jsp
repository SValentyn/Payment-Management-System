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
    <title><fmt:message key="admin.payment_info.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
        .form-control {
            height: 46px !important;
            margin-top: 0 !important;
        }

        @media (min-width: 1342px) {
            .footer {
                position: fixed;
            }
        }

        @media (min-width: 2212px) {
            .footer {
                position: fixed;
            }
        }
    </style>
</head>
<body>

<div class="main">
    <jsp:include page="template/header.jsp"/>

    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <fmt:message key="admin.payment_info.formHeader" var="formHeader"/>
                <fmt:message key="admin.payment_info.senderAccountNumber" var="senderAccountNumber"/>
                <fmt:message key="admin.payment_info.recipientAccountNumber" var="recipientAccountNumber"/>
                <fmt:message key="admin.payment_info.recipientCardNumber" var="recipientCardNumber"/>
                <fmt:message key="admin.payment_info.accountOwner" var="accountOwner"/>
                <fmt:message key="admin.payment_info.cardOwner" var="cardOwner"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>
                <fmt:message key="admin.user.morePayments" var="morePayments"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4>
                                            ${formHeader}
                                        </h4>

                                        <jsp:useBean id="payment" scope="request" type="com.system.entity.Payment"/>
                                        <jsp:useBean id="senderAccount" scope="request"
                                                     type="com.system.entity.Account"/>
                                        <jsp:useBean id="senderUser" scope="request" type="com.system.entity.User"/>

                                        <div class="col-xl-12">
                                            <div class="row justify-content-center">
                                                <div class="col-md-6">

                                                    <!-- Sender Account Number -->
                                                    <label class="for-form-label">
                                                        ${senderAccountNumber}:
                                                    </label>
                                                    <div>
                                                        <input id="senderAccount" name="senderAccount" type="text"
                                                               class="form-control" readonly="readonly"
                                                               value="${senderAccount.number}"/>
                                                        <label for="senderAccount" class="default-label"></label>
                                                    </div>

                                                    <!-- Sender Account Owner -->
                                                    <label class="for-form-label">
                                                        ${accountOwner}:
                                                    </label>
                                                    <div>
                                                        <input id="senderAccountOwner" name="senderAccountOwner"
                                                               type="text" class="form-control" readonly="readonly"
                                                               value="${senderUser.name} ${senderUser.surname}"/>
                                                        <label for="senderAccountOwner"
                                                               class="default-label"></label>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <c:choose>
                                                        <c:when test="${recipientIsAccount == true}">
                                                            <jsp:useBean id="recipientAccount" scope="request"
                                                                         type="com.system.entity.Account"/>
                                                            <jsp:useBean id="recipientUser" scope="request"
                                                                         type="com.system.entity.User"/>

                                                            <!-- Recipient Account Number -->
                                                            <label class="for-form-label">
                                                                    ${recipientAccountNumber}:
                                                            </label>
                                                            <div>
                                                                <input id="recipientAccount" name="senderAccount"
                                                                       type="text" class="form-control"
                                                                       readonly="readonly"
                                                                       value="${recipientAccount.number}"/>
                                                                <label for="recipientAccount"
                                                                       class="default-label"></label>
                                                            </div>

                                                            <!-- Recipient Account Owner -->
                                                            <label class="for-form-label">
                                                                    ${accountOwner}:
                                                            </label>
                                                            <div>
                                                                <input id="recipientAccountOwner"
                                                                       name="recipientAccountOwner"
                                                                       type="text" class="form-control"
                                                                       readonly="readonly"
                                                                       value="${recipientUser.name} ${recipientUser.surname}"/>
                                                                <label for="recipientAccountOwner"
                                                                       class="default-label"></label>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <jsp:useBean id="recipientCard" scope="request"
                                                                         type="com.system.entity.BankCard"/>

                                                            <!-- Recipient Card Number -->
                                                            <label class="for-form-label">
                                                                    ${recipientCardNumber}:
                                                            </label>
                                                            <div>
                                                                <input id="recipientCard" name="recipientCard"
                                                                       type="text" class="form-control"
                                                                       readonly="readonly"
                                                                       value="${recipientCard.number}"/>
                                                                <label for="recipientCard"
                                                                       class="default-label"></label>
                                                            </div>

                                                            <!-- Recipient Card Owner -->
                                                            <label class="for-form-label">
                                                                    ${cardOwner}:
                                                            </label>
                                                            <div>
                                                                <input id="recipientCardOwner"
                                                                       name="recipientCardOwner"
                                                                       type="text" class="form-control"
                                                                       readonly="readonly"
                                                                       value="–"/>
                                                                <label for="recipientCardOwner"
                                                                       class="default-label"></label>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div class="col-md-6 text-center"
                                                     style="margin-top: 20px; font-size: 18px !important;">

                                                    <!-- Sent Funds -->
                                                    <span>
                                                        ${sentFunds}: ${payment.sum} ${senderAccount.currency}
                                                    </span><br/>

                                                    <!-- Received Funds -->
                                                    <!-- Will be changed -->
                                                    <c:choose>
                                                        <c:when test="${recipientIsAccount == true}">
                                                            <span>
                                                                ${receivedFunds}: ${payment.sum} ${recipientAccount.currency}
                                                            </span><br/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>
                                                                ${receivedFunds}: ${payment.sum} ${senderAccount.currency}
                                                            </span><br/>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <!-- Date and Time  -->
                                                    <span>
                                                        ${payment.date}
                                                    </span><br/>

                                                    <!-- Payment Condition  -->
                                                    <c:choose>
                                                        <c:when test="${payment.condition}">
                                                            <span class="text-success">
                                                                    ${success}
                                                            </span><br/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-danger">
                                                                    ${failed}
                                                            </span><br/>
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
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>