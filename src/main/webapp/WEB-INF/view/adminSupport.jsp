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
    <title><fmt:message key="admin.support.title"/></title>
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
                <c:choose>
                <c:when test="${showLetters}">
                <div class="row">
                    <div class="col-lg-12">
                        <fmt:message key="admin.support.allLetters" var="allLetters"/>
                        <fmt:message key="admin.support.status" var="status"/>
                        <fmt:message key="admin.support.notProcessed" var="notProcessed"/>
                        <fmt:message key="admin.support.timeToReceive" var="timeToReceive"/>
                        <fmt:message key="admin.support.typeQuestion" var="typeQuestion"/>
                        <fmt:message key="admin.support.showInfo" var="showInfo"/>

                        <div class="sidebar-header">
                            <div class="panel-title">
                                    ${allLetters}
                            </div>
                        </div>

                        <div class="sidebar-large box-with-header">
                            <table>
                                <th>
                                    ID
                                </th>
                                <th>
                                        ${timeToReceive}
                                </th>
                                <th>
                                        ${typeQuestion}
                                </th>
                                <th>
                                        ${showInfo}
                                </th>

                                <c:forEach items="${letters}" var="letter">
                                    <tr>
                                        <td>${letter.letterId}</td>
                                        <td>${letter.date}</td>
                                        <td>${letter.typeQuestion}</td>
                                        <td>
                                            <a href="?command=showLetterInfo&letterId=${letter.letterId}">
                                                    ${showInfo}
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            </c:when>
            <c:otherwise>
                <span class="title-label" style="margin-left: 25px;">
                    <label>
                        <b>
                            <fmt:message key="admin.support.noLetters"/>
                        </b>
                    </label>
                </span>
            </c:otherwise>
            </c:choose>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>
