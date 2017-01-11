package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Drawing;
import com.ht.entity.Materials_information;
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
	 * @throws Exception 
	 */
	public void Audit(PageData pd) throws Exception;
	
	/**
	 * 去审
	 * @param pd
	 */
	public void Abolish(PageData pd);
	
	/**
	 * 删除
	 * @param pd
	 * @return
	 * @throws Exception 
	 */
	public int delDraeing(PageData pd) throws Exception;
	
	/**
	 * 根据id获取数据
	 * @param pd
	 * @return
	 * @throws Exception 
	 */
	
	public PageData DraeingById(String ID) throws Exception;
	
	public PageData DraeingBywname(String MATERIALS_ID) throws Exception;
	

	public PageData byIDPage(Page page)throws Exception;
	/**
	 * 修改
	 * @param ID
	 * @throws Exception 
	 */
	public int updateDraeing(PageData pd) throws Exception;
	
	/**
	 * 统计待入库的物资报表
	 * @param pd
	 * @return
	 * @throws Exception 
	 */
	public List<PageData> notSuppliesList(PageData pd) throws Exception;
	
	public void reduce(PageData pd) throws Exception;
	
	public void  SaveWz(PageData pd)throws Exception;
	
	public void SaveCk(PageData pd)throws Exception;
	
}
