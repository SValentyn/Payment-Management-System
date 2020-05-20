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
    <title><fmt:message key="admin.support.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css"/>
    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminSupport.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert showLettersError -->
    <c:if test="${response eq 'showLettersError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowLettersError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchLettersSuccess -->
    <c:if test="${response eq 'searchLettersSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchLettersSuccess"/>
                    ${numberOfLetters}
                <fmt:message key="admin.support.letters"/>.
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchLettersWarning -->
    <c:if test="${response eq 'searchLettersWarning'}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchLettersWarning"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchLettersError -->
    <c:if test="${response eq 'searchLettersError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertSearchLettersError"/>
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
                <fmt:message key="admin.support.allLetters" var="formHeader"/>
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
                <fmt:message key="admin.support.tooltipTypeOfQuestion" var="tooltipTypeOfQuestion"/>
                <fmt:message key="admin.support.tooltipStartDate" var="startDate"/>
                <fmt:message key="admin.support.tooltipFinalDate" var="finalDate"/>
                <fmt:message key="admin.support.showInfo" var="showInfo"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <div class="row justify-content-center">
                                            <div class="col-xl-12">

                                                <h4>
                                                    ${formHeader}
                                                </h4>

                                                <c:choose>
                                                    <c:when test="${response ne 'showLettersError' &&
                                                                    lettersEmpty == false}">
                                                        <div class="row">
                                                            <div class="col-lg-3 col-xl-3">
                                                                <div class="search-block">
                                                                    <label>
                                                                            ${searchCriteria}:
                                                                    </label>
                                                                    <form action="/" method="POST" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="searchLetters"/>

                                                                        <!-- Type Question -->
                                                                        <input type="hidden" id="typeQuestion"
                                                                               name="typeQuestion"
                                                                               value="${typeQuestionValue}"/>

                                                                        <!-- Select Type Question -->
                                                                        <div>
                                                                            <div class="bfh-selectbox"
                                                                                 data-toggle="tooltip-left"
                                                                                 data-title="${tooltipTypeOfQuestion}">
                                                                                <div data-value=""></div>
                                                                                <div data-value="1">${option_1}</div>
                                                                                <div data-value="2">${option_2}</div>
                                                                                <div data-value="3">${option_3}</div>
                                                                                <div data-value="4">${option_4}</div>
                                                                                <div data-value="5">${option_5}</div>
                                                                                <div data-value="6">${option_6}</div>
                                                                                <div data-value="7">${option_7}</div>
                                                                                <div data-value="8">${option_8}</div>
                                                                                <div data-value="9">${option_9}</div>
                                                                                <div data-value="10">${option_10}</div>
                                                                            </div>
                                                                            <label for="typeQuestion"
                                                                                   class="default-label">&nbsp;</label>
                                                                        </div>

                                                                        <!-- Min value Date -->
                                                                        <input id="datepicker-start-date"
                                                                               name="start-date"
                                                                               data-toggle="tooltip-left"
                                                                               data-title="${startDate}"
                                                                               readonly="readonly"
                                                                               value="${startDateValue}"/>
                                                                        <label for="datepicker-start-date"
                                                                               class="default-label">&nbsp;</label>

                                                                        <!-- Max value Date -->
                                                                        <input id="datepicker-final-date"
                                                                               name="final-date"
                                                                               data-toggle="tooltip-left"
                                                                               data-title="${finalDate}"
                                                                               readonly="readonly"
                                                                               value="${finalDateValue}"/>
                                                                        <label for="datepicker-final-date"
                                                                               class="default-label">&nbsp;</label>

                                                                        <script>
                                                                            let today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
                                                                            $('#datepicker-start-date').datepicker({
                                                                                format: 'dd/mm/yyyy',
                                                                                minDate: '01/01/2020',
                                                                                maxDate: today,
                                                                                showRightIcon: true,
                                                                                uiLibrary: 'bootstrap4'
                                                                            });

                                                                            $('#datepicker-final-date').datepicker({
                                                                                format: 'dd/mm/yyyy',
                                                                                minDate: '01/01/2020',
                                                                                maxDate: today,
                                                                                showRightIcon: true,
                                                                                uiLibrary: 'bootstrap4'
                                                                            });
                                                                        </script>

                                                                        <div class="action"
                                                                             style="padding: 10px 0 0 0;">
                                                                            <button id="search" type="submit"
                                                                                    class="btn btn-primary signup">
                                                                                    ${searchButton}
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-9 col-xl-9" style="padding: 0 0 0 15px;">
                                                                <div class="col-xl-12">
                                                                    <div class="card-container">
                                                                        <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1 row-cols-xl-1">
                                                                            <c:forEach items="${letters}" var="letter">
                                                                                <div class="col mb-4">
                                                                                    <a href="?command=showLetterInfo&letterId=${letter.letterId}">
                                                                                        <div class="card bg-light">
                                                                                            <div class="card-body"
                                                                                                 style="padding: 0.75rem 1.25rem;">
                                                                                                <p class="card-title text-muted">
                                                                                                    <span>
                                                                                                        #${letter.letterId}
                                                                                                    </span>
                                                                                                    <span style="padding-left: 28px;">
                                                                                                            ${letter.date}
                                                                                                    </span>
                                                                                                    <span class="type-question">
                                                                                                        <c:choose>
                                                                                                            <c:when test="${letter.typeQuestion == 1}">
                                                                                                                ${option_1}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 2}">
                                                                                                                ${option_2}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 3}">
                                                                                                                ${option_3}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 4}">
                                                                                                                ${option_4}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 5}">
                                                                                                                ${option_5}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 6}">
                                                                                                                ${option_6}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 7}">
                                                                                                                ${option_7}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 8}">
                                                                                                                ${option_8}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 9}">
                                                                                                                ${option_9}
                                                                                                            </c:when>
                                                                                                            <c:when test="${letter.typeQuestion == 10}">
                                                                                                                ${option_10}
                                                                                                            </c:when>
                                                                                                        </c:choose>
                                                                                                    </span>
                                                                                                    <span class="float-right"
                                                                                                          style="padding-left: 28px;">
                                                                                                        <img src="resources/images/forward.png"
                                                                                                             alt=""/>
                                                                                                    </span>
                                                                                                </p>
                                                                                            </div>
                                                                                        </div>
                                                                                    </a>
                                                                                </div>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="message-block">
                                                            <span class="title-label">
                                                                <label>
                                                                    <fmt:message key="admin.support.noLetters"/>
                                                                </label>
                                                            </span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
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
<script src="resources/js/searcher_adminSupport.js"></script>
</html>
