package com.che.pojo.vo;

import java.security.Principal;

public class UserVO implements Principal {
	
	private String name;

	public UserVO(String name) {
        this.name = name;
    }

	@Override
	public String getName() {
		return name;
	}
	
}
