package com.system.command;

import com.system.entity.Account;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminDeleteUser implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!Validator.checkUserId(userIdParam)) {
                return pathRedirect;
            }

            // Validation
            if (!Validator.checkUserIsAdmin(userIdParam)) {
                request.getSession().setAttribute("response", ServerResponse.USER_DELETED_ERROR.getResponse());
                return pathRedirect;
            }

            pathRedirect += "&userId=" + userIdParam;

            // Set Attributes
            Integer userId = Integer.parseInt(userIdParam);

            // Data
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);
            for (Account account : accounts) {
                BigDecimal balance = account.getBalance();
                if (balance.compareTo(BigDecimal.ZERO) != 0) {
                    request.getSession().setAttribute("response", ServerResponse.USER_HAS_FUNDS_ERROR.getResponse());
                    return pathRedirect;
                }
            }

            // Action
            int status = UserService.getInstance().deleteUserById(userId);
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.USER_DELETED_ERROR.getResponse());
            } else {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
                request.getSession().setAttribute("response", ServerResponse.USER_DELETED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

}
