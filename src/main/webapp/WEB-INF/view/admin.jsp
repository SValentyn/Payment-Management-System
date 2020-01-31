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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content">
    <div class="row">
        <div class="col-md-2">
            <jsp:include page="template/sidebar.jsp"/>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-12 panel-warning">

                    <form action="all-users" method="POST">
                        <fmt:message key="admin.showAllUsers" var="showAllUsers"/>
                        <input type="hidden" name="command" value="showAllUsers">
                        <input type="submit" value="${showAllUsers}">
                    </form>

                    <c:if test="${showUsers}">
                        <div class="content-box-header panel-heading">
                            <div class="panel-title ">
                                <fmt:message key="admin.allUsers"/>
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

                                <c:forEach items="${users}" var="user">
                                    <tr>
                                        <td>${user.name}</td>
                                        <td>${user.surname}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>
                                            <a href="#my_modal" data-toggle="modal" data-user-id="${user.userId}">
                                                <fmt:message key="admin.addAccount"/>
                                            </a>
                                        </td>
                                        <td>
                                            <c:url value="?command=showuserinfo&userId=${user.userId}" var="cardInfo"/>
                                            <a href="${cardInfo}">
                                                <fmt:message key="admin.showUserAccounts"/>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${showUser}">
                        <div class="content-box-header panel-heading">
                            <div class="panel-title ">
                                <fmt:message key="admin.allUsers"/>
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

                                <tr>
                                    <td>${user.name}</td>
                                    <td>${user.surname}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <a href="#my_modal" data-toggle="modal" data-user-id="${user.userId}">
                                            <fmt:message key="admin.addAccount"/>
                                        </a>
                                    </td>
                                    <td>
                                        <c:url value="?command=showuserinfo&userId=${user.userId}" var="cardInfo"/>
                                        <a href="${cardInfo}">
                                            <fmt:message key="admin.showUserAccounts"/>
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="row"></div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>

<div class="modal" id="my_modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="user" name="user" action="accounts" method="post">
                <div class="modal-header">
                    <input type="hidden" name="command" value="addAccount">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">
                        <fmt:message key="admin.modal.close"/></span>
                    </button>
                    <h4 class="modal-title">
                        <fmt:message key="admin.modal.addaccount"/>
                    </h4>
                </div>
                <div class="modal-body">
                    <p>
                        <fmt:message key="admin.modal.enterNumber"/>
                    </p>
                    <input type="hidden" name="userId" value=""/>
                    <label id="numberLabel"></label>
                    <input id="number" type="text" name="number"/>
                    <p>
                        <br><br>
                        <fmt:message key="admin.modal.enterBeginningSum"/>
                    </p>
                    <input id="balance" type="text" name="balance" value="0">
                </div>
                <div class="modal-footer">
                    <button id="send" class="btn btn-primary">
                        <fmt:message key="admin.modal.send"/>
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <fmt:message key="admin.modal.close"/>
                    </button>
                </div>
            </form>

            <script type="text/javascript">
                (function () {
                    let form = document.querySelector('#user');
                    let searchInput = document.querySelector('#number');
                    let searchBalance = document.querySelector('#balance');

                    form.addEventListener('submit', function (event) {
                        let letters = /[0-9]{20}/;
                        if (!searchInput.value.match(letters)) {
                            alert('Enter only numbers 20 digits');
                            event.preventDefault();
                        } else {
                            alert("OK");
                        }
                    });
                })();
            </script>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>

<script type="text/javascript">
    $('#my_modal').on('show.bs.modal', function (e) {
        let userId = $(e.relatedTarget).data('user-id');
        $(e.currentTarget).find('input[name="userId"]').val(userId);
    });
</script>
</body>
</html>
