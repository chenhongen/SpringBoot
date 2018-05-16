package com.che.util;
/**
 * 
 * 字符串工具类
 * 创建人：che   
 * 创建时间：2017年12月5日 上午11:53:02
 *
 */
public class MyStringUtil {
	/**
	 * null转""
	 * @param src
	 * @return
	 */
	public static String null2empty(String src) {
		if(src == null) {
			return "";
		}
		return src;
	}
}
