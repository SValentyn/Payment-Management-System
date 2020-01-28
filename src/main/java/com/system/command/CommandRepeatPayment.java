package com.system.command;

import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.persistence.factory.DaoFactory;
import com.system.service.AccountService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandRepeatPayment implements ICommand {

    private static final double PERCENT = 0.01;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String paymentId = request.getParameter("paymentId");
        User user = (User) request.getSession().getAttribute("currentUser");
        Payment payment = null;
        Integer accountId = null;
        String number = null;
        BigDecimal sum = null;
        String appointment = null;

        if (paymentId != null) {
            payment = DaoFactory.createPaymentDao().findPaymentByPaymentId(Integer.parseInt(paymentId));
            accountId = payment.getAccountId();
            number = payment.getCardNumber();
            sum = payment.getSum();
            appointment = payment.getAppointment();
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
            request.setAttribute("numberValue", number);
            request.setAttribute("summaValue", sum);
            request.setAttribute("appointmentValue", appointment);
            return ResourceManager.getInstance().getProperty(ResourceManager.MAKE_PAYMENT);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            PaymentService.getInstance().formPayment(accountId, number, sum, PERCENT, appointment);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.HOME);
    }

}
