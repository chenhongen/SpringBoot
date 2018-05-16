package com.che.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * websocket测试类
 * @author che
 *
 */
@RestController
public class WebsocketController {
	
	@Autowired
	private SimpMessageSendingOperations template;
	
	@MessageMapping("/hello")
    @SendTo("/topic/chat")
    public String greeting(@RequestBody String message) throws Exception {
		//System.out.println(message);
        return message;
    }
	
	/**
	 * 以下两种写法效果相同
	 * @param message
	 * @return
	 * @throws Exception
	 */
//	@MessageMapping("/hello2")
//    @SendTo("/queue/chat")
//    public String greeting2(@RequestBody String message) throws Exception {
//		//System.out.println(message);
//        return message;
//    }
	@MessageMapping("/hello2")
    public String greeting2(@RequestBody String message) throws Exception {
		//System.out.println(message);
		if(this.template != null)
			this.template.convertAndSend("/queue/chat", message);  

        return message;
    }
	
	// 以上两三种写法实现的出来的效果最终都是广播（相同订阅）！
	// 如果想实现点对点通讯可以尝试使用template.convertAndSendToUser方法
}
