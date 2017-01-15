package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Car;
import com.ht.entity.Driver;
import com.ht.entity.Page;
import com.ht.entity.Picking;
import com.ht.util.PageData;

/**
 * 装箱操作Service接口
 * @author Bruse
 *
 */
public interface GoodsManager {
	public void checkGoods() throws Exception ;
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
	public List<PageData> listGoods(Page page)throws Exception;
	
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
	
	/**
	 * 批量修改
	 * @param IDS
	 * @throws Exception
	 */
	public void edit3(String[] PIDS)throws Exception;
	
	/**
	 * 查询拣货全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Picking> findByMaterialAll(Page page)throws Exception;
	
	/**
	 * 查询货车全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Car> findByCarAll(Page page)throws Exception;
	
	/**
	 * 查询司机全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Driver> findByDriverAll(Page page)throws Exception;
	
	/**修改状态为1（派送中）
	 * @param pd
	 * @throws Exception
	 */
	public void ps(PageData pd)throws Exception;
	
	/**修改状态为2（已派送）
	 * @param pd
	 * @throws Exception
	 */
	public void ok(PageData pd)throws Exception;
	
	/**修改拣货表状态为2（已装车）
	 * @param pd
	 * @throws Exception
	 */
	public void edit2(PageData pd)throws Exception;
	

}
