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

    <!-- Alert cardAddError -->
    <c:if test="${cardAddError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 323px;">
            <p><strong>Failed</strong> to add the card to account.</p>
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
                        <div class="login-wrapper" style="top: 50px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="home.addCard.addNewCard" var="addNewCard"/>
                                    <fmt:message key="home.addCard.selectAccount" var="selectAccount"/>
                                    <fmt:message key="home.addCard.number" var="number"/>
                                    <fmt:message key="home.addCard.cvv" var="cvv"/>
                                    <fmt:message key="home.addCard.validity" var="validity"/>
                                    <fmt:message key="home.addCard.month" var="month"/>
                                    <fmt:message key="home.addCard.year" var="year"/>
                                    <fmt:message key="home.addCard.tooltipCardNumber" var="tooltipCardNumber"/>
                                    <fmt:message key="home.addCard.tooltipCVV" var="tooltipCVV"/>
                                    <fmt:message key="admin.addCard.backButton" var="backButton"/>

                                    <h4>
                                        ${addNewCard}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="addCard">

                                        <!-- Account Id -->
                                        <input id="accountId" name="accountId" class="form-control"
                                               type="hidden" value="${accountId}"/>

                                        <!-- Number ByAccountId -->
                                        <div class="form-group" style="margin-bottom: 24px;">
                                            <label class="label-for-form" style="width: 100%">
                                                Selected account number:
                                                <input id="numberByAccountIdValue" name="numberByAccountIdValue"
                                                       class="form-control" type="text" disabled="disabled"
                                                       value="${numberByAccountIdValue}"/>
                                            </label>
                                        </div>

                                        <!-- Number  -->
                                        <input id="number" name="number" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipCardNumber}"
                                               maxlength="16" onkeypress="onlyNumbers();"
                                               placeholder="${number}*"
                                               value="${numberValue}"
                                        />
                                        <label for="number" class="create-error-label">
                                            <c:if test="${numberError}">
                                                <fmt:message key="home.addCard.numberError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- CVV -->
                                        <input id="CVV" name="CVV" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipCVV}"
                                               maxlength="3" onkeypress="onlyNumbers()"
                                               placeholder="${cvv}*"
                                               value="${cvvValue}"
                                        />
                                        <label for="CVV" class="create-error-label">
                                            <c:if test="${cvvError}">
                                                <fmt:message key="home.addCard.cvvError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Month and Year -->
                                        <div id="expiration-date" class="form-group" style="margin-bottom: 6px; text-align: center;">
                                            <label class="label-for-form" style="margin-right: 10px;">
                                                ${validity}
                                            </label>

                                            <select name="month">
                                                <c:choose>
                                                    <c:when test="${monthValue == null}">
                                                        <option value="${0}">
                                                                ${month}
                                                        </option>
                                                    </c:when>
                                                    <c:when test="${monthValue == 0}">
                                                        <option value="${0}">
                                                                ${month}
                                                        </option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${monthValue}">
                                                                ${monthValue}
                                                        </option>
                                                    </c:otherwise>
                                                </c:choose>
                                                <option value="01">01</option>
                                                <option value="02">02</option>
                                                <option value="03">03</option>
                                                <option value="04">04</option>
                                                <option value="05">05</option>
                                                <option value="06">06</option>
                                                <option value="07">07</option>
                                                <option value="08">08</option>
                                                <option value="09">09</option>
                                                <option value="10">10</option>
                                                <option value="11">11</option>
                                                <option value="12">12</option>
                                            </select>
                                            <select name="year">
                                                <c:choose>
                                                    <c:when test="${yearValue == null}">
                                                        <option value="${0}">
                                                                ${year}
                                                        </option>
                                                    </c:when>
                                                    <c:when test="${yearValue == 0}">
                                                        <option value="${0}">
                                                                ${year}
                                                        </option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${yearValue}">
                                                                ${yearValue}
                                                        </option>
                                                    </c:otherwise>
                                                </c:choose>
                                                <option value="2017">2017</option>
                                                <option value="2018">2018</option>
                                                <option value="2019">2019</option>
                                                <option value="2020">2020</option>
                                                <option value="2021">2021</option>
                                                <option value="2022">2022</option>
                                                <option value="2023">2023</option>
                                                <option value="2024">2024</option>
                                                <option value="2025">2025</option>
                                            </select>
                                        </div>

                                        <label for="expiration-date" class="create-error-label">
                                            <c:if test="${validityError}">
                                                <fmt:message key="home.addCard.validityError"/>
                                            </c:if>
                                        </label>
                                        <label for="expiration-date" class="create-error-label">
                                            <c:if test="${validityExpiredError}">
                                                <fmt:message key="home.addCard.validityExpiredError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Submit -->
                                        <div class="action" style="padding-bottom: 10px;">
                                            <button type="submit" class="btn btn-primary signup">
                                                <fmt:message key="home.addCard.button.add"/>
                                            </button>
                                        </div>

                                        <!-- Back -->
                                        <div class="action">
                                            <button type="button" class="btn btn-default signup">
                                                <a href="?command=showAccountInfo&accountId=${accountId}">
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