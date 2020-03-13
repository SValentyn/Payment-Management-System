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
    <title><fmt:message key="user.page.title"/></title>
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
                <fmt:message key="user.page.myAccounts" var="myAccounts"/>
                <fmt:message key="user.page.myPayments" var="myPayments"/>

                <div class="card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center" role="tablist">
                            <li class="nav-item-home">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="false"
                                   onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                    <img src="resources/images/show-accounts.png" alt="" class="sidebar-icon">
                                    ${myAccounts}
                                </a>
                            </li>
                            <li class="nav-item-home">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="false"
                                   onclick="document.getElementById('form-showPayments').submit(); return false;">
                                    <img src="resources/images/balance.png" alt="" class="sidebar-icon">
                                    ${myPayments}
                                </a>
                            </li>
                        </ul>
                    </div>

                    <form action="/" method="GET" id="form-showAccounts" role="form">
                        <input type="hidden" name="command" value="showAccounts">
                    </form>
                    <form action="/" method="GET" id="form-showPayments" role="form">
                        <input type="hidden" name="command" value="showPayments">
                    </form>

                    <div class="card-body"></div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>
