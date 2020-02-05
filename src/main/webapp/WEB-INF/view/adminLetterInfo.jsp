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
    <title><fmt:message key="admin.letter.title"/></title>
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
    <c:if test="${processed == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 275px;">
            <p><strong>Success!</strong> Letter processed.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert letterError -->
    <c:if test="${letterError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 388px;">
            <p><strong>Failed!</strong> Unable to retrieve letter information.</p>
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
                        <div class="login-wrapper" style="top: 0px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="admin.letter.title" var="title"/>
                                    <fmt:message key="admin.letter.letterFromUser" var="letterFromUser"/>
                                    <fmt:message key="admin.letter.user_bio" var="user_bio"/>
                                    <fmt:message key="admin.letter.phone" var="user_phone"/>
                                    <fmt:message key="admin.letter.email" var="user_email"/>
                                    <fmt:message key="admin.letter.description" var="letter_description"/>
                                    <fmt:message key="admin.letter.processedButton" var="processedButton"/>
                                    <fmt:message key="admin.letter.backButton" var="backButton"/>

                                    <h4 style="margin-bottom: 25px">
                                        ${letterFromUser}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="showLetterInfo">

                                        <!-- Letter Id -->
                                        <input id="letterId" name="letterId" class="form-control"
                                               type="hidden" value="${letterId}"/>

                                        <!-- bio -->
                                        <div style="margin-bottom: 10px;">
                                            <label for="bio" class="label-for-form">
                                                ${user_bio}
                                            </label>
                                            <div>
                                                <input id="bio" name="bio" class="form-control"
                                                       type="text" disabled="disabled" value="${bio}"/>
                                            </div>
                                        </div>

                                        <!-- Phone -->
                                        <div style="margin-bottom: 10px;">
                                            <label for="phone" class="label-for-form">
                                                ${user_phone}
                                            </label>
                                            <div>
                                                <input id="phone" name="phone" class="form-control"
                                                       type="text" disabled="disabled" value="${phone}"/>
                                            </div>
                                        </div>

                                        <!-- Email -->
                                        <div style="margin-bottom: 10px;">
                                            <label for="email" class="label-for-form">
                                                ${user_email}
                                            </label>
                                            <div>
                                                <input id="email" name="email" class="form-control"
                                                       type="text" disabled="disabled" value="${email}"/>
                                            </div>
                                        </div>

                                        <!-- Description -->
                                        <div style="margin-bottom: 10px;">
                                            <label for="description" class="label-for-form">
                                                ${letter_description}
                                            </label>
                                            <div>
                                                <textarea id="description" name="description"
                                                          class="form-control">${description}</textarea>
                                            </div>
                                        </div>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 20px 0 15px 0">
                                            <button type="submit" class="btn btn-primary signup"
                                                    style="width: 248px" onfocus="this.blur()">
                                                ${processedButton}
                                            </button>
                                        </div>

                                        <!-- Back -->
                                        <div class="action">
                                            <button type="button" class="btn btn-default signup"
                                                    style="width: 248px" onfocus="this.blur()">
                                                <a href="?command=support">
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