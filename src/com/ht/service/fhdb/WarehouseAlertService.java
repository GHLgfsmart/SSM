package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Page;
import com.ht.util.PageData;
/**
 * 
 * @author 仓库警报接口
 *
 */
public interface WarehouseAlertService {
	/**
	 * 
	 * 列出所有警报的仓库列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listWarning(Page page)throws Exception;
	/**
	 * 把数据导出到excel表格
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> ExportData(PageData pd)throws Exception;
}
