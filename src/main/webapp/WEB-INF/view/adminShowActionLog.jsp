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
    <title><fmt:message key="user.log.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css"/>
    <script type="text/javascript" src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js"></script>
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowActionLog.css">
</head>
<body>

<!-- Modal window  -->
<div id="smallModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.log.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="user.log.modalBody"/>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" data-dismiss="modal">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="clearActionLog"/>
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur();">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert unableGetData and showActionLogError -->
    <c:if test="${response eq 'unableGetData' || response eq 'showActionLogError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="user.page.alertUnableGetData"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert Success -->
    <c:if test="${response eq 'clearActionLogSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="user.page.alertClearActionLogSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert clearActionLogError -->
    <c:if test="${response eq 'clearActionLogError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="user.page.alertClearActionLogError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchLogEntriesSuccess -->
    <c:if test="${response eq 'searchLogEntriesSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p>
                <fmt:message key="user.page.alertSearchLogEntriesSuccess"/>
                    ${numberOfLogEntries}
                <fmt:message key="user.log.logEntries"/>.
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchLogEntriesWarning -->
    <c:if test="${response eq 'searchLogEntriesWarning'}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p>
                <fmt:message key="user.page.alertSearchLogEntriesWarning"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchLogEntriesError -->
    <c:if test="${response eq 'searchLogEntriesError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertSearchLogEntriesError"/>
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
                <fmt:message key="user.log.actionLog" var="formHeader"/>
                <fmt:message key="user.log.date" var="date"/>
                <fmt:message key="user.log.action" var="action"/>
                <fmt:message key="admin.support.tooltipStartDate" var="startDate"/>
                <fmt:message key="admin.support.tooltipFinalDate" var="finalDate"/>
                <fmt:message key="user.log.wantClearActionLog" var="wantClearActionLog"/>
                <fmt:message key="user.log.clear" var="clear"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <div class="card-body card-body-main">

                                            <h4>
                                                ${formHeader}
                                            </h4>

                                            <c:if test="${response ne 'unableGetData' &&
                                                          responce ne 'showActionLogError'}">

                                                <div class="row">
                                                    <div class="col-lg-3 col-xl-3">
                                                        <div class="search-block">
                                                            <label>
                                                                    ${searchCriteria}:
                                                            </label>
                                                            <form action="/" method="POST" role="form">
                                                                <input type="hidden" name="command"
                                                                       value="searchLogEntries"/>

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

                                                                <div class="action" style="padding: 8px 0 12px 0;">
                                                                    <button id="search" type="submit"
                                                                            class="btn btn-primary signup">
                                                                            ${searchButton}
                                                                    </button>
                                                                </div>
                                                            </form>

                                                            <div class="block-questions" style="margin-top: 0;">
                                                                <p style="margin-bottom: 0; line-height: 1.35;">
                                                                        ${wantClearActionLog}
                                                                    <a href="#smallModal"
                                                                       onclick="showModal();"
                                                                       onfocus="this.blur();">
                                                                            ${clear}
                                                                    </a>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-9 col-xl-9" style="padding: 0;">
                                                        <div class="table-responsive">
                                                            <table class="table table-sm table-hover">
                                                                <thead class="thead-light">
                                                                <tr>
                                                                    <th scope="col">${date}</th>
                                                                    <th scope="col">${action}</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <c:forEach items="${logEntries}" var="logEntry">
                                                                    <tr>
                                                                        <th nowrap scope="row">${logEntry.date}</th>
                                                                        <td>${logEntry.description}</td>
                                                                    </tr>
                                                                </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
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
<script src="resources/js/searcher_adminShowActionLog.js"></script>
<script src="resources/js/modalWindow_adminShowActionLog.js"></script>
</html>