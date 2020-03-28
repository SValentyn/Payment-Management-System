<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>

<div class="list-group list-group-flush sidebar" role="tablist">
    <a href="/" class="list-group-item list-group-item-action sidebar-header list-group-item-sidebar">
        <div>
            <img src="resources/images/homepage.png"
                 alt="" class="sidebar-icon">
        </div>
        <div>
            <fmt:message key="sidebar.home"/>
        </div>
    </a>
    <c:if test="${currentUser.role.id == 1}">
        <a href="?command=createAccount" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/create-account.png"
                     alt="" class="sidebar-icon">
            </div>
            <div>
                <fmt:message key="sidebar.createAccount"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.id == 1}">
        <a href="?command=attachCard" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/attach-card.png"
                     alt="" class="sidebar-icon">
            </div>
            <div>
                <fmt:message key="sidebar.attachCard"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.id == 1}">
        <a href="?command=makePayment" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/make-payment.png"
                     alt="" class="sidebar-icon">
            </div>
            <div>
                <fmt:message key="sidebar.makePayment"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.id == 1}">
        <a href="?command=support" class="list-group-item list-group-item-action list-group-item-sidebar">
            <img src="resources/images/user-support.png"
                 alt="" class="sidebar-icon">
            <fmt:message key="sidebar.support"/>
        </a>
    </c:if>
    <c:if test="${currentUser.role.id == 2}">
        <a href="?command=addUser" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/add-user.png"
                     alt="" class="sidebar-icon">
            </div>
            <div>
                <fmt:message key="sidebar.addUser"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.id == 2}">
        <a href="?command=support" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/admin-support.png"
                     alt="" class="sidebar-icon">
            </div>
            <div>
                <fmt:message key="sidebar.support"/>
                <span class="badge badge-pill badge-light">${numberOfLetters}</span>
            </div>
        </a>
    </c:if>
</div>