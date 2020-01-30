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
    <link id="themecss" rel="stylesheet" type="text/css"
          href="//www.shieldui.com/shared/components/latest/css/light/all.min.css"/>
    <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
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
            <div id="alert" class="alert alert-success fade in" role="alert" style="width: 272px; margin-top: 20px;">
                <p><strong>Success!</strong> Card created.</p>
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
                                <fmt:message key="addCard.addNewCard" var="addNewCard"/>
                                <fmt:message key="addCard.number" var="number"/>
                                <fmt:message key="addCard.cvv" var="cvv"/>
                                <fmt:message key="addCard.validity" var="validity"/>

                                <h4 style="font-size: 26px; margin-bottom: 30px; text-align: center;">
                                    ${addNewCard}
                                </h4>

                                <form action="?command=addCard" class="form-horizontal" role="form" method="POST">
                                    <input type="hidden" name="command" value="addCard">

                                    <select name="accountId" class="form-control"
                                            style="text-align: center; height: 42px; margin-bottom: 2px; font-size: 18px;">
                                        <option>
                                            <fmt:message key="addCard.selectAccount"/>
                                        </option>
                                        <c:forEach items="${accounts}" var="account">
                                            <option value="${account.accountId}">${account.number}</option>
                                        </c:forEach>
                                    </select>
                                    <label class="create-error-label"> <!-- for="accountId" -->
                                        <c:if test="${accountIdError}">
                                            <fmt:message key="addCard.accountIdError"/>
                                        </c:if>
                                    </label>

                                    <input type="text" name="number" class="form-control"
                                           id="number" placeholder="${number}*"
                                           value="${numberValue}"
                                    />
                                    <label for="number" class="create-error-label">
                                        <c:if test="${numberError}">
                                            <fmt:message key="addCard.numberError"/>
                                        </c:if>
                                    </label>
                                    <label for="number" class="create-error-label">
                                        <c:if test="${numberExistError}">
                                            <fmt:message key="addCard.numberExistError"/>
                                        </c:if>
                                    </label>&nbsp;

                                    <input type="text" name="cvv" class="form-control"
                                           id="cvv" placeholder="${cvv}*"
                                           value="${cvvValue}"
                                    />
                                    <label for="cvv" class="create-error-label">
                                        <c:if test="${cvvError}">
                                            <fmt:message key="addCard.cvvError"/>
                                        </c:if>
                                    </label>&nbsp;

                                    <div style="width: 100%; text-align: center;">
                                        <label for="validity"
                                               style="margin-right: 15px; margin-bottom: 0px; color: #555555; font-weight: normal; font-size: 18px;">
                                            ${validity}
                                        </label>
                                        <input name="validity" class="form-control"
                                               id="validity" style="height: 42px; "
                                               value="${validityValue}"
                                        />
                                    </div>

                                    <label for="validity" class="create-error-label">
                                        <c:if test="${validityError}">
                                            <fmt:message key="addCard.validityError"/>
                                        </c:if>
                                    </label>
                                    <label for="validity" class="create-error-label">
                                        <c:if test="${cardError}">
                                            <fmt:message key="addCard.cardError"/>
                                        </c:if>
                                    </label>&nbsp;
                                    <script type="text/javascript">
                                        jQuery(function ($) {
                                            $("#validity").shieldDatePicker();
                                        });
                                    </script>

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