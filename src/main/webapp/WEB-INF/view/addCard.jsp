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
    <title><fmt:message key="home.addCard.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css"/>
    <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 255px;">
            <p><strong>Success!</strong> Card created.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert numberExistError -->
    <c:if test="${numberExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 450px;">
            <p><strong>Failed!</strong> A card with the same number already exists.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardCreateError -->
    <c:if test="${cardCreateError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 354px;">
            <p><strong>Failed</strong> to add the card to your account.</p>
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
                        <div class="login-wrapper" style="top: 85px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="home.addCard.addNewCard" var="addNewCard"/>
                                    <fmt:message key="home.addCard.number" var="number"/>
                                    <fmt:message key="home.addCard.cvv" var="cvv"/>
                                    <fmt:message key="home.addCard.validity" var="validity"/>

                                    <h4>
                                        ${addNewCard}
                                    </h4>

                                    <form action="?command=addCard" class="form-horizontal" role="form" method="POST">
                                        <input type="hidden" name="command" value="addCard">

                                        <select name="accountId" class="form-control"
                                                style="text-align: center; height: 42px; margin-bottom: 2px; font-size: 18px;">
                                            <option>
                                                <fmt:message key="home.addCard.selectAccount"/>
                                            </option>
                                            <c:forEach items="${accounts}" var="account">
                                                <option value="${account.accountId}">${account.number}</option>
                                            </c:forEach>
                                        </select>
                                        <label class="create-error-label"> <!-- for="accountId" -->
                                            <c:if test="${accountIdError}">
                                                <fmt:message key="home.addCard.accountIdError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <input type="text" name="number" class="form-control"
                                               id="number" placeholder="${number}*"
                                               value="${numberValue}"
                                        />
                                        <label for="number" class="create-error-label">
                                            <c:if test="${numberError}">
                                                <fmt:message key="home.addCard.numberError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <input type="text" name="cvv" class="form-control"
                                               id="cvv" placeholder="${cvv}*"
                                               value="${cvvValue}"
                                        />
                                        <label for="cvv" class="create-error-label">
                                            <c:if test="${cvvError}">
                                                <fmt:message key="home.addCard.cvvError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <div style="width: 100%; text-align: center;">
                                            <label for="validity" class="label-for-form">
                                                ${validity}
                                            </label>
                                            <input name="validity" class="form-control"
                                                   id="validity" style="height: 42px;"
                                                   value="${validityValue}"
                                            />
                                        </div>
                                        <label for="validity" class="create-error-label">
                                            <c:if test="${validityError}">
                                                <fmt:message key="home.addCard.validityError"/>
                                            </c:if>
                                        </label>&nbsp;
                                        <script type="text/javascript">
                                            jQuery(function ($) {
                                                $("#validity").shieldDatePicker();
                                            });
                                        </script>

                                        <div class="action" style="padding-bottom: 10px;">
                                            <button type="submit" class="btn btn-primary signup">
                                                <fmt:message key="home.addCard.button.add"/>
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