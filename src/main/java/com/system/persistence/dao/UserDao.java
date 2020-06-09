package com.system.persistence.dao;

import com.system.entity.User;

import java.util.List;

/**
 * The interface provides methods for retrieving data for a User entity
 *
 * @author Syniuk Valentyn
 */
public interface UserDao {

    /**
     * Inserts new entity into database
     */
    int create(User entity);

    /**
     * Updates user data
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
     * Retrieves user by phone and password
     */
    User findUserByPhoneAndPassword(String phone, String password);

    /**
     * Retrieves user by phone number
     */
    User findUserByPhoneNumber(String phone);

    /**
     * Retrieves all users in the system
     */
    List<User> findAllUsers();

    /**
     * Searches all users by criteria
     */
    List<User> searchByCriteria(String name, String surname, String phone, String email);

}
