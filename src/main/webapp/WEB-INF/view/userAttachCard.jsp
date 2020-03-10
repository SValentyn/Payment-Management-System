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
    <title><fmt:message key="user.attachCard.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
        .bs-tooltip-right {
            margin-left: 11px;
        }
    </style>
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${attached == true}">
        <div id="alert" class="alert alert-success fade in" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertCardAttached"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardNumberError -->
    <c:if test="${cardNumberError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertCardNumberAttachError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardAttachError -->
    <c:if test="${cardAttachError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertCardAttachError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-lg-4 offset-lg-3">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <fmt:message key="user.attachCard.attachNewCard" var="attachNewCard"/>
                                        <fmt:message key="user.attachCard.selectAccount" var="selectAccount"/>
                                        <fmt:message key="user.attachCard.number" var="number"/>
                                        <fmt:message key="user.attachCard.cvv" var="cvv"/>
                                        <fmt:message key="user.attachCard.validity" var="validity"/>
                                        <fmt:message key="user.attachCard.month" var="month"/>
                                        <fmt:message key="user.attachCard.year" var="year"/>
                                        <fmt:message key="user.attachCard.attachButton" var="attachButton"/>
                                        <fmt:message key="user.attachCard.accountIdError" var="accountIdError"/>
                                        <fmt:message key="user.attachCard.numberError" var="numberError"/>
                                        <fmt:message key="user.attachCard.cvvError" var="cvvError"/>
                                        <fmt:message key="user.attachCard.validityError" var="validityError"/>
                                        <fmt:message key="user.attachCard.tooltipCardNumber" var="tooltipCardNumber"/>
                                        <fmt:message key="user.attachCard.tooltipCVV" var="tooltipCVV"/>
                                        <fmt:message key="registration.correct" var="correct"/>

                                        <h4>
                                            ${attachNewCard}
                                        </h4>

                                        <form action="/" role="form" method="POST">
                                            <input type="hidden" name="command" value="attachCard">

                                            <!-- AccountId -->
                                            <input id="accountId" name="accountId" type="hidden"
                                                   value="${accountIdValue}"/>

                                            <!-- Select AccountId -->
                                            <div>
                                                <label class="for-form-label">
                                                    ${selectAccount}
                                                </label>
                                                <div class="bfh-selectbox selectbox-account-id">
                                                    <c:choose>
                                                        <c:when test="${accountIdValue == null}">
                                                            <div data-value=""></div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div data-value="${accountIdValue}">${numberByAccountIdValue}</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:forEach items="${accounts}" var="account">
                                                        <div data-value="${account.accountId}">${account.number}</div>
                                                    </c:forEach>
                                                </div>
                                                <label for="accountId" class="default-label">
                                                    <span id="valid-msg-accountId" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-accountId" class="error-msg invisible">
                                                        ${accountIdError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Number -->
                                            <div>
                                                <input id="number" name="number" class="form-control" type="text"
                                                       data-toggle="tooltip" data-title="${tooltipCardNumber}"
                                                       maxlength="16" onkeypress="onlyNumbers();"
                                                       placeholder="${number}*"
                                                       value="${numberValue}"/>
                                                <label for="number" class="default-label">
                                                    <span id="valid-msg-cardNumber" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-cardNumber" class="error-msg invisible">
                                                        ${numberError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- CVV -->
                                            <div>
                                                <input id="CVV" name="CVV" class="form-control" type="text"
                                                       data-toggle="tooltip" data-title="${tooltipCVV}"
                                                       maxlength="3" onkeypress="onlyNumbers()"
                                                       placeholder="${cvv}*"
                                                       value="${cvvValue}"/>
                                                <label for="CVV" class="default-label">
                                                    <span id="valid-msg-cvv" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-cvv" class="error-msg invisible">
                                                        ${cvvError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Month -->
                                            <input id="month" name="month" type="hidden" value="${monthValue}"/>

                                            <!-- Year -->
                                            <input id="year" name="year" type="hidden" value="${yearValue}"/>

                                            <!-- Select Month and Year -->
                                            <div>
                                                <div class="form-group" id="expiration-date"
                                                     style="display: flex; align-items: center; margin: 10px 0 0 0;">
                                                    <label class="for-form-label" style="margin-right: 10px;">
                                                        ${validity}
                                                    </label>

                                                    <!-- Select Month -->
                                                    <div class="bfh-selectbox bfh-selectbox-month">
                                                        <c:choose>
                                                            <c:when test="${monthValue == null}">
                                                                <div data-value="">${month}</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div data-value="${monthValue}">${monthValue}</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div data-value="01">01</div>
                                                        <div data-value="02">02</div>
                                                        <div data-value="03">03</div>
                                                        <div data-value="04">04</div>
                                                        <div data-value="05">05</div>
                                                        <div data-value="06">06</div>
                                                        <div data-value="07">07</div>
                                                        <div data-value="08">08</div>
                                                        <div data-value="09">09</div>
                                                        <div data-value="10">10</div>
                                                        <div data-value="11">11</div>
                                                        <div data-value="12">12</div>
                                                    </div>

                                                    <!-- Select Year -->
                                                    <div class="bfh-selectbox bfh-selectbox-year">
                                                        <c:choose>
                                                            <c:when test="${yearValue == null}">
                                                                <div data-value="">${year}</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div data-value="${yearValue}">${yearValue}</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div data-value="2017">2017</div>
                                                        <div data-value="2018">2018</div>
                                                        <div data-value="2019">2019</div>
                                                        <div data-value="2020">2020</div>
                                                        <div data-value="2021">2021</div>
                                                        <div data-value="2022">2022</div>
                                                        <div data-value="2023">2023</div>
                                                        <div data-value="2024">2024</div>
                                                        <div data-value="2025">2025</div>
                                                    </div>
                                                </div>

                                                <label for="expiration-date" class="default-label">
                                                     <span id="valid-msg-validity" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-validity" class="error-msg invisible">
                                                        ${validityError}
                                                    </span>
                                                    <span id="validityExpiredError" class="error-msg invisible">
                                                        <c:if test="${validityExpiredError}">
                                                            <fmt:message key="user.attachCard.validityExpiredError"/>

                                                            <script>
                                                                document.querySelector("#validityExpiredError").classList.remove("invisible");
                                                                document.querySelector("#valid-msg-validity").classList.add("invisible");
                                                                document.querySelector("#error-msg-validity").classList.add("invisible");
                                                            </script>
                                                        </c:if>
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Submit -->
                                            <div class="action" style="padding: 20px 0 5px 0">
                                                <button id="submit" type="submit" class="btn btn-primary signup">
                                                    ${attachButton}
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
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/validator_userAttachCard.js"></script>
</html>