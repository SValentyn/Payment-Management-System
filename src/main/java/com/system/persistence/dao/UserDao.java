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
     * Finds user entity by userId
     */
    User findById(Integer id);

    /**
     * Retrieves user by login and password
     */
    User findByLoginAndPassword(String login, String password);

    /**
     * Finds user by phone
     */
    User findByPhone(String phone);


    /**
     * Finds all users
     */
    List<User> findAll();

}
