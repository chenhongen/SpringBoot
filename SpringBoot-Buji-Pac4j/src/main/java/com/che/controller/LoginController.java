package com.che.controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.che.service.UserService;


@Controller
public class LoginController {
	// 盐值（加密混淆）
    private final static String slat = "diasj29er2ur734tuei89u34efdfi30q7u5834tdphf056=-251758";
    
	private static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Resource
	private UserService capUserService;
	
	/**
	 * shiro：登陆
	 * @param userId
	 * @param password
	 * @param request
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/login")
	@ResponseBody
	public Map<String, String> shrioLogin(String userId, String password, HttpServletRequest request) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		// 拦截get请求
		if(request.getMethod().equals(RequestMethod.GET.toString())) {
			throw new UnknownAccountException();
		}
		Map<String, String> result = new HashMap<>();
		if(!StringUtils.isBlank(userId)){
			Subject subject = SecurityUtils.getSubject();
			//subject.getSession().setTimeout(30 * 60 * 1000);
			String md5Pwd = new Md5Hash(password, slat).toString();
			logger.info("-----------------{}--------------------",md5Pwd);
			UsernamePasswordToken token = new UsernamePasswordToken(userId, md5Pwd); // cred.isRememberMe()
			try {
				subject.login(token);
				//initUserObject(userId, request); // 初始化用户到redis缓存
				result.put("result", "SUCCESS");
			} catch (AuthenticationException ae) {
		        ae.printStackTrace();
		        result.put("result", "FAIL");
		    }
		}else{
			logger.error("The UserId is null");
			result.put("result", "FAIL");
		}
		
		return result;
	}
	
	/**
	 * shiro：退出，转至登陆界面
	 * @return
	 */
	@RequestMapping("/logout")
	public String shrioLogout() {
		Subject subject = SecurityUtils.getSubject();
		
		try {
			subject.logout();
			subject.getSession().removeAttribute("userObject");
		} catch (AuthenticationException ae) {
	        ae.printStackTrace();
	    }
		return "login";
	}
	
}
