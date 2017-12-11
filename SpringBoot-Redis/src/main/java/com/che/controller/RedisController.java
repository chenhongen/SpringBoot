package com.che.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.che.bean.Area;
import com.che.service.RedisService;

@RestController
public class RedisController {
	@Autowired
	private RedisService rs;
	
	@RequestMapping("/init")
    public String init() {
		String msg = "";
		List<Area> areas = new ArrayList<>();
		
		areas.add(new Area(1L, 1L, "海淀区"));
		areas.add(new Area(2L, 1L, "昌平区"));
		
		if(rs.init(areas)) 
			msg = "初始化成功！";
		
		return msg;
	}
	
	@RequestMapping("/listArea/{cityId}")
    public List<Area> listArea(@PathVariable Long cityId) {
		return rs.listArea(cityId);
	}
	
	@RequestMapping("/getArea/{cityId}/{id}")
    public String getArea(@PathVariable Long cityId, @PathVariable Long id) {
		return rs.getArea(cityId, id);
	}
}
