package com.che.service;

import java.util.List;
import java.util.Set;

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
	
	public CapUser getUser(String userId) {
		CapUserExample example = new CapUserExample();
		example.createCriteria().andUserIdEqualTo(userId);
		List<CapUser> users = mapper.selectByExample(example);
		
		if(users.size() > 0) {
			return users.get(0);
		}
		return null;
	}
	
	public Set<String> selectRoleByUserId(String userId) {
		return mapper.selectRoleByUserId(userId);
	}
}
