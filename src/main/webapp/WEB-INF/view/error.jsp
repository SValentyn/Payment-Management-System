<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<c:set var="code" value="${requestScope['javax.servlet.error.status_code']}" scope="page"/>

<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="error.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
        @media (min-width: 1276px) {
            .footer {
                position: fixed;
            }
        }

        @media (max-width: 542px) {
            #error_detail_message .code {
                font-size: 74px !important;;
            }

            #error_detail_message .msg {
                margin-top: 18px;
                margin-bottom: 38px;
                font-size: 52px !important;
            }

            .back-homepage {
                font-size: 20px !important;
            }
        }

        @media (max-width: 356px) {
            #error_detail_message .code {
                font-size: 56px !important;;
            }

            #error_detail_message .msg {
                margin-top: 16px;
                margin-bottom: 34px;
                font-size: 34px !important;
            }

            .back-homepage {
                font-size: 15px !important;
            }
        }
    </style>
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <div class="page-content container-fluid">
        <div class="row justify-content-center">
            <div class="col-xl-8">

                <fmt:message key="error.404" var="error_404"/>
                <fmt:message key="error.500" var="error_500"/>
                <fmt:message key="error.goBackHome" var="goBackHome"/>

                <c:if test="${code == '404'}">
                    <c:set var="errorMessage" value="${error_404}" scope="page"/>
                </c:if>
                <c:if test="${code == '500'}">
                    <c:set var="errorMessage" value="${error_500}" scope="page"/>
                </c:if>

                <div style="text-align: center; margin-top: 85px;">
                    <span id="error_detail_message">
                         <c:if test="${not empty code}">
                             <h1 class="code">●&nbsp;&nbsp;<c:out value="${code}"/>&nbsp;&nbsp;●</h1>
                         </c:if>

                         <c:if test="${not empty errorMessage}">
                             <h1 class="msg"><c:out value="${errorMessage}"/></h1>
                         </c:if>
                    </span>
                    <a href="/" class="back-homepage">
                        ${goBackHome}<img src="resources/images/back-home.png" alt="" class="icon">
                    </a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>