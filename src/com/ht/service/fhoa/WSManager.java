package com.ht.service.fhoa;

import java.util.List;

import com.ht.entity.Page;
import com.ht.util.PageData;

/**
 * 说明：仓库管理接口类
 * @author data
 * 创建时间：2016-12-16
 * @version
 */
public interface WSManager {
	
	/**
	 * 新增仓库
	 * @param pd
	 * @throws Exception
	 */
	public void saveWare(PageData pd)throws Exception;
	
	/**
	 * 删除仓库
	 * @param pd
	 * @throws Exception
	 */
	public void deleteWare(PageData pd)throws Exception;
	
	/**
	 * 修改仓库
	 * @param pd
	 * @throws Exception
	 */
	public void editWare(PageData pd)throws Exception;

	/**
	 * 修改状态
	 * @param pd
	 * @throws Exception
	 */
	public void editSTATE(PageData pd)throws Exception;

	/**仓库列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listWarehouse(Page pd)throws Exception;

	/**
	 * 通过name获取数据
	 * @param pd
	 */
	public List<PageData> findByName(PageData pd) throws Exception;
	/**
	 * 通过Id获取数据
	 * @param pd
	 */
	public PageData findById(PageData pd) throws Exception;
	/**
	 * 仓库列表（全部）
	 * @param pd
	 * @return
	 */
	public List<PageData> listAllWare(PageData pd) throws Exception;

	/**获取入库个数
	 * @param pd
	 * @throws Exception
	 */
	public int getCount(PageData pd)throws Exception;
}
