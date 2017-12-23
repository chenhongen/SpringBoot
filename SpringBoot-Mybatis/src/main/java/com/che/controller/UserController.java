package com.che.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.che.service.UserService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.che.pojo.po.CapUser;
import com.che.pojo.po.CapUserExample;
import com.che.pojo.vo.PageVO;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserService userService;
	
	/**
	 * 用户查询
	 * @param dg 通用模板
	 * @return
	 */
	@RequestMapping(value="/listUserByCriteria", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listUserByCriteria(PageVO<CapUserExample> pagevo, String key){
		// 分页处理
		Page<CapUser> page = PageHelper.startPage(pagevo.getPageIndex(), pagevo.getPageSize());
		
		CapUserExample criteria = new CapUserExample();
		if(StringUtils.isNotBlank(key)) 
			criteria.createCriteria().andUserNameLike("%" + key + "%");
		// 一览查询
		List<CapUser> users = userService.listByCriteria(criteria);
		
		// 总数统计
		Long total = page.getTotal();
		// 返回值
		Map<String, Object> result = new HashMap<>();
		result.put("data", users);
		result.put("total", total);
		
		return result;
	}
	
}
