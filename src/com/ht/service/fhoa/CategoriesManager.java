package com.ht.service.fhoa;

import java.util.List;

import com.ht.entity.Customer_categories;
import com.ht.entity.Page;
import com.ht.util.PageData;

public interface CategoriesManager {
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
	
	/**条件查询
	 * @param page
	 * @throws Exception
	 */
	public List<Customer_categories> findBy(PageData page)throws Exception;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findAll(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(String id)throws Exception;
	
	/**
	 * 通过id获取其子级菜单
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	public List<Customer_categories> findSublevel(String id)throws Exception;
	
	/**
	 * 填充每个id的子级菜单
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	public List<Customer_categories> paddingSublevel(String uid)throws Exception;
	
	/**
	 * 查询所有类型
	 * @return
	 * @throws Exception
	 */
	public List<Customer_categories> findAllName() throws Exception;
}
