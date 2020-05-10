package com.system.command;

import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.PaymentService;

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

            // Check and set attributes
            if (user != null) {
                setRequestAttributes(request, user);
            } else {
                setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            }
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

            // formatting card numbers
            for (Payment payment : payments) {
                if (payment.getSenderNumber().length() == 16) {
                    payment.setSenderNumber(payment.getSenderNumber().replaceAll("(.{4})", "$1 "));
                }
                if (payment.getRecipientNumber().length() == 16) {
                    payment.setRecipientNumber(payment.getRecipientNumber().replaceAll("(.{4})", "$1 "));
                }
            }

            request.setAttribute("paymentsEmpty", payments.isEmpty());
            request.setAttribute("payments", payments);
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_USER_PAYMENTS_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
