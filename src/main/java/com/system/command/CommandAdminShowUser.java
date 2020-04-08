package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.PaymentService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminShowUser implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        // if the POST method is received
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER);
        }

        // Data
        String userIdParam = request.getParameter("userId");

        // Validation
        if (!Validator.checkUserId(userIdParam)) {
            request.setAttribute("response", ServerResponse.SHOW_USER_ERROR.getResponse());
            return pathRedirect;
        }

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        User user = UserService.getInstance().findUserById(userId);

        // Check and Set attributes
        if (user.getRole().getId() == 1) {
            setRequestAttributes(request, userId, user, false);
        } else if (user.getRole().getId() == 2) {
            setRequestAttributes(request, userId, user, true);
        } else {
            request.setAttribute("response", ServerResponse.SHOW_USER_ERROR.getResponse());
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("userId", null);
        request.setAttribute("viewableUser", null);
        request.setAttribute("userIsAdmin", null);
        request.setAttribute("paymentsEmpty", null);
        request.setAttribute("accountsEmpty", null);
        request.setAttribute("payments", null);
        request.setAttribute("accounts", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId, User user, Boolean userIsAdmin) throws SQLException {
        request.setAttribute("userId", userId);
        request.setAttribute("viewableUser", user);
        request.setAttribute("userIsAdmin", userIsAdmin);
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findLastPaymentsByUserId(userId).isEmpty());
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(userId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findLastPaymentsByUserId(userId));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(userId));
    }

}
