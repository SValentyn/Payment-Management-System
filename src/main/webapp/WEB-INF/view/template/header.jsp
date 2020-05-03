<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>

<div class="header">
    <div class="container-fluid">
        <div class="row">
            <div class="col-auto mr-auto">
                <div class="logo">
                    <a href="/" onfocus="this.blur();">
                        <img src="resources/images/logo-white.png" alt="Logo"/>
                    </a>
                    <h1>Payment Management System</h1>
                </div>
            </div>
            <div class="col-auto ml-auto">
                <nav class="navbar navbar-expand-lg">
                    <div class="collapse navbar-collapse show" role="navigation">
                        <div class="navbar-nav">
                            <div class="nav-item">
                                <a href="#" id="dropdown" class="nav-link dropdown-toggle" data-toggle="dropdown">
                                    ${currentUser.name} ${currentUser.surname}
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" style="padding: 0;"
                                     aria-labelledby="dropdownMenuLink">
                                    <div class="dropdown-item" style="display: grid;">
                                        <a href="?command=profile">
                                            <div class="float-left">
                                                <p style="margin: 0;">
                                                    <fmt:message key="header.profile"/>
                                                </p>
                                            </div>
                                            <div class="float-right">
                                                <img src="resources/images/profile.png" class="icon-header"
                                                     style="width: 20px;" alt="<fmt:message key="header.profile"/>"/>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="dropdown-divider" style="margin: 0 1.5rem;"></div>
                                    <div class="dropdown-item" style="display: grid;">
                                        <a href="?command=logout">
                                            <div class="float-left">
                                                <p style="margin-bottom: 0.1rem;">
                                                    <fmt:message key="header.logout"/>
                                                </p>
                                            </div>
                                            <div class="float-right">
                                                <img src="resources/images/logout.png" class="icon-header"
                                                     alt="<fmt:message key="header.logout"/>"/>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="col-auto">
                <nav class="navbar navbar-expand-lg">
                    <div class="collapse navbar-collapse show">
                        <div class="navbar-nav">
                            <div class="nav-item">
                                <form class="language-form">
                                    <select id="language" name="language" onchange="submit();" onfocus="this.blur();">
                                        <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
                                        <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
                                        <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
                                    </select>
                                </form>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</div>