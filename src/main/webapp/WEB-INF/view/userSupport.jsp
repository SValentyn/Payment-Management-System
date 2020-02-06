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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${sended == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 592px;">
            <p><strong>Success!</strong> The letter was accepted for consideration. We will contact you.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert manyMessagesError -->
    <c:if test="${manyMessagesError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 485px;">
            <p><strong>Failed!</strong> You have sent too many messages (more than 4).</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert sendLetterError -->
    <c:if test="${sendLetterError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 472px;">
            <p><strong>Failed!</strong> Unable to send a message to Support. Try later.</p>
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
                        <div class="login-wrapper" style="top: 70px;">
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
                                    <fmt:message key="user.support.tooltipDescription" var="tooltipDescription"/>

                                    <h4>
                                        ${formHeader}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="support">

                                        <!-- Type Question -->
                                        <select name="typeQuestion" class="form-control"
                                                style="height: 42px; margin-bottom: 2px; font-size: 15px;">
                                            <c:choose>
                                                <c:when test="${typeQuestion == null}">
                                                    <option value="${0}">
                                                            ${selectType}
                                                    </option>
                                                </c:when>
                                                <c:when test="${typeQuestion == 0}">
                                                    <option value="${0}">
                                                            ${selectType}
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${typeQuestion}">
                                                            ${typeQuestion}
                                                    </option>
                                                </c:otherwise>
                                            </c:choose>

                                            <option value="${option_1}">${option_1}</option>
                                            <option value="${option_2}">${option_2}</option>
                                            <option value="${option_3}">${option_3}</option>
                                            <option value="${option_4}">${option_4}</option>
                                            <option value="${option_5}">${option_5}</option>
                                            <option value="${option_6}">${option_6}</option>
                                            <option value="${option_7}">${option_7}</option>
                                            <option value="${option_8}">${option_8}</option>
                                            <option value="${option_9}">${option_9}</option>
                                            <option value="${option_10}">${option_10}</option>
                                        </select>
                                        <label class="create-error-label">
                                            <c:if test="${typeQuestionError}">
                                                <fmt:message key="user.support.typeQuestionError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Description -->
                                        <div style="width: 100%; height:105px; position: relative;">
                                            <label for="description" class="label-for-form">
                                                ${description}
                                            </label>
                                            <div style="width: 100%; position: absolute; ">
                                                <textarea id="description" name="description" class="form-control"
                                                          style="height: 75px; resize: none; outline: none; overflow-x: hidden;"
                                                          data-toggle="tooltip" data-title="${tooltipDescription}"
                                                >${descriptionValue}</textarea>
                                            </div>
                                            <div class="counter">
                                                <span id="counter"></span>
                                            </div>
                                        </div>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 22px 0 5px 0">
                                            <button type="submit" class="btn btn-primary signup" onfocus="this.blur()">
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>