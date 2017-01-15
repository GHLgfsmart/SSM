package com.ht.quartz;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ht.service.fhdb.GoodsManager;

/**
 * 定时查询装箱表中已装箱的且三年前的数据
 * @author Bruse
 *
 */
@Component
public class FindLossGoods {
	
	@Resource
	private GoodsManager goodsService;
	
	/**
	 * 0 0/1 * * * ? :每分钟执行
	 * 0 0 2 * *  ? : 每天凌晨2点定期执行
	 * @throws Exception 
	 */
	@Scheduled(cron="0 0/2 * * * ?")
	public void work() throws Exception {
		
		goodsService.checkGoods();;
		
	}

}
