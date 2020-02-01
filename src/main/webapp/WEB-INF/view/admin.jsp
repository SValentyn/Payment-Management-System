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
    <title><fmt:message key="admin.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <div class="page-content">
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-md-10">
                <c:choose>
                    <c:when test="${showUsers}">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12">
                                    <fmt:message key="admin.allUsers" var="allUsers"/>
                                    <fmt:message key="admin.changeData" var="changeData"/>
                                    <fmt:message key="admin.addAccount" var="addAccount"/>
                                    <fmt:message key="admin.showUserAccounts" var="showAccounts"/>
                                    <fmt:message key="admin.deleteUser" var="deleteUser"/>

                                    <div class="content-box-header">
                                        <div class="panel-title">
                                                ${allUsers}
                                        </div>
                                    </div>

                                    <div class="content-box-large box-with-header">
                                        <table>
                                            <th><fmt:message key="admin.name"/></th>
                                            <th><fmt:message key="admin.surname"/></th>
                                            <th><fmt:message key="admin.email"/></th>
                                            <th><fmt:message key="admin.phone"/></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>

                                            <c:forEach items="${users}" var="user">
                                                <tr>
                                                    <td>${user.name}</td>
                                                    <td>${user.surname}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.phone}</td>
                                                    <td>
                                                        <a href="?command=changeData&userId=${user.userId}">
                                                                ${changeData}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=addAccount&userId=${user.userId}">
                                                                ${addAccount}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=showUserAccounts&userId=${user.userId}">
                                                                ${showAccounts}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=deleteUser&userId=${user.userId}">
                                                                ${deleteUser}
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
                    <span class="init-label">
                        <label>
                            <b>
                                <a href="?command=showAllUsers">
                                    <fmt:message key="admin.showAllUsers"/>
                                </a>
                            </b>
                        </label>
                    </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>
