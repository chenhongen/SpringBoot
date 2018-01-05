package com.che.config;

import org.apache.shiro.realm.Realm;
import org.apache.shiro.session.mgt.ExecutorServiceSessionValidationScheduler;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.spring.web.config.AbstractShiroWebFilterConfiguration;
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition;
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;

import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.mgt.SecurityManager;
import org.pac4j.cas.client.CasClient;
import org.pac4j.cas.config.CasConfiguration;
import org.pac4j.cas.config.CasProtocol;
import org.pac4j.core.client.Clients;
import org.pac4j.core.config.Config;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.che.config.pac4j.MyCallbackFilter;
import com.che.config.pac4j.MyLogoutFilter;
import com.che.config.pac4j.MyPac4jRealm;
import com.che.config.pac4j.MyPac4jSubjectFactory;
import com.che.config.pac4j.MySecurityFilter;


/**
 * shrio配置
 * @author che
 *
 */
@Configuration
public class ShiroConfig extends AbstractShiroWebFilterConfiguration {
	@Value("${shiro.cas-server-url-prefix}")
	private String casServerUrlPrefix;
	@Value("${shiro.cas-login-url}")
	private String casLoginUrl;
	@Value("${shiro.cas-logout-url}")
	private String casLogoutUrl;
	@Value("${shiro.server-url-prefix}")
	private String serverUrlPrefix;
	@Value("${shiro.server-call-back}")
	private String serverCallBack;
	
	@Bean
	public Realm pac4jRealm() {
        return new MyPac4jRealm();
    }
	
    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition() {
        DefaultShiroFilterChainDefinition filter
          = new DefaultShiroFilterChainDefinition();
        // Shiro内置的FilterChain
        // anon：所有url都都可以匿名访问
        //filter.addPathDefinition("/**", "anon");
        
        // pac4j
        filter.addPathDefinition("/callback", "callbackFilter");
        filter.addPathDefinition("/logout", "logoutFilter");
        
//        filter.addPathDefinition("/login", "anon");
//        filter.addPathDefinition("/relogin", "anon");
//        filter.addPathDefinition("/router/login", "anon");
        filter.addPathDefinition("/open/**", "anon");
        // authc：需要认证才能进行访问，需要放最后
//        filter.addPathDefinition("/**", "authc");
        filter.addPathDefinition("/user/**", "casSecurityFilter");
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
    
    // pac4j
    
    @Bean(name = "subjectFactory")  
    public MyPac4jSubjectFactory subjectFactory() {  
    	MyPac4jSubjectFactory subjectFactory = new MyPac4jSubjectFactory();  
        return subjectFactory;
    }
    
//    @Bean(name = "securityManager")
//   	public SecurityManager securityManager() {
//    	DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();  
//    	Realm casRealm = pac4jRealm();  
//    	securityManager.setRealm(casRealm);  
//    	securityManager.setSubjectFactory(subjectFactory());
//        //securityManager.setCacheManager(ehCacheManager()); 
//   		return securityManager;
//   	}
	@Bean(name = "securityManager")
 	public DefaultWebSecurityManager securityManager() {
	  	DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();  
	  	Realm casRealm = pac4jRealm();  
	  	securityManager.setRealm(casRealm);  
	  	securityManager.setSubjectFactory(subjectFactory());
	    //securityManager.setCacheManager(ehCacheManager()); 
 		return securityManager;
 	}
    
    /**
     * 对过滤器进行调整
     *
     * @param securityManager
     * @return
     */
    @Bean
    protected ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        //把subject对象设为subjectFactory
        ((DefaultSecurityManager) securityManager).setSubjectFactory(subjectFactory());
        ShiroFilterFactoryBean filterFactoryBean = super.shiroFilterFactoryBean();
        filterFactoryBean.setSecurityManager(securityManager);

        filterFactoryBean.setFilters(shiroFilters());
        return filterFactoryBean;
    }
    
    /**
     * 过滤器设置
     * @return
     */
    @Bean
	public Map<String, Filter> shiroFilters() {
		Map<String, Filter> filters = new HashMap<>();
		filters.put("casSecurityFilter", casSecurityFilter());
		// 回调
		MyCallbackFilter callbackFilter = new MyCallbackFilter();
		callbackFilter.setConfig(casConfig());
		filters.put("callbackFilter", callbackFilter);
		// 退出
		MyLogoutFilter logoutFilter = new MyLogoutFilter();
		logoutFilter.setConfig(casConfig());
		logoutFilter.setCentralLogout(true);
		logoutFilter.setDefaultUrl(serverUrlPrefix);
		filters.put("logoutFilter", logoutFilter);

		return filters;
	}
    
    /**
	 * cas核心过滤器，把支持的client写上，filter过滤时才会处理，clients必须在casConfig.clients已经注册
	 * <p>
	 * 注意：该过滤器不要用spring注入，否则该过滤器会拦截所有的路径请求，除非自定义匹配规则
	 */
	public Filter casSecurityFilter() {
		MySecurityFilter filter = new MySecurityFilter();
		// 多个使用逗号分隔 "che-cas,rest,jwt"
		filter.setClients("che-cas");
		filter.setConfig(casConfig());
		return filter;
	}
	
	/**
	 * 定义配置
	 */
	@Bean
	public Config casConfig() {
		Config config = new Config();
		config.setClients(clients());

		return config;
	}
	
	/**
	 * 定义cas客户端集合(后期如果需要支持rest接口单点登录，就在这里扩展)
	 */
	@Bean
	public Clients clients() {
		Clients clients = new Clients();
		clients.setClients(casClient());
		clients.setDefaultClient(casClient());
		return clients;
	}
	
	/**
	 * 定义cas客户端
	 */
	@Bean
	public CasClient casClient() {
		CasClient casClient = new CasClient();
		casClient.setConfiguration(casConfiguration());
		casClient.setCallbackUrl(serverCallBack);
		// 设置cas客户端名称为cas
		casClient.setName("che-cas");
		return casClient;
	}
	
	/**
	 * cas服务的基本设置，包括或url等等，rest调用协议等
	 */
	@Bean
	public CasConfiguration casConfiguration() {
		CasConfiguration casConfiguration = new CasConfiguration(casLoginUrl);
		// 默认走CasProtocol.CAS30协议
		casConfiguration.setProtocol(CasProtocol.CAS30);
		casConfiguration.setPrefixUrl(casServerUrlPrefix);
		return casConfiguration;
	}
}
