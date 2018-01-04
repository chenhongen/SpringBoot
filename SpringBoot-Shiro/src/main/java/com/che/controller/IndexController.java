package com.che.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	@RequestMapping("/")
	public String index(HttpServletRequest request) {
		return "index";
	}
	
	@RequestMapping(value="router/**")
	public String route(HttpServletRequest request) {
		String path = request.getServletPath();
		return path.substring(7, path.length());
	}
}
