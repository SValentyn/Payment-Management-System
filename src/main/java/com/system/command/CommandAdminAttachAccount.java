package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandAdminAttachAccount implements ICommand {

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_ATTACH_ACCOUNT);

            // Form Data
            String userIdParam = request.getParameter("userId");
            String number = request.getParameter("number");
            String currency = request.getParameter("currency");

            // Validation
            if (!validation(request, userIdParam, number, currency)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to attach a new account to the user");
                return pathRedirect;
            }

            // Data
            User user = UserService.getInstance().findUserById(Integer.valueOf(userIdParam));

            // Action (create and attach account)
            int status = AccountService.getInstance().addNewAccount(user.getUserId(), number, currency);
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to attach a new account to the user [" + user.getName() + " " + user.getSurname() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_ATTACHED_ERROR);
            } else {
                logging(currentUser.getUserId(), "ATTACHED: Account [" + number + "], User [" + user.getName() + " " + user.getSurname() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_ATTACHED_SUCCESS);
            }
        } else {

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // URL Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!validation(request, userIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, userIdParam);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        }

        return true;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String number, String currency) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation number
        if (!Validator.checkAccountNumber(number)) {
            setSessionAttributes(request, ServerResponse.ACCOUNT_ATTACHED_ERROR);
            return false;
        }

        // Validation currency
        if (!Validator.checkCurrency(currency)) {
            setSessionAttributes(request, ServerResponse.ACCOUNT_ATTACHED_ERROR);
            return false;
        }

        // Data
        int numberOfAccounts = 0;
        for (Account account : AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userIdParam))) {
            if (account.getCurrency().equals(currency)) numberOfAccounts++;
        }

        // Checking that a user cannot have more than 3 accounts with a certain currency
        if (numberOfAccounts >= 3) {
            setSessionAttributes(request, ServerResponse.MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR);
            return false;
        }

        return true;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, String userIdParam) {
        Integer userId = Integer.valueOf(userIdParam);
        User user = UserService.getInstance().findUserById(userId);

        if (user != null) {
            request.setAttribute("userId", userId);
            request.setAttribute("bioValue", user.getName() + " " + user.getSurname());
        } else {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_USER_BY_USER_ID);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
