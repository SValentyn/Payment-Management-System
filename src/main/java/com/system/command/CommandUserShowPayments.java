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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandUserShowPayments implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_PAYMENTS);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check
            if (user == null) {
                setRequestAttributes(request, ServerResponse.UNABLE_GET_USER);
                return pathRedirect;
            }

            // Set Attributes
            setRequestAttributes(request, user);
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("paymentsEmpty", null);
        request.setAttribute("payments", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, User user) throws SQLException {
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByUserId(user.getUserId());

        if (payments != null) {
            if (payments.isEmpty()) {
                request.setAttribute("paymentsEmpty", true);
            } else {
                request.setAttribute("paymentsEmpty", false);
                request.setAttribute("payments", payments);
            }
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_USER_PAYMENTS_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
