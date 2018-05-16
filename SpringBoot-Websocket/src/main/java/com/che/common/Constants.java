package com.che.common;

public class Constants {
	
	//执行成功
	public static final String SUCCESS = "SUCCESS";
	//执行失败
	public static final String FAIL = "FAIL";
	
	/** * 响应码枚举，参考HTTP状态码的语义 */ 
	public enum ResultCode { 
		SUCCESS(200),//成功 
		FAIL(400),//失败 
		UNAUTHORIZED(401),//未认证（签名错误） 
		NOT_FOUND(404),//接口不存在 
		INTERNAL_SERVER_ERROR(500);//服务器内部错误 
		public int code; 
		ResultCode(int code) { 
			this.code = code; 
		}
	}
	
}
