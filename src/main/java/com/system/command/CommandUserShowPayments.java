package com.system.command;

import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandUserShowPayments implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_PAYMENTS);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Check and set attributes
            if (request.getAttribute("payments") == null) {
                setRequestAttributes(request, currentUser);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_PAYMENTS);
        }

        return pathRedirect;
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

    private void setRequestAttributes(HttpServletRequest request, User currentUser) {
        List<Payment> payments = PaymentService.getInstance().findAllPaymentsByUserId(currentUser.getUserId());
        if (payments != null) {

            // Formatting card numbers
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
