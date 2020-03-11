<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>

<div class="footer">
    <div class="container-fluid">
        <div class="social">
            <a href="https://github.com/SValentyn/Payment-Management-System" onfocus="this.blur()">
                <img id="github-ico" data-toggle="tooltip-top"
                     src="resources/images/GitHub-Mark-32px-white.ico"
                     title="<fmt:message key="footer.github"/>"
                     alt="<fmt:message key="footer.github"/>">
            </a>
        </div>
        <span class="copyright">
            &copy; 2020 Payment Management System.<br/>
            <fmt:message key="footer.copyright"/>
        </span>
        <div class="time">
            <h3 id="currentDateTime" class="custom-date" data-toggle="tooltip-top"
                title="<fmt:message key="footer.time"/>">
            </h3>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="resources/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/bootstrap/js/bootstrap-formhelpers.min.js"></script>
<script src="resources/js/intlTelInput.js"></script>
<script src="resources/js/utils.js"></script>
<script src="resources/js/visibility.js"></script>
<script src="resources/js/input.js"></script>
<script src="resources/js/alert.js"></script>
<script src="resources/js/tooltip.js"></script>
<script src="resources/js/counter.js"></script>
<script src="resources/js/dynamicDateTime.js"></script>