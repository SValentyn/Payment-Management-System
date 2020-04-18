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
            String userIdParam = request.getParameter("userId");
            String paymentIdParam = request.getParameter("paymentId");

            // Validation
            if (!Validator.checkUserId(userIdParam)) {
                request.setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
                return pathRedirect;
            }

            // Validation
            if (!Validator.checkPaymentId(paymentIdParam)) {
                request.setAttribute("response", ServerResponse.UNABLE_GET_PAYMENT_ID.getResponse());
                return pathRedirect;
            }

            // Data
            Integer userId = Integer.valueOf(userIdParam);
            Integer paymentId = Integer.valueOf(paymentIdParam);

            // Data
            List<Payment> paymentsByUserId = PaymentService.getInstance().findAllPaymentsByUserId(userId);
            List<Integer> paymentIds = new ArrayList<>();
            for (Payment aPayment : paymentsByUserId) {
                paymentIds.add(aPayment.getPaymentId());
            }

            // Check
            if (!paymentIds.contains(paymentId)) {
                request.setAttribute("response", ServerResponse.SHOW_PAYMENT_ERROR.getResponse());
                return pathRedirect;
            }

            // Data
            Payment payment = PaymentService.getInstance().findPaymentByPaymentId(Integer.valueOf(paymentIdParam));
            Account senderAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getSenderNumber());
            User senderUser = UserService.getInstance().findUserById(senderAccount.getUserId());

            // Check
            if (senderUser == null) {
                request.setAttribute("response", ServerResponse.SHOW_PAYMENT_ERROR.getResponse());
                return pathRedirect;
            }

            // Set Attributes
            if (payment.getRecipientNumber().length() == 20) {
                Account recipientAccount = AccountService.getInstance().findAccountByAccountNumber(payment.getRecipientNumber());
                User recipientUser = UserService.getInstance().findUserById(recipientAccount.getUserId());
                setRequestAttributes(request, userId, payment, senderUser, recipientUser, true);
            } else {
                // [Obtaining cardholder data]
                setRequestAttributes(request, userId, payment, senderUser, null, false);
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("userId", null);
        request.setAttribute("payment", null);
        request.setAttribute("senderUser", null);
        request.setAttribute("recipientUser", null);
        request.setAttribute("recipientIsAccount", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId, Payment payment, User senderUser, User recipientUser, boolean recipientIsAccount) {
        request.setAttribute("userId", userId);
        request.setAttribute("payment", payment);
        request.setAttribute("senderUser", senderUser);
        request.setAttribute("recipientUser", recipientUser);
        request.setAttribute("recipientIsAccount", recipientIsAccount);
    }

}
