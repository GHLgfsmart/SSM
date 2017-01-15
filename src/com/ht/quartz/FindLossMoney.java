package com.ht.quartz;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ht.service.system.MoneyManager;

/**
 * 查找钱
 * @author Bruse
 *
 */
@Component
public class FindLossMoney {
	
	@Resource
	private MoneyManager moneyService;
	
	/**
	 * 0 0/1 * * * ? :每分钟执行
	 * 0 0 2 * *  ? : 每天凌晨2点定期执行
	 * 检查出入库表
	 * @throws Exception 
	 */
	@Scheduled(cron="0 0/2 * * * ?")
	public void work2() throws Exception {
		
		moneyService.checkMoney();
		
	}

}
