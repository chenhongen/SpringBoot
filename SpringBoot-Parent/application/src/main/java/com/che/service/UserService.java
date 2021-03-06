package com.che.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.che.dao.CapUserMapper;
import com.che.pojo.po.CapUser;
import com.che.pojo.po.CapUserExample;

@Service
public class UserService {
	@Resource
	private CapUserMapper mapper;
	
	public List<CapUser> listByCriteria(CapUserExample criteria) {
		return mapper.selectByExample(criteria);
	}
}
