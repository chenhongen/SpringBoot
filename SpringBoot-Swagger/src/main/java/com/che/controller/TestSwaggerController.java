package com.che.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import com.che.pojo.vo.ResultVO;
import com.che.pojo.vo.UserVO;

@Api(value="/user", tags="用户模块接口")
@RestController
@RequestMapping("/user")
public class TestSwaggerController {
	
    @ApiOperation(value="获取用户信息", notes = "获取用户信息")
    @RequestMapping(method=RequestMethod.GET)
    public UserVO getUser(){
        return new UserVO("che");
    }

    @ApiOperation(value="添加用户信息", notes = "添加用户信息")
    @ApiImplicitParam(name="user", value="user", required = true, dataType = "UserVO")
    @RequestMapping(method=RequestMethod.POST)
    public ResultVO insertUser(@RequestBody UserVO user){
    	// 数据库操作
    	
    	return new ResultVO().ok();
    }
    
    
}