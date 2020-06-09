package com.system.entity;

import java.io.Serializable;

/**
 * User role
 */
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    public static final String ROLE_USER = "user";
    public static final String ROLE_ADMIN = "admin";

    private Integer roleId;
    private String roleTitle;

    public Role() {
    }

    public Integer getRoleId() {
        if (roleTitle.equals(ROLE_USER)) {
            roleId = 1;
        } else if (roleTitle.equals(ROLE_ADMIN)) {
            roleId = 2;
        }
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleTitle() {
        return roleTitle;
    }

    public void setRoleTitle(String roleTitle) {
        this.roleTitle = roleTitle;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((roleId == null) ? 0 : roleId.hashCode());
        result = prime * result + ((roleTitle == null) ? 0 : roleTitle.hashCode());
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
        if (roleId == null) {
            if (other.roleId != null)
                return false;
        } else if (!roleId.equals(other.roleId))
            return false;

        if (roleTitle == null) {
            return other.roleTitle == null;
        } else return roleTitle.equals(other.roleTitle);
    }

}
