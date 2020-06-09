package com.system.command;

import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.PaymentService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminSearchUserPayments implements ICommand {

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_PAYMENTS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER_PAYMENTS);

            // Form Data
            String userIdParam = request.getParameter("userId");
            String isIncoming = request.getParameter("isIncoming");
            String isOutgoing = request.getParameter("isOutgoing");
            String startDate = request.getParameter("start-date");
            String finalDate = request.getParameter("final-date");

            // Validation
            if (!validation(request, userIdParam, isIncoming, isOutgoing, startDate, finalDate)) {
                return pathRedirect;
            }

            Integer userId = Integer.valueOf(userIdParam);
            List<Payment> payments = null;

            // Action (search payments)
            if (isIncoming.equals("0") && isOutgoing.equals("0")) {
                payments = PaymentService.getInstance().searchByCriteria(userId, startDate, finalDate);
            }

            if (isIncoming.equals("1") && isOutgoing.equals("1")) {
                payments = PaymentService.getInstance().searchByCriteria(userId, startDate, finalDate);
            }

            if (isIncoming.equals("1") && isOutgoing.equals("0")) {
                payments = PaymentService.getInstance().searchByCriteria(userId, 0, startDate, finalDate);
            }

            if (isIncoming.equals("0") && isOutgoing.equals("1")) {
                payments = PaymentService.getInstance().searchByCriteria(userId, 1, startDate, finalDate);
            }

            // Check and set attributes
            if (payments == null) {
                setSessionAttributes(request, isIncoming, isOutgoing, startDate, finalDate, ServerResponse.SEARCH_PAYMENTS_ERROR);
            } else {
                if (payments.isEmpty()) {
                    setSessionAttributes(request, payments, isIncoming, isOutgoing, startDate, finalDate, ServerResponse.SEARCH_PAYMENTS_WARNING);
                } else {
                    setSessionAttributes(request, payments, isIncoming, isOutgoing, startDate, finalDate, ServerResponse.SEARCH_PAYMENTS_SUCCESS);
                }
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String isIncoming, String isOutgoing, String startDate, String finalDate) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation isIncoming
        if (!isIncoming.equals("0") && !isIncoming.equals("1")) {
            setSessionAttributes(request, ServerResponse.SEARCH_PAYMENTS_ERROR);
            return false;
        }

        // Validation isOutgoing
        if (!isOutgoing.equals("0") && !isOutgoing.equals("1")) {
            setSessionAttributes(request, ServerResponse.SEARCH_PAYMENTS_ERROR);
            return false;
        }

        // Validation start and final dates
        if (!startDate.equals("") && !finalDate.equals("")) {
            if (!Validator.checkDateRange(startDate, finalDate)) {
                setSessionAttributes(request, isIncoming, isOutgoing, ServerResponse.SEARCH_PAYMENTS_ERROR);
                return false;
            }
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, List<Payment> payments, String isIncoming, String isOutgoing,
                                      String startDate, String finalDate, ServerResponse serverResponse) {

        // Formatting card numbers
        for (Payment payment : payments) {
            if (payment.getSenderNumber().length() == 16) {
                payment.setSenderNumber(payment.getSenderNumber().replaceAll("(.{4})", "$1 "));
            }
            if (payment.getRecipientNumber().length() == 16) {
                payment.setRecipientNumber(payment.getRecipientNumber().replaceAll("(.{4})", "$1 "));
            }
        }

        request.getSession().setAttribute("payments", payments);
        request.getSession().setAttribute("numberOfPayments", String.valueOf(payments.size()));
        request.getSession().setAttribute("isIncoming", isIncoming);
        request.getSession().setAttribute("isOutgoing", isOutgoing);
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String isIncoming, String isOutgoing,
                                      String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("isIncoming", isIncoming);
        request.getSession().setAttribute("isOutgoing", isOutgoing);
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String isIncoming, String isOutgoing, ServerResponse serverResponse) {
        request.getSession().setAttribute("isIncoming", isIncoming);
        request.getSession().setAttribute("isOutgoing", isOutgoing);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
