package com.ht.service.fhoa;

import java.util.List;

import com.ht.entity.Page;
import com.ht.entity.Supplier_customer;
import com.ht.util.PageData;

public interface SupplierAndCustomerManager {
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**
	 * 条件查询
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findBy(PageData pd)throws Exception;
	
	/**
	 * 批量删除
	 * @param ID
	 * @throws Exception
	 */
	public void deleteAll(String[] IDS) throws Exception;
}
