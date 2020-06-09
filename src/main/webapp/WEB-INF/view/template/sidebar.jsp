<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>

<div class="list-group list-group-flush sidebar" role="tablist">
    <c:if test="${currentUser.role.roleId == 1}">
        <a href="/" class="list-group-item list-group-item-action sidebar-header list-group-item-sidebar">
            <div>
                <img src="resources/images/homepage-user.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.home"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 1}">
        <a href="?command=createAccount" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/create-account.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.createAccount"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 1}">
        <a href="?command=attachCard" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/attach-card.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.attachCard"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 1}">
        <a href="?command=makePayment" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/make-payment.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.makePayment"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 1}">
        <a href="?command=support" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/user-support.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.support"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 2}">
        <a href="/" class="list-group-item list-group-item-action sidebar-header list-group-item-sidebar">
            <div>
                <img src="resources/images/homepage-admin.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.home"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 2}">
        <a href="?command=addUser" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/add-user.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.addUser"/>
            </div>
        </a>
    </c:if>
    <c:if test="${currentUser.role.roleId == 2}">
        <a href="?command=support" class="list-group-item list-group-item-action list-group-item-sidebar">
            <div>
                <img src="resources/images/admin-support.png" class="icon-sidebar" alt=""/>
            </div>
            <div>
                <fmt:message key="sidebar.support"/>
                <span class="badge badge-pill badge-light">${totalLetters}</span>
            </div>
        </a>
    </c:if>
</div>