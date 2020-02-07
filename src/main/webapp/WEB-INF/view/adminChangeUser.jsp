<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="admin.changeUserData.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${updated == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 355px;">
            <p><strong>Success!</strong> Your data has been updated.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${phoneExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 487px;">
            <p><strong>Failed!</strong> A user with such a phone is already in the system.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert changeDataError -->
    <c:if test="${changeDataError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 303px;">
            <p><strong>Failed</strong> to change data. Try later.</p>
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

            <div class="page-content container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-wrapper">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="admin.changeUserData.formHeader" var="formHeader"/>
                                    <fmt:message key="registration.name" var="name"/>
                                    <fmt:message key="registration.surname" var="surname"/>
                                    <fmt:message key="registration.phone" var="phone"/>
                                    <fmt:message key="registration.email" var="email"/>
                                    <fmt:message key="admin.changeUserData.updateDataButton" var="updateDataButton"/>
                                    <fmt:message key="admin.changeUserData.backButton" var="backButton"/>
                                    <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                    <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                    <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>

                                    <h4>
                                        ${formHeader}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="changeUserData">

                                        <!-- User Id -->
                                        <input id="userId" name="userId" class="form-control"
                                               type="hidden" value="${userId}"/>

                                        <!-- Name -->
                                        <input id="name" name="name" class="form-control" style="height: 36px;"
                                               type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                               pattern="[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}" minlength="1" maxlength="24"
                                               placeholder="${name}*"
                                               value="${nameValue}"
                                        >
                                        <label for="name" class="reg-error-label">
                                            <c:if test="${nameError}">
                                                <fmt:message key="registration.nameError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Surname -->
                                        <input id="surname" name="surname" class="form-control" style="height: 36px;"
                                               type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                               pattern="[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}" minlength="1" maxlength="24"
                                               placeholder="${surname}*"
                                               value="${surnameValue}">
                                        <label for="surname" class="reg-error-label">
                                            <c:if test="${surnameError}">
                                                <fmt:message key="registration.surnameError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Phone -->
                                        <input id="phone" name="phone" class="form-control" style="height: 36px;"
                                               type="text" data-toggle="tooltip" data-title="${tooltipPhone}"
                                               maxlength="10" onkeypress="onlyNumbers();"
                                               placeholder="${phone}*"
                                               value="${phoneValue}">
                                        <label for="phone" class="reg-error-label">
                                            <c:if test="${phoneError}">
                                                <fmt:message key="registration.phoneError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Email -->
                                        <input id="email" name="email" class="form-control" style="height: 36px;"
                                               type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" maxlength="45"
                                               placeholder="${email}"
                                               value="${emailValue}">
                                        <label for="email" class="reg-error-label"></label>&nbsp;

                                        <!-- Submit -->
                                        <div class="action" style="padding: 10px 0 10px 0">
                                            <button type="submit" class="btn btn-primary signup" onfocus="this.blur()">
                                                ${updateDataButton}
                                            </button>
                                        </div>

                                        <!-- Back Button -->
                                        <div class="action">
                                            <button type="button" class="btn btn-default signup"
                                                    style="padding: 0;" onfocus="this.blur()">
                                                <a href="?command=showUsers">
                                                    ${backButton}
                                                </a>
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
</div>
</body>
</html>