package com.system.controller;

import com.system.command.*;
import com.system.entity.User;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.HashMap;

public class ControllerHelper {

    /**
     * Users roles
     */
    private static final String UNKNOWN = "unknown";
    private static final String ADMIN = "admin";
    private static final String CLIENT = "client";

    /**
     * Request parameter name for command
     */
    private static final String COMMAND = "command";
    private static ControllerHelper instance = null;
    /**
     * Action commands for user types
     */
    HashMap<String, ICommand> commands = new HashMap<>();
    HashMap<String, ICommand> adminCommands = new HashMap<>();
    HashMap<String, ICommand> userCommands = new HashMap<>();

    private ControllerHelper() {

        // Commands for the Unknown
        commands.put("/", new CommandIndex());
        commands.put("login", new CommandLogin());
        commands.put("registration", new CommandRegistration());

        // Admin commands
        adminCommands.put("logout", new CommandLogout());
        adminCommands.put("adduser", new CommandAddUser());
        adminCommands.put("addCard", new CommandAddCard());
        adminCommands.put("addAccount", new CommandAddAccount());
        adminCommands.put("unblockCard", new CommandUnblockCreditCard());
        adminCommands.put("showcards", new CommandShowUserCards());
        adminCommands.put("showAllUsers", new CommandShowAllUsers());
        adminCommands.put("showuserinfo", new CommandShowUserInfo());
        adminCommands.put("unblock", new CommandUnblockAccount());
        adminCommands.put("deleteCard", new CommandDeleteCard());
        adminCommands.put("add-funds", new CommandAddFunds());

        // Client commands
        userCommands.put("logout", new CommandLogout());
        userCommands.put("blockaccount", new CommandBlockAccount());
        userCommands.put("showinfo", new CommandShowAccountInfo());
        userCommands.put("create-payment", new CommandCreatePayment());
        userCommands.put("showAccounts", new CommandShowAccounts());
        userCommands.put("repeatPayment", new CommandRepeatPayment());
        userCommands.put("blockCard", new CommandBlockCreditCard());
    }

    public static ControllerHelper getInstance() {
        if (instance == null) {
            instance = new ControllerHelper();
        }
        return instance;
    }

    /**
     * Find command from request
     */
    public ICommand getCommand(HttpServletRequest request) throws SQLException {
        ICommand command = null;

        String role = getRoleBySession(request);
        switch (role) {
            case UNKNOWN:
                command = commands.get(request.getParameter(COMMAND));
                break;
            case ADMIN:
                command = adminCommands.get(request.getParameter(COMMAND));
                break;
            case CLIENT:
                command = userCommands.get(request.getParameter(COMMAND));
                break;
        }

        if (command == null) {
            command = new CommandIndex();
        }

        return command;
    }

    /**
     * Find role by session
     */
    private String getRoleBySession(HttpServletRequest request) throws SQLException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return UNKNOWN;
        } else {
            return UserService.getInstance().getRole((User) session.getAttribute("currentUser"));
        }
    }
}
