package com.che.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.che.bean.Area;

@Service
public class RedisService {

	private Logger logger = LoggerFactory.getLogger(RedisService.class);

	@Autowired//@Resource(name="cheRedisTemplate")
	private RedisTemplate<String, String> redisTemplate;
	@Resource(name= "cheRedisTemplate")
	private HashOperations<String, String, String> hashOpsText;
	@Resource(name= "cheRedisTemplate")
    private HashOperations<String, String, List<Area>> hashOps;
	
	private static String REDIS_KEY_CITY_CACHE = "city_cache";
	
	/**
	 * 缓存初始化
	 * @param areaEntries
	 * @return
	 */
	public boolean init(List<Area> areaEntries){
		redisTemplate.delete(REDIS_KEY_CITY_CACHE);
		
		List<String> cityKey = new ArrayList<>();
		Map<String, List<Area>> entryMap = new HashMap<>();
		
		// 遍历地区，同时筛选出市
		Iterator<Area> entryIt = areaEntries.iterator();
		while (entryIt.hasNext()) {
			Area entry = entryIt.next();
			// 检测是否已经存在当前key
			if (cityKey.contains(entry.getCityId()+"")) {
				entryMap.get(entry.getCityId()+"").add(entry);
			} else {
				cityKey.add(entry.getCityId()+"");
				List<Area> list = new ArrayList<Area>();
				list.add(entry);
				entryMap.put(entry.getCityId()+"", list);
			}
			
			//存放简单数据缓存
			String cacheKey = entry.getId() + "-" + entry.getId();
			if(hashOpsText.hasKey(REDIS_KEY_CITY_CACHE, cacheKey)) {
				logger.warn("The resource is in cache, the resourceId is {}", cacheKey);
				return false;
			}
			hashOpsText.put(REDIS_KEY_CITY_CACHE, cacheKey, entry.getName());
		}
		
		Iterator<String> keyIt = cityKey.iterator();
		while (keyIt.hasNext()) {
			String key = keyIt.next();
			List<Area> entries = entryMap.get(key);
			
			if(hashOps.hasKey(REDIS_KEY_CITY_CACHE, key)) {
				logger.info("The city is in cache, the cityId is {}", key);
				return false;
			}
			hashOps.put(REDIS_KEY_CITY_CACHE, key, entries);
		}
		
		return true;
	}

	public List<Area> listArea(Long cityId) {
		if(hashOps.hasKey(REDIS_KEY_CITY_CACHE, cityId+"")) {
			List<Area> entries = hashOps.get(REDIS_KEY_CITY_CACHE, cityId+"");

			return entries;
		}else{
			List<Area> entries = new ArrayList<>();
			
			logger.warn("The dict is null, cityId is " + cityId);
			
			return entries;
		}
	}
	
	public String getArea(Long cityId, Long id){
		String cacheKey = cityId + "-" + id;
		if(hashOpsText.hasKey(REDIS_KEY_CITY_CACHE, cacheKey)) {
			return hashOpsText.get(REDIS_KEY_CITY_CACHE, cacheKey);
		}else{
			logger.info("The city is null, cityId is" + cityId + ", id is" + id);
			return "";
		}
	}
}
