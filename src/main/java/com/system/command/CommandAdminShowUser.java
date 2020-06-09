package com.system.command;

import com.system.entity.Account;
import com.system.entity.Payment;
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
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // URL Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!validation(request, userIdParam)) {
                return pathRedirect;
            }

            // Data
            User user = UserService.getInstance().findUserById(Integer.valueOf(userIdParam));

            // Check and set attributes
            if (user.getRole().getRoleId() == 1) {
                setRequestAttributes(request, user, false);
            } else if (user.getRole().getRoleId() == 2) {
                setRequestAttributes(request, user, true);
            } else {
                setRequestAttributes(request, ServerResponse.SHOW_USER_ERROR);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
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

    private void setRequestAttributes(HttpServletRequest request, User user, Boolean userIsAdmin) {
        Integer userId = user.getUserId();
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);
        List<Payment> payments = PaymentService.getInstance().findLastPaymentsByUserId(userId);

        if (accounts != null && payments != null) {

            // formatting card numbers
            for (Payment payment : payments) {
                if (payment.getSenderNumber().length() == 16) {
                    payment.setSenderNumber(payment.getSenderNumber().replaceAll("(.{4})", "$1 "));
                }
                if (payment.getRecipientNumber().length() == 16) {
                    payment.setRecipientNumber(payment.getRecipientNumber().replaceAll("(.{4})", "$1 "));
                }
            }

            request.setAttribute("userId", userId);
            request.setAttribute("viewableUser", user);
            request.setAttribute("userIsAdmin", userIsAdmin);
            request.setAttribute("accountsEmpty", accounts.isEmpty());
            request.setAttribute("accounts", accounts);
            request.setAttribute("paymentsEmpty", payments.isEmpty());
            request.setAttribute("payments", payments);
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_USER_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
