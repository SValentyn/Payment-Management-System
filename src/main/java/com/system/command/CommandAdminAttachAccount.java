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

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
                request.setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
                return pathRedirect;
            }

            // Data
            User user = UserService.getInstance().findUserById(Integer.parseInt(userIdParam));

            // Set Attributes
            setRequestAttributes(request, user);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_ATTACH_ACCOUNT);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
                return pathRedirect;
            }

            pathRedirect += "&userId=" + userIdParam;

            // Data
            Integer userId = Integer.parseInt(userIdParam);
            String number = request.getParameter("number");
            String currency = request.getParameter("currency");

            // Validation
            if (!Validator.checkAccountNumber(number)) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_ERROR.getResponse());
                return pathRedirect;
            }

            // Validation
            if (!Validator.checkCurrency(currency)) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_ERROR.getResponse());
                return pathRedirect;
            }

            // Check
            // Condition: the user cannot have more than 3 accounts with a certain currency
            int count = 0;
            for (Account account : AccountService.getInstance().findAllAccountsByUserId(userId)) {
                if (account.getCurrency().equals(currency)) count++;
            }

            if (count == 3) {
                request.getSession().setAttribute("response", ServerResponse.MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR.getResponse());
                return pathRedirect;
            }

            // Action
            int status = AccountService.getInstance().createAccount(userId, number, currency);
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_ERROR.getResponse());
            } else {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_ATTACHED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("bioValue", null);
        request.setAttribute("numberValue", null);
        request.setAttribute("currencyValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("bioValue", user.getName() + " " + user.getSurname());

        HttpSession session = request.getSession();
        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

}
