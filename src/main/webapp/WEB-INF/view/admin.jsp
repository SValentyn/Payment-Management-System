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

<!-- Modal window -->
<div id="smallModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="admin.users.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="admin.users.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="user_bio" class="modal-label">
                        <fmt:message key="admin.users.user"/>
                    </label>
                    <input id="user_bio" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" style="border-radius: 5px;"
                            data-dismiss="modal" onfocus="this.blur()">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" role="form" method="POST">
                        <input type="hidden" name="command" value="deleteUser">
                        <input type="hidden" name="userId" id="userId"/>

                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur()">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${deleted == true}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="registration.success"/>!</strong>
                <fmt:message key="admin.page.alertUserDeleted"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert noUsers -->
    <c:if test="${noUsers == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
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
        <div id="alert" class="alert alert-danger fade show" role="alert">
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
                                    <fmt:message key="admin.users.firstName" var="firstName"/>
                                    <fmt:message key="admin.users.lastName" var="lastName"/>
                                    <fmt:message key="admin.users.email" var="email"/>
                                    <fmt:message key="admin.users.phone" var="phone"/>
                                    <fmt:message key="admin.users.updateData" var="updateData"/>
                                    <fmt:message key="admin.users.attachAccount" var="attachAccount"/>
                                    <fmt:message key="admin.users.showUserAccounts" var="showAccounts"/>
                                    <fmt:message key="admin.users.deleteUser" var="deleteUser"/>

                                    <div class="sidebar-header">
                                        <div class="panel-title">
                                                ${allUsers}
                                        </div>
                                    </div>

                                    <div class="sidebar-large box-with-header">
                                        <table class="table-bordered">
                                            <th>${firstName}</th>
                                            <th>${lastName}</th>
                                            <th>
                                                    ${email}
                                                <img src="resources/images/email.png"
                                                     alt="" class="icon icon-header">
                                            </th>
                                            <th>
                                                    ${phone}
                                                <img src="resources/images/phone.png"
                                                     alt="" class="icon icon-header">
                                            </th>
                                            <th>
                                                    ${attachAccount}
                                                <img src="resources/images/create-account.png"
                                                     alt="" class="icon icon-header" style="top: 0;">
                                            </th>
                                            <th>
                                                    ${showAccounts}
                                                <img src="resources/images/show-accounts.png"
                                                     alt="" class="icon icon-header">
                                            </th>
                                            <th>
                                                    ${updateData}
                                                <img src="resources/images/update-data.png"
                                                     alt="" class="icon icon-header">
                                            </th>
                                            <th>
                                                    ${deleteUser}
                                                <img src="resources/images/delete.png"
                                                     alt="" class="icon icon-header"
                                                     style="height: 16px; width: 16px; border-radius: 4px;">
                                            </th>

                                            <c:forEach items="${users}" var="user">
                                                <tr>
                                                    <td>${user.name}</td>
                                                    <td>${user.surname}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.phone}</td>
                                                    <td>
                                                        <a href="?command=attachAccount&userId=${user.userId}">
                                                                ${attachAccount}
                                                            <img src="resources/images/create-account-link.png"
                                                                 alt="" class="icon"
                                                                 style="top: 0;">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=showUserAccounts&userId=${user.userId}">
                                                                ${showAccounts}
                                                            <img src="resources/images/show-accounts-link.png"
                                                                 alt="" class="icon">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=updateUserData&userId=${user.userId}">
                                                                ${updateData}
                                                            <img src="resources/images/update-data-link.png"
                                                                 alt="" class="icon"
                                                                 style="height: 15px; width: 15px;">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="#smallModal?userId=${user.userId}&name=${user.name}&surname=${user.surname}"
                                                           onclick="showModal()">
                                                                ${deleteUser}
                                                            <img src="resources/images/delete-link.png"
                                                                 alt="" class="icon"
                                                                 style="height: 15px; width: 15px; border-radius: 4px;">
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
<script src="resources/js/showingModalWindow_admin.js"></script>
</html>
