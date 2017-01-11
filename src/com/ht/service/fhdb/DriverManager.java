package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Page;
import com.ht.util.PageData;

/**
 * 司机Service接口
 * @author Bruse
 *
 */
public interface DriverManager {
	
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
	public List<PageData> listDriver(Page page)throws Exception;
	
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
	
	/**通过邮箱获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUE(PageData pd)throws Exception;
	
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
	
	/**判断手机号码是否存在
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUN(PageData pd)throws Exception;
	
}
