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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminShowPaymentInfo implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_PAYMENT_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_PAYMENT_INFO);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_PAYMENT_INFO);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String userIdParam = request.getParameter("userId");
            String paymentIdParam = request.getParameter("paymentId");

            // Validation
            if (!validation(request, currentUser, userIdParam, paymentIdParam)) {
                return pathRedirect;
            }

            // Data
            Payment payment = PaymentService.getInstance().findPaymentByPaymentId(Integer.valueOf(paymentIdParam));
            Account senderAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getSenderNumber());
            User senderUser = UserService.getInstance().findUserById(senderAccount.getUserId());

            // Check
            if (senderUser == null) {
                setRequestAttributes(request, ServerResponse.SHOW_PAYMENT_ERROR);
                return pathRedirect;
            }

            // Set attributes
            if (payment.getRecipientNumber().length() == 20) {
                Account recipientAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getRecipientNumber());
                User recipientUser = UserService.getInstance().findUserById(recipientAccount.getUserId());
                setRequestAttributes(request, payment, senderUser, recipientUser, true);
            } else {
                // [Obtaining cardholder data]
                setRequestAttributes(request, payment, senderUser, null, false);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String userIdParam, String paymentIdParam) throws SQLException {

        // Check
        if (currentUser == null) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation userId
        if (!Validator.checkUserId(userIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        } else {
            request.setAttribute("userId", userIdParam);
        }

        // Validation paymentId
        if (!Validator.checkPaymentId(paymentIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_PAYMENT_ID);
            return false;
        }

        // Data
        List<Payment> paymentsByUserId = PaymentService.getInstance().findAllPaymentsByUserId(Integer.valueOf(userIdParam));
        List<Integer> paymentIds = new ArrayList<>();
        for (Payment aPayment : paymentsByUserId) {
            paymentIds.add(aPayment.getPaymentId());
        }

        // Checking that the payment belongs to the user
        if (!paymentIds.contains(Integer.valueOf(paymentIdParam))) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_PAYMENT_BY_USER_ID);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("userId", null);
        request.setAttribute("payment", null);
        request.setAttribute("senderUser", null);
        request.setAttribute("recipientUser", null);
        request.setAttribute("recipientIsAccount", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, Payment payment, User senderUser, User recipientUser, boolean recipientIsAccount) {

        // formatting card numbers
        if (payment.getSenderNumber().length() == 16) {
            payment.setSenderNumber(payment.getSenderNumber().replaceAll("(.{4})", "$1 "));
        }

        if (payment.getRecipientNumber().length() == 16) {
            payment.setRecipientNumber(payment.getRecipientNumber().replaceAll("(.{4})", "$1 "));
        }

        request.setAttribute("payment", payment);
        request.setAttribute("senderUser", senderUser);
        request.setAttribute("recipientUser", recipientUser);
        request.setAttribute("recipientIsAccount", recipientIsAccount);
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
