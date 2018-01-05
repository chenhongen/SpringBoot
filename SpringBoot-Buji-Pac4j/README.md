### 初始化
本项目根据Springboot-Shiro改造，页面没有怎么处理,代码也有冗余。
主要请 关注 com.che.config.pac4j包下配置，如何与cas server对接。
com.che.config.pac4j包下，诸如Myxxxx.java，基本与io.buji.pac4j默认提供的类相同，可自定义改造。

### 访问过程
请求：http://localhost:8081/user/listUserByCriteria
跳转至：http://localhost:8443/cas/login?service=http%3A%2F%2Flocalhost%3A8081%2Fcallback%3Fclient_name%3Dche-cas
登录成功后回调：http://localhost:8081/user/listUserByCriteria

### rebey.cn