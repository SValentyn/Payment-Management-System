<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key="adduser.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.css" rel="stylesheet">
    <link href="resources/css/forms.css" rel="stylesheet">
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
                <div class="col-md-6">
                    <div class="content-box-large">
                        <div class="panel-heading">
                            <div class="panel-title"><fmt:message key="adduser.addNewUser"/></div>
                        </div>
                        <fmt:message key="adduser.name" var="name"/>
                        <fmt:message key="adduser.surname" var="surname"/>
                        <fmt:message key="adduser.phone" var="phone"/>

                        <div class="panel-body">
                            <form class="form-horizontal" role="form" method="POST">
                                <input type="hidden" name="command" value="adduser">
                                <label>
                                    <c:if test="${errorOccurred}">
                                        <fmt:message key="adduser.errorOccurred"/>
                                    </c:if>
                                </label>

                                <div class="form-group">
                                    <label for="name" class="col-sm-2 control-label">${name}</label>
                                    <label>
                                        <c:if test="${nameError}">
                                            <fmt:message key="adduser.nameError"/>
                                        </c:if>
                                    </label>
                                    <div class="col-sm-10">
                                        <input type="text" name="name" class="form-control"
                                               id="name" placeholder="${name}" value="${nameValue}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="surname" class="col-sm-2 control-label">${surname}</label>
                                    <label>
                                        <c:if test="${surnameError}">
                                            <fmt:message key="adduser.surnameError"/>
                                        </c:if>
                                    </label>
                                    <div class="col-sm-10">
                                        <input type="text" name="surname" class="form-control"
                                               id="surname" placeholder="${surname}" value="${surnameValue}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="phone" class="col-sm-2 control-label">${phone}</label>
                                    <label>
                                        <c:if test="${phoneError}">
                                            <fmt:message key="adduser.phoneError"/>
                                        </c:if>
                                    </label>
                                    <div class="col-sm-10">
                                        <input type="text" name="phone" class="form-control" id="phone"
                                               placeholder="${phone}" value="${phoneValue}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="btn btn-primary">
                                            <fmt:message key="adduser.button.add"/>
                                        </button>
                                    </div>
                                </div>
                            </form>
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