package com.ht.quartz;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ht.service.fhdb.InventoryManager;

/**
 * 查找过时库存盘点
 * @author Bruse
 *
 */
@Component
public class FindLossInventory {
	
	@Resource
	private InventoryManager inventoryService;
	
	/**
	 * 0 0/1 * * * ? :每分钟执行
	 * 0 0 2 * *  ? : 每天凌晨2点定期执行
	 * 检查库存盘点
	 * @throws Exception 
	 */
	@Scheduled(cron="0 0/2 * * * ?")
	public void work2() throws Exception {
		
		inventoryService.checkInventory();
		
	}

}
