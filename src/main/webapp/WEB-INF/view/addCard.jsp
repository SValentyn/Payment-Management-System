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
    <title>Add card</title>
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
                            <div class="panel-title">
                                <fmt:message key="addCard.addNewCard"/>
                            </div>
                            <c:if test="${cardError}">
                                <fmt:message key="addCard.cardError"/>
                            </c:if>
                        </div>
                        <fmt:message key="addCard.number" var="number"/>
                        <fmt:message key="addCard.cvv" var="cvv"/>
                        <fmt:message key="addCard.validity" var="validity"/>

                        <div class="panel-body">
                            <form action="accounts" class="form-horizontal" role="form" method="POST">
                                <input type="hidden" name="command" value="addCard"> <input
                                    type="hidden" name="accountId" value="${accountId}">

                                <div class="form-group">
                                    <label for="number" class="col-sm-2 control-label">${number}</label>
                                    <label>
                                        <c:if test="${numberError}">
                                            <fmt:message key="addCard.numberError"/>
                                        </c:if>
                                    </label>
                                    <div class="col-sm-10">
                                        <input type="text" name="number" class="form-control"
                                               id="number" placeholder="${number}" value="${numberValue}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="cvv" class="col-sm-2 control-label">${cvv}</label>
                                    <label>
                                        <c:if test="${cvvError}">
                                            <fmt:message key="addCard.cvvError"/>
                                        </c:if>
                                    </label>
                                    <div class="col-sm-10">
                                        <input type="text" name="cvv" class="form-control"
                                               id="cvv" placeholder="${cvv}" value="${cvvValue}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="validity" class="col-sm-2 control-label">${validity}</label>
                                    <label>
                                        <c:if test="${validityError}">
                                            <fmt:message key="addCard.validityError"/>
                                        </c:if>
                                    </label>
                                    <div class="col-sm-10">
                                        <input type="date" name="validity" class="form-control"
                                               id="validity" placeholder="${validity}" value="${validityValue}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="btn btn-primary">
                                            <fmt:message key="addCard.button.add"/>
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