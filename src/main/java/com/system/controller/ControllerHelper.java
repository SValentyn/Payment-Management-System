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
        adminCommands.put("changePersonalData", new CommandAdminChangePersonalData());
        adminCommands.put("showUsers", new CommandAdminShowUsers());
        adminCommands.put("showUserAccounts", new CommandAdminShowUserAccounts());
        adminCommands.put("showAccountInfo", new CommandAccountsControl());
        adminCommands.put("addAccount", new CommandAdminCreateAccount());
        adminCommands.put("addCard", new CommandAdminAddCard());
        adminCommands.put("deleteAccount", new CommandAdminDeleteAccount());
        adminCommands.put("deleteCard", new CommandAdminDeleteCard());
        adminCommands.put("blockAccount", new CommandAdminBlockAccount());
        adminCommands.put("blockCard", new CommandAdminBlockCard());
        adminCommands.put("unblockAccount", new CommandAdminUnblockAccount());
        adminCommands.put("unblockCard", new CommandAdminUnblockCard());
        adminCommands.put("addUser", new CommandAdminAddUser());
        adminCommands.put("deleteUser", new CommandAdminDeleteUser());
        adminCommands.put("support", new CommandAdminSupport());
        adminCommands.put("showLetterInfo", new CommandAdminShowLetterInfo());

        // Client commands
        userCommands.put("logout", new CommandLogout());
        userCommands.put("changePersonalData", new CommandUserChangePersonalData());
        userCommands.put("showAccounts", new CommandUserShowAccounts());
        userCommands.put("showAccountInfo", new CommandUserShowAccountInfo());
        userCommands.put("blockAccount", new CommandUserBlockAccount());
        userCommands.put("blockCard", new CommandUserBlockCard());
        userCommands.put("unblockAccount", new CommandUserUnblockAccount());
        userCommands.put("unblockCard", new CommandUserUnblockCard());
        userCommands.put("deleteCard", new CommandUserDeleteCard());
        userCommands.put("createAccount", new CommandUserCreateAccount());
        userCommands.put("makePayment", new CommandUserCreatePayment());
        userCommands.put("repeatPayment", new CommandUserRepeatPayment());
        userCommands.put("addCard", new CommandUserAddCard());
        userCommands.put("support", new CommandUserSupport());
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
