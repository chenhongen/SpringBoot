package com.che.pojo.vo;

import com.che.common.Constants;
import com.che.common.Constants.ResultCode;

/**
 * 返回数据封装
 * @author che
 *
 */
public class ResultVO {
	private int code;
	private String message;
	private Object data;
	
	public ResultVO setCode(ResultCode resultCode) { 
		this.code = resultCode.code; 
		return this; 
	}
	
	public ResultVO() {
		super();
	}
	
	public ResultVO ok(Object data) { 
		this.code = ResultCode.SUCCESS.code; 
		this.message = Constants.SUCCESS;
		this.data = data;
		
		return this; 
	}
	
	public ResultVO ok() { 
		this.code = ResultCode.SUCCESS.code; 
		this.message = Constants.SUCCESS;
		
		return this; 
	}
	
	public ResultVO error() { 
		this.code = ResultCode.FAIL.code; 
		this.message = Constants.FAIL;
		
		return this; 
	}
	
	public ResultVO error(ResultCode resultCode, String message) { 
		this.code = resultCode.code;
		this.message = message;
		
		return this; 
	}


	public void setCode(int code) {
		this.code = code;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public void setData(Object data) {
		this.data = data;
	}

	public int getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	public Object getData() {
		return data;
	}
}
