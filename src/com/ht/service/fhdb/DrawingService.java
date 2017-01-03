package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Drawing;
import com.ht.entity.Page;
import com.ht.util.PageData;

public interface DrawingService {
	/**
	 * 
	 * 查询经手人
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> ListWAndU(Page page)throws Exception;
	/**
	 * 查询仓库名称
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> ListWA(Page page)throws Exception; 
	
	/**
	 * 查询产品
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> ListProduct(Page page)throws Exception;
	
	/**
	 * Mr.Lin
	 * 调拨保存
	 * @param pd
	 * @throws Exception
	 * */
	public int DrawingSave(PageData pd)throws Exception;
	
	/**
	 * 查询调拨单
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> drwingList(Page page)throws Exception;
	
	/**
	 * 审核
	 * @param pd
	 */
	public void Audit(PageData pd);
	
	/**
	 * 去审
	 * @param pd
	 */
	public void Abolish(PageData pd);
	
	/**
	 * 删除
	 * @param pd
	 * @return
	 */
	public void delDraeing(String ID);
	
	/**
	 * 根据id获取数据
	 * @param pd
	 * @return
	 * @throws Exception 
	 */
	
	public PageData DraeingById(String ID) throws Exception;
	
	/**
	 * 修改
	 * @param ID
	 */
	public void updateDraeing(PageData pd);
}
