<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<div class="header">
    <div class="container" style="margin-left: 0px;margin-right: 0px;">
        <div class="row">
            <div class="col-md-12">
                <div class="logo" style="display: flex">
                    <a href="/"><img src="resources/images/logo-white.png" alt="Logotype"/></a>
                    <h1>Payment Management System</h1>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-2" style="margin-left: 300px;">
        <div class="navbar navbar-inverse" role="banner">
            <nav class="collapse navbar-collapse bs-navbar-collapse navbar-right" role="navigation">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            ${currentUser.surname} ${currentUser.name}
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu animated fadeInUp" style="width: 140px;">
                            <li>
                                <a href="?command=logout" style="display: inline-flex;">
                                    <p style="margin-bottom: 0px; margin-right: 60px;"><fmt:message key="header.logout"/></p>
                                    <img src="resources/images/exit-icon.png"
                                         alt="<fmt:message key="header.logout"/>"
                                         title="<fmt:message key="header.logout"/>"
                                         style="height: 20px; width: 20px; opacity: 0.6; ">
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
