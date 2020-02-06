package com.system.entity;

import java.io.Serializable;

/**
 * User role
 */
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    public static final String ROLE_ADMIN = "admin";
    public static final String ROLE_CLIENT = "client";

    private Integer id;
    private String rolename;

    public Integer getId() {
        if (rolename.equals(ROLE_CLIENT)) {
            id = 1;
        } else if (rolename.equals(ROLE_ADMIN)) {
            id = 2;
        }
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        result = prime * result + ((rolename == null) ? 0 : rolename.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;

        Role other = (Role) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;

        if (rolename == null) {
            return other.rolename == null;
        } else return rolename.equals(other.rolename);

    }
}
