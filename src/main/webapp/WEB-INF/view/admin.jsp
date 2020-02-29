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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert noUsers -->
    <c:if test="${noUsers == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertNoUsersError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert deleteUserError -->
    <c:if test="${deleteUserError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertDeleteUserError"/>
            </p>
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

            <div class="col-md-10" style="padding-left: 0;">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <c:choose>
                                <c:when test="${showUsers}">
                                    <fmt:message key="admin.users.allUsers" var="allUsers"/>
                                    <fmt:message key="admin.users.name" var="name"/>
                                    <fmt:message key="admin.users.surname" var="surname"/>
                                    <fmt:message key="admin.users.email" var="email"/>
                                    <fmt:message key="admin.users.phone" var="phone"/>
                                    <fmt:message key="admin.users.updateData" var="updateData"/>
                                    <fmt:message key="admin.users.addAccount" var="addAccount"/>
                                    <fmt:message key="admin.users.showUserAccounts" var="showAccounts"/>
                                    <fmt:message key="admin.users.deleteUser" var="deleteUser"/>
                                    <fmt:message key="admin.users.delete" var="delete"/>

                                    <div class="content-box-header">
                                        <div class="panel-title">
                                                ${allUsers}
                                        </div>
                                    </div>

                                    <div class="content-box-large box-with-header">
                                        <table>
                                            <th>${name}</th>
                                            <th>${surname}</th>
                                            <th>${email}</th>
                                            <th>${phone}</th>
                                            <th>${updateData}</th>
                                            <th>${addAccount}</th>
                                            <th>${showAccounts}</th>
                                            <th>${deleteUser}</th>

                                            <c:forEach items="${users}" var="user">
                                                <tr>
                                                    <td>${user.name}</td>
                                                    <td>${user.surname}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.phone}</td>
                                                    <td>
                                                        <a href="?command=updateUserData&userId=${user.userId}">
                                                                ${updateData}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=attachAccount&userId=${user.userId}">
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
                                                                ${delete}
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise/>
                            </c:choose>
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
