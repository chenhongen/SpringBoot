- pom.xml引入

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-websocket</artifactId>
</dependency>
```
- application.yml配置地址
```
socket:
  url: /ws
```

- WebSocketConfig.java
初始化

- resources/public/app.js
浏览器建立websocket连接 -> 订阅 -> 消费/响应

- WebsocketController.java
生产加工后推送给订阅的消费者，这里可以加入与数据库的操作；<br>

- 问题交流
QQ:251601797(请备注：websocket)



