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
    <title><fmt:message key="admin.page.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
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
                <fmt:message key="admin.users.allUsers" var="allUsers"/>

                <div class="card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center" role="tablist">
                            <li class="nav-item-home">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="false"
                                   onclick="document.getElementById('form-showUsers').submit(); return false;">
                                    <img src="resources/images/show-users.png"
                                         alt="" class="sidebar-icon" style="opacity: 0.6;">
                                    ${allUsers} <span class="badge badge-pill badge-light">${totalUsers}</span>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <form action="/" method="GET" id="form-showUsers" role="form">
                        <input type="hidden" name="command" value="showUsers">
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