package com.ht.service.fhoa;

import java.util.List;

import com.ht.entity.Warehouse;
/**
 * 仓库管理Service接口
 * @author Bruse
 *
 */
public interface WarehouseManager {
	
	/**统计
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<Warehouse> barChar()throws Exception;

}
