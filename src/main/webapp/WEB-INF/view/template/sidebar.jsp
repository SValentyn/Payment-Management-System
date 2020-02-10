<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>

<div class="sidebar content-box" style="display: block;">
    <ul class="nav">
        <li class="current">
            <a href="/"><i class="glyphicon glyphicon-home"></i>
                <fmt:message key="sidebar.home"/>
            </a>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 1}">
                <a href="?command=showAccounts">
                    <fmt:message key="sidebar.showAccounts"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 1}">
                <a href="?command=createAccount">
                    <fmt:message key="sidebar.createAccount"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 1}">
                <a href="?command=makePayment">
                    <fmt:message key="sidebar.makePayment"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 1}">
                <a href="?command=attachCard">
                    <fmt:message key="sidebar.attachCard"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 1}">
                <a href="?command=support">
                    <fmt:message key="sidebar.support"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 2}">
                <a href="?command=showUsers">
                    <fmt:message key="sidebar.showAllUsers"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 2}">
                <a href="?command=addUser">
                    <fmt:message key="sidebar.addUser"/>
                </a>
            </c:if>
        </li>
        <li>
            <c:if test="${currentUser.role.id == 2}">
                <a href="?command=support">
                    <fmt:message key="sidebar.support"/>
                </a>
            </c:if>
        </li>
    </ul>
</div>