package com.che.config;

import org.apache.shiro.realm.Realm;
import org.apache.shiro.session.mgt.ExecutorServiceSessionValidationScheduler;
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition;
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
/**
 * shrio配置
 * @author che
 *
 */
@Configuration
public class ShiroConfig {
	@Bean
    public Realm realm() {
        return new MyRealm();
    }
	
    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition() {
        DefaultShiroFilterChainDefinition filter
          = new DefaultShiroFilterChainDefinition();
        // Shiro内置的FilterChain
        // anon：所有url都都可以匿名访问
        //filter.addPathDefinition("/**", "anon");
        filter.addPathDefinition("/login", "anon");
        filter.addPathDefinition("/relogin", "anon");
        filter.addPathDefinition("/router/login", "anon");
        filter.addPathDefinition("/open/**", "anon");
        // authc：需要认证才能进行访问，需要放最后
        filter.addPathDefinition("/**", "authc");
        return filter;
	}
    
    @Bean(name = "sessionManager")
	public DefaultWebSessionManager getSessionManage() {
		DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
		sessionManager.setGlobalSessionTimeout(4 * 30 * 60 * 1000); // 设置全局session超时时间  ms
		sessionManager.setSessionValidationScheduler(getExecutorServiceSessionValidationScheduler());
		sessionManager.setSessionValidationSchedulerEnabled(true); // 是否定时检查session 
		sessionManager.setDeleteInvalidSessions(true); // 删除过期的session  
		sessionManager.setSessionIdCookieEnabled(true);
		sessionManager.setSessionIdCookie(getSessionIdCookie());
		//EnterpriseCacheSessionDAO cacheSessionDAO = new EnterpriseCacheSessionDAO();
		//cacheSessionDAO.setCacheManager(getCacheManage());
		//sessionManager.setSessionDAO(cacheSessionDAO);
		// -----可以添加session 创建、删除的监听器
		return sessionManager;
	}
    
    @Bean(name = "sessionIdCookie")
	public SimpleCookie getSessionIdCookie() {
		SimpleCookie cookie = new SimpleCookie("sid");
		cookie.setHttpOnly(true);
		cookie.setMaxAge(-1);
		return cookie;
	}
    
    @Bean(name = "sessionValidationScheduler")
	public ExecutorServiceSessionValidationScheduler getExecutorServiceSessionValidationScheduler() {
		ExecutorServiceSessionValidationScheduler scheduler = new ExecutorServiceSessionValidationScheduler();
		scheduler.setInterval(2 * 60 * 60 * 1000);
		return scheduler;
	}
}
