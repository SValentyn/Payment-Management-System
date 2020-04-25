package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandAdminAttachAccount implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!validation(request, userIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, userIdParam);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_ATTACH_ACCOUNT);

            // Data
            String userIdParam = request.getParameter("userId");
            String number = request.getParameter("number");
            String currency = request.getParameter("currency");

            // Validation
            if (!validation(request, userIdParam, number, currency)) {
                return pathRedirect;
            }

            // Action
            int status = AccountService.getInstance().createAccount(Integer.valueOf(userIdParam), number, currency);
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_ERROR.getResponse());
            } else {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
            return false;
        }

        return true;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String number, String currency) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation number
        if (!Validator.checkAccountNumber(number)) {
            request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_ERROR.getResponse());
            return false;
        }

        // Validation currency
        if (!Validator.checkCurrency(currency)) {
            request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_ERROR.getResponse());
            return false;
        }

        // Checking that a user cannot have more than 3 accounts with a certain currency
        int numberOfAccounts = 0;
        for (Account account : AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userIdParam))) {
            if (account.getCurrency().equals(currency)) numberOfAccounts++;
        }

        if (numberOfAccounts == 3) {
            request.getSession().setAttribute("response", ServerResponse.MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR.getResponse());
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("bioValue", null);
        request.setAttribute("numberValue", null);
        request.setAttribute("currencyValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, String userIdParam) throws SQLException {
        Integer userId = Integer.valueOf(userIdParam);
        User user = UserService.getInstance().findUserById(userId);

        if (user != null) {
            request.setAttribute("userId", userId);
            request.setAttribute("bioValue", user.getName() + " " + user.getSurname());
        } else {
            request.setAttribute("response", ServerResponse.UNABLE_GET_USER_BY_USER_ID.getResponse());
        }
    }

}
