package com.che.pojo.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class CapRole implements Serializable {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column CAP_ROLE.ROLE_ID
     *
     * @mbg.generated
     */
    private String roleId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column CAP_ROLE.ROLE_CODE
     *
     * @mbg.generated
     */
    private String roleCode;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column CAP_ROLE.ROLE_NAME
     *
     * @mbg.generated
     */
    private String roleName;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column CAP_ROLE.ROLE_DESC
     *
     * @mbg.generated
     */
    private String roleDesc;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column CAP_ROLE.CREATEUSER
     *
     * @mbg.generated
     */
    private BigDecimal createuser;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column CAP_ROLE.CREATETIME
     *
     * @mbg.generated
     */
    private Date createtime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table CAP_ROLE
     *
     * @mbg.generated
     */
    private static final long serialVersionUID = 1L;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CAP_ROLE
     *
     * @mbg.generated
     */
    public CapRole(String roleId, String roleCode, String roleName, String roleDesc, BigDecimal createuser, Date createtime) {
        this.roleId = roleId;
        this.roleCode = roleCode;
        this.roleName = roleName;
        this.roleDesc = roleDesc;
        this.createuser = createuser;
        this.createtime = createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CAP_ROLE
     *
     * @mbg.generated
     */
    public CapRole() {
        super();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column CAP_ROLE.ROLE_ID
     *
     * @return the value of CAP_ROLE.ROLE_ID
     *
     * @mbg.generated
     */
    public String getRoleId() {
        return roleId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column CAP_ROLE.ROLE_ID
     *
     * @param roleId the value for CAP_ROLE.ROLE_ID
     *
     * @mbg.generated
     */
    public void setRoleId(String roleId) {
        this.roleId = roleId == null ? null : roleId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column CAP_ROLE.ROLE_CODE
     *
     * @return the value of CAP_ROLE.ROLE_CODE
     *
     * @mbg.generated
     */
    public String getRoleCode() {
        return roleCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column CAP_ROLE.ROLE_CODE
     *
     * @param roleCode the value for CAP_ROLE.ROLE_CODE
     *
     * @mbg.generated
     */
    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode == null ? null : roleCode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column CAP_ROLE.ROLE_NAME
     *
     * @return the value of CAP_ROLE.ROLE_NAME
     *
     * @mbg.generated
     */
    public String getRoleName() {
        return roleName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column CAP_ROLE.ROLE_NAME
     *
     * @param roleName the value for CAP_ROLE.ROLE_NAME
     *
     * @mbg.generated
     */
    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column CAP_ROLE.ROLE_DESC
     *
     * @return the value of CAP_ROLE.ROLE_DESC
     *
     * @mbg.generated
     */
    public String getRoleDesc() {
        return roleDesc;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column CAP_ROLE.ROLE_DESC
     *
     * @param roleDesc the value for CAP_ROLE.ROLE_DESC
     *
     * @mbg.generated
     */
    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc == null ? null : roleDesc.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column CAP_ROLE.CREATEUSER
     *
     * @return the value of CAP_ROLE.CREATEUSER
     *
     * @mbg.generated
     */
    public BigDecimal getCreateuser() {
        return createuser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column CAP_ROLE.CREATEUSER
     *
     * @param createuser the value for CAP_ROLE.CREATEUSER
     *
     * @mbg.generated
     */
    public void setCreateuser(BigDecimal createuser) {
        this.createuser = createuser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column CAP_ROLE.CREATETIME
     *
     * @return the value of CAP_ROLE.CREATETIME
     *
     * @mbg.generated
     */
    public Date getCreatetime() {
        return createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column CAP_ROLE.CREATETIME
     *
     * @param createtime the value for CAP_ROLE.CREATETIME
     *
     * @mbg.generated
     */
    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CAP_ROLE
     *
     * @mbg.generated
     */
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        CapRole other = (CapRole) that;
        return (this.getRoleId() == null ? other.getRoleId() == null : this.getRoleId().equals(other.getRoleId()))
            && (this.getRoleCode() == null ? other.getRoleCode() == null : this.getRoleCode().equals(other.getRoleCode()))
            && (this.getRoleName() == null ? other.getRoleName() == null : this.getRoleName().equals(other.getRoleName()))
            && (this.getRoleDesc() == null ? other.getRoleDesc() == null : this.getRoleDesc().equals(other.getRoleDesc()))
            && (this.getCreateuser() == null ? other.getCreateuser() == null : this.getCreateuser().equals(other.getCreateuser()))
            && (this.getCreatetime() == null ? other.getCreatetime() == null : this.getCreatetime().equals(other.getCreatetime()));
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CAP_ROLE
     *
     * @mbg.generated
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getRoleId() == null) ? 0 : getRoleId().hashCode());
        result = prime * result + ((getRoleCode() == null) ? 0 : getRoleCode().hashCode());
        result = prime * result + ((getRoleName() == null) ? 0 : getRoleName().hashCode());
        result = prime * result + ((getRoleDesc() == null) ? 0 : getRoleDesc().hashCode());
        result = prime * result + ((getCreateuser() == null) ? 0 : getCreateuser().hashCode());
        result = prime * result + ((getCreatetime() == null) ? 0 : getCreatetime().hashCode());
        return result;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table CAP_ROLE
     *
     * @mbg.generated
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", roleId=").append(roleId);
        sb.append(", roleCode=").append(roleCode);
        sb.append(", roleName=").append(roleName);
        sb.append(", roleDesc=").append(roleDesc);
        sb.append(", createuser=").append(createuser);
        sb.append(", createtime=").append(createtime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}