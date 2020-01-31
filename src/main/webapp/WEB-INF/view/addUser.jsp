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
    <title><fmt:message key="admin.addUser.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content">
    <div class="row">
        <div class="col-md-2" style="margin-top: 50px;">
            <jsp:include page="template/sidebar.jsp"/>
        </div>

        <!-- Alert -->
        <c:if test="${created == true}">
            <div id="alert" class="alert alert-success fade in" role="alert" style="width: 255px; margin-top: 20px;">
                <p><strong>Success!</strong> Card created.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <!-- Alert addUserError -->
        <c:if test="${addUserError == true}">
            <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 430px; margin-top: 20px;">
                <p>Failed to add the user</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <!-- Alert numberExistError -->
        <c:if test="${phoneExistError == true}">
            <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 450px; margin-top: 20px;">
                <p><strong>Failed!</strong> A card with the same number already exists.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper"
                         style="top: 0px; display: inline-block; margin-top: 50px;">
                        <div class="box" style="padding-bottom: 0px;">
                            <div class="content-wrap">
                                <fmt:message key="admin.addUser.addNewUser" var="addNewUser"/>
                                <fmt:message key="admin.addUser." var="number"/>
                                <fmt:message key="admin.addUser." var="cvv"/>
                                <fmt:message key="admin.addUser." var="validity"/>

                                <h4 style="font-size: 26px; margin-bottom: 30px; text-align: center;">
                                    ${addNewUser}
                                </h4>

                                <form action="?command=addUser" class="form-horizontal" role="form" method="POST">
                                    <input type="hidden" name="command" value="addUser">



                                    <div class="action">
                                        <button type="submit" class="btn btn-primary signup">
                                            <fmt:message key="addCard.button.add"/>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>
</body>
</html>