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
    <title><fmt:message key="admin.user_payments.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
        @media (min-width: 2212px) {
            .footer {
                position: fixed;
            }
        }

        @media (max-width: 744px) {
            .card-container {
                width: 100% !important;
                margin: 0;
            }
        }

        @media (max-width: 394px) {
            h4 {
                font-size: 18px !important;
            }

            .card-container {
                font-size: 80%;
            }
        }

        @media (max-width: 354px) {
            h4 {
                font-size: 16px !important;
            }

            .card-container {
                font-size: 65%;
            }
        }
    </style>
</head>
<body>

<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert showUserPaymentsError -->
    <c:if test="${showUserPaymentsError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowUserPaymentsError"/>
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
                <fmt:message key="admin.user_payments.formHeader" var="formHeader"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <div class="row justify-content-center">
                                            <div class="col-xl-12">

                                                <h4>
                                                    ${formHeader}
                                                </h4>

                                                <div class="card-container" style="width: 75%; margin: 40px auto auto;">
                                                    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1 row-cols-xl-1">
                                                        <c:forEach items="${payments}" var="payment">
                                                            <div class="col mb-4">
                                                                <div class="card bg-light">
                                                                    <div class="card-header">
                                                                        <small class="text-muted float-left">
                                                                                ${payment.date}
                                                                        </small>
                                                                        <c:choose>
                                                                            <c:when test="${payment.condition}">
                                                                                <small class="text-success float-right">
                                                                                        ${success}
                                                                                </small>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <small class="text-danger float-right">
                                                                                        ${failed}
                                                                                </small>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    <div class="card-body"
                                                                         style="padding: 0.75rem 1.25rem;">
                                                                        <p class="card-title text-muted">
                                                                                ${payment.senderNumber}
                                                                            <span style="margin: 0 5px 0 5px;">→</span>
                                                                                ${payment.recipientNumber}
                                                                            <a href="?command=showPaymentInfo&paymentId=${payment.paymentId}"
                                                                               style="float: right">
                                                                                <img src="resources/images/info.png"
                                                                                     alt="">
                                                                            </a>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
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
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>