<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>

<div class="header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="logo">
                    <a href="/" onfocus="this.blur()"><img src="resources/images/logo-white.png" alt="Logotype"/></a>
                    <h1>Payment Management System</h1>
                    <div class="col-md-2">
                        <div class="navbar navbar-inverse" role="banner">
                            <nav class="collapse navbar-collapse bs-navbar-collapse navbar-right" role="navigation">
                                <ul class="nav navbar-nav">
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                            ${currentUser.name} ${currentUser.surname}
                                            <b class="caret"></b>
                                        </a>
                                        <ul class="dropdown-menu animated fadeInUp" style="width: 140px;">
                                            <li style="height: 40px; ">
                                                <div>
                                                    <a href="?command=logout">
                                                        <div style="float: left;">
                                                            <p style="margin: 0;">
                                                                <fmt:message key="header.logout"/>
                                                            </p>
                                                        </div>
                                                        <div style="float: right;">
                                                            <img src="resources/images/exit-icon.png"
                                                                 alt="<fmt:message key="header.logout"/>"
                                                                 title="<fmt:message key="header.logout"/>"
                                                                 class="img-logout">
                                                        </div>
                                                    </a>
                                                </div>
                                            </li>
                                            <li style="height: 40px; padding-top: 10px;">
                                                <div>
                                                    <a href="?command=profile">
                                                        <div style="float: left;">
                                                            <p style="margin: 0;">
                                                                <fmt:message key="header.profile"/>
                                                            </p>
                                                        </div>
                                                        <div style="float: right;">
                                                            <i class="glyphicon glyphicon-user"
                                                               style="font-size: larger;"></i>
                                                        </div>
                                                    </a>
                                                </div>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <form class="language-form">
                        <select id="language" name="language" onchange="submit()" onfocus="this.blur()">
                            <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
                            <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
                            <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
                        </select>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
