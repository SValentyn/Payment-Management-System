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
    <title><fmt:message key="user.support.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${sended == true}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertLetterSended"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert manyLettersError -->
    <c:if test="${manyLettersError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertManyLettersError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert sendLetterError -->
    <c:if test="${sendLetterError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertSendLetterError"/>
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
                                        <fmt:message key="user.support.formHeader" var="formHeader"/>
                                        <fmt:message key="user.support.selectType" var="selectType"/>
                                        <fmt:message key="user.support.description" var="description"/>
                                        <fmt:message key="user.support.button.send" var="send"/>
                                        <fmt:message key="user.support.option.1" var="option_1"/>
                                        <fmt:message key="user.support.option.2" var="option_2"/>
                                        <fmt:message key="user.support.option.3" var="option_3"/>
                                        <fmt:message key="user.support.option.4" var="option_4"/>
                                        <fmt:message key="user.support.option.5" var="option_5"/>
                                        <fmt:message key="user.support.option.6" var="option_6"/>
                                        <fmt:message key="user.support.option.7" var="option_7"/>
                                        <fmt:message key="user.support.option.8" var="option_8"/>
                                        <fmt:message key="user.support.option.9" var="option_9"/>
                                        <fmt:message key="user.support.option.10" var="option_10"/>
                                        <fmt:message key="user.support.typeQuestionError" var="typeQuestionError"/>
                                        <fmt:message key="user.support.tooltipDescription" var="tooltipDescription"/>
                                        <fmt:message key="registration.correct" var="correct"/>

                                        <h4>
                                            ${formHeader}
                                        </h4>

                                        <form action="/" role="form" method="POST">
                                            <input type="hidden" name="command" value="support">

                                            <!-- Type Question -->
                                            <input id="typeQuestion" name="typeQuestion" type="hidden"
                                                   value="${typeQuestionValue}"/>

                                            <!-- Select Type Question -->
                                            <div>
                                                <label class="for-form-label">
                                                    ${selectType}
                                                </label>
                                                <div class="bfh-selectbox">
                                                    <c:choose>
                                                        <c:when test="${typeQuestionValue == null}">
                                                            <div data-value=""></div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div data-value="${typeQuestionValue}">${typeQuestionValue}</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div data-value="${option_1}">${option_1}</div>
                                                    <div data-value="${option_2}">${option_2}</div>
                                                    <div data-value="${option_3}">${option_3}</div>
                                                    <div data-value="${option_4}">${option_4}</div>
                                                    <div data-value="${option_5}">${option_5}</div>
                                                    <div data-value="${option_6}">${option_6}</div>
                                                    <div data-value="${option_7}">${option_7}</div>
                                                    <div data-value="${option_8}">${option_8}</div>
                                                    <div data-value="${option_9}">${option_9}</div>
                                                    <div data-value="${option_10}">${option_10}</div>
                                                </div>
                                                <label for="typeQuestion" class="default-label">
                                                    <span id="valid-msg-typeQuestion" class="valid-msg invisible">
                                                            ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-typeQuestion" class="error-msg invisible">
                                                        ${typeQuestionError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Description -->
                                            <div class="textarea-parent"
                                                 data-toggle="tooltip" data-title="${tooltipDescription}">
                                                <label class="for-form-label">
                                                    ${description}
                                                </label>
                                                <div>
                                                    <textarea id="description" name="description"
                                                              class="form-control"
                                                    >${descriptionValue}</textarea>
                                                    <div class="counter">
                                                        <span id="counter"></span>
                                                    </div>
                                                    <label for="description" class="default-label"></label>
                                                </div>
                                            </div>

                                            <!-- Submit -->
                                            <div class="action" style="padding: 35px 0 5px 0">
                                                <button id="submit" type="submit" class="btn btn-primary signup">
                                                    ${send}
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
<script src="resources/js/validator_userSupport.js"></script>
</html>