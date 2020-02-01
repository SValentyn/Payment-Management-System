package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class CommandUserUnblockCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        request.setAttribute("unblockAccountAlert", false);
        request.setAttribute("unblockCardAlert", true);

        User user = (User) request.getSession().getAttribute("currentUser");

        request.setAttribute("showAccounts", true);
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));

        return ResourceManager.getInstance().getProperty(ResourceManager.HOME);

    }
}
