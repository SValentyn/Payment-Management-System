package com.system.command;

import com.system.entity.Payment;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.PaymentService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowUserPayments implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_PAYMENTS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER_PAYMENTS);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_PAYMENTS);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!validation(request, userIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            if (request.getAttribute("payments") == null) {
                setRequestAttributes(request, Integer.valueOf(userIdParam));
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
            return false;
        } else {
            request.setAttribute("userId", userIdParam);
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("userId", null);
        request.setAttribute("paymentsEmpty", null);
        request.setAttribute("payments", null);
        request.setAttribute("isIncomingValue", null);
        request.setAttribute("isOutgoingValue", null);
        request.setAttribute("startDateValue", null);
        request.setAttribute("finalDateValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        List<Payment> payments = (List<Payment>) session.getAttribute("payments");
        if (payments != null) {
            request.setAttribute("paymentsEmpty", false);
            request.setAttribute("payments", payments);
            session.removeAttribute("payments");
        }

        String numberOfPayments = (String) session.getAttribute("numberOfPayments");
        if (numberOfPayments != null) {
            request.setAttribute("numberOfPayments", numberOfPayments);
            session.removeAttribute("numberOfPayments");
        }

        String isIncoming = (String) session.getAttribute("isIncoming");
        if (isIncoming != null) {
            request.setAttribute("isIncomingValue", isIncoming);
            session.removeAttribute("isIncoming");
        }

        String isOutgoing = (String) session.getAttribute("isOutgoing");
        if (isOutgoing != null) {
            request.setAttribute("isOutgoingValue", isOutgoing);
            session.removeAttribute("isOutgoing");
        }

        String startDate = (String) session.getAttribute("startDate");
        if (startDate != null) {
            request.setAttribute("startDateValue", startDate);
            session.removeAttribute("startDate");
        }

        String finalDate = (String) session.getAttribute("finalDate");
        if (finalDate != null) {
            request.setAttribute("finalDateValue", finalDate);
            session.removeAttribute("finalDate");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId) throws SQLException {
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByUserId(userId);
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
            request.setAttribute("response", ServerResponse.SHOW_USER_PAYMENTS_ERROR.getResponse());
        }
    }

}
