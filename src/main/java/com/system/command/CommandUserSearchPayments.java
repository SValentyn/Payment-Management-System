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

public class CommandUserSearchPayments implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_PAYMENTS);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");
            String isIncoming = request.getParameter("isIncoming");
            String isOutgoing = request.getParameter("isOutgoing");
            String startDate = request.getParameter("start-date");
            String finalDate = request.getParameter("final-date");

            // Validation
            if (!validation(request, user, isIncoming, isOutgoing, startDate, finalDate)) {
                return pathRedirect;
            }

            List<Payment> payments = null;

            // Action (search payments)
            if (isIncoming.equals("0") && isOutgoing.equals("0")) {
                payments = PaymentService.getInstance().searchByCriteria(user.getUserId(), startDate, finalDate);
            }

            if (isIncoming.equals("1") && isOutgoing.equals("1")) {
                payments = PaymentService.getInstance().searchByCriteria(user.getUserId(), startDate, finalDate);
            }

            if (isIncoming.equals("1") && isOutgoing.equals("0")) {
                payments = PaymentService.getInstance().searchByCriteria(user.getUserId(), 0, startDate, finalDate);
            }

            if (isIncoming.equals("0") && isOutgoing.equals("1")) {
                payments = PaymentService.getInstance().searchByCriteria(user.getUserId(), 1, startDate, finalDate);
            }

            // Set attributes
            if (payments == null) {
                setSessionAttributes(request, isIncoming, isOutgoing, startDate, finalDate, ServerResponse.SEARCH_PAYMENTS_ERROR);
                return pathRedirect;
            }

            // Set attributes
            if (payments.size() == 0) {
                setSessionAttributes(request, payments, isIncoming, isOutgoing, startDate, finalDate, ServerResponse.SEARCH_PAYMENTS_WARNING);
            } else {
                setSessionAttributes(request, payments, isIncoming, isOutgoing, startDate, finalDate, ServerResponse.SEARCH_PAYMENTS_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String isIncoming, String isOutgoing, String startDate, String finalDate) {

        // Check
        if (user == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

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

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("paymentsEmpty", null);
        request.setAttribute("payments", null);
        request.setAttribute("isIncomingValue", null);
        request.setAttribute("isOutgoingValue", null);
        request.setAttribute("startDateValue", null);
        request.setAttribute("finalDateValue", null);
        request.setAttribute("response", "");
    }

    private void setSessionAttributes(HttpServletRequest request, List<Payment> payments, String isIncoming, String isOutgoing, String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("payments", payments);
        request.getSession().setAttribute("numberOfPayments", String.valueOf(payments.size()));
        request.getSession().setAttribute("isIncoming", isIncoming);
        request.getSession().setAttribute("isOutgoing", isOutgoing);
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String isIncoming, String isOutgoing, String startDate, String finalDate, ServerResponse serverResponse) {
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
