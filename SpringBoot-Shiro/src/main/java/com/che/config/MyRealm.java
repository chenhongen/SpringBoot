package com.che.config;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.che.pojo.po.CapUser;
import com.che.service.UserService;

public class MyRealm extends JdbcRealm {
	@Resource
	private UserService capUserService;
	
	/**
	 * 身份验证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) {
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;
		CapUser user = capUserService.getUser(upToken.getUsername());
		if (null == user) {
	        throw new AccountException("帐号不正确！");
	    }

		SimpleAuthenticationInfo authenticationInfo = null;
		authenticationInfo = new SimpleAuthenticationInfo(
			upToken.getUsername(), //用户名
			user.getPassword(), //查出密码与token中密码比较
            getName()  //realm name
		);
		return authenticationInfo;
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Set<String> roleNames = new HashSet<>();

		principals.forEach(p -> {
            try {
                Set<String> roles = getRoleNamesForUser(null, (String) p);
                roleNames.addAll(roles);
                //permissions.addAll(getPermissions(null, null,roles));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        });

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roleNames);
        //info.setStringPermissions(permissions);
        return info;
	}

	/**
	 * 根据user_id获取角色
	 */
	@Override
	protected Set<String> getRoleNamesForUser(Connection conn, String username) throws SQLException {
		return capUserService.selectRoleByUserId(username);
	}

	@Override
	protected Set<String> getPermissions(Connection conn, String username, Collection<String> roleNames)
			throws SQLException {
		// TODO Auto-generated method stub
		return super.getPermissions(conn, username, roleNames);
	}
	
}
