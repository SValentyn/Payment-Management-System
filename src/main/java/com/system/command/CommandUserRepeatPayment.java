package com.system.command;

import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.persistence.factory.DaoFactory;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandUserRepeatPayment implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String paymentId = request.getParameter("paymentId");
        User user = (User) request.getSession().getAttribute("currentUser");

        Payment payment = DaoFactory.createPaymentDao().findPaymentByPaymentId(Integer.parseInt(paymentId));
        String number = payment.getCardNumber();
        BigDecimal amount = payment.getSum();
        String appointment = payment.getAppointment();

        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);

        return ResourceManager.getInstance().getProperty(ResourceManager.MAKE_PAYMENT);
    }

}
