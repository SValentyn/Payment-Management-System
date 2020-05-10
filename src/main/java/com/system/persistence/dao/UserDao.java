package com.system.persistence.dao;

import com.system.entity.User;

import java.util.List;

/**
 * The UserDao interface provides methods for retrieving data for User entity
 *
 * @author Syniuk Valentyn
 */
public interface UserDao {

    /**
     * Inserts new entity into database
     */
    int create(User entity);

    /**
     * Updates existing account
     */
    int update(User entity);

    /**
     * Removes user by user id
     */
    int delete(Integer id);

    /**
     * Retrieves user entity by user id
     */
    User findUserByUserId(Integer userId);

    /**
     * Retrieves user by login and password
     */
    User findUserByLoginAndPassword(String login, String password);

    /**
     * Retrieves user by phone number
     */
    User findUserByPhoneNumber(String phone);

    /**
     * Retrieves all users
     */
    List<User> findAllUsers();

    /**
     * Searches all users by criteria
     */
    List<User> searchByCriteria(String name, String surname, String phone, String email);

}
