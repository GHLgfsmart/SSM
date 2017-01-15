package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.util.PageData;

/**
 * 库存盘点Service接口
 * @author Bruse
 *
 */
public interface InventoryManager {
	public void checkInventory() throws Exception ;
	/**
	 * 新增数据
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listInventory(Page page)throws Exception;
	
	/**
	 * 查询物资全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Materials_information> findBymaterialAll(Page page)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	/**修改状态为1（通过）
	 * @param pd
	 * @throws Exception
	 */
	public void yes(PageData pd)throws Exception;
	
	/**修改状态为2（未通过）
	 * @param pd
	 * @throws Exception
	 */
	public void no(PageData pd)throws Exception;
	
	/**修改状态为0（未审核）
	 * @param pd
	 * @throws Exception
	 */
	public void quShen(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**获取总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getUserCount(String value)throws Exception;
	
	/**
	 * 批量删除
	 * @param IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] IDS)throws Exception;
	
	/**判断编号是否存在
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUN(PageData pd)throws Exception;
	/**盘点差异报表
	 * @WMF
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> cylist(Page page) throws Exception;

}
