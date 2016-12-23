package com.ht.service.fhdb;

import java.util.List;

import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.util.PageData;

/**
 * 入库管理接口类
 * */
public interface WarehousingManager {
	
	/**
	 * Mr.Lin
	 * 物资保存
	 * @param pd
	 * @throws Exception
	 * */
	public int materialSave(PageData pd)throws Exception;
	
	/**
	 * Mr.Lin
	 * 物资修改
	 * @param pd
	 * @throws Exception
	 * */
	public int materialUpdate(PageData pd)throws Exception;
	
	/**
	 * Mr.Lin
	 * 物资删除
	 * @param pd
	 * @throws Exception
	 * */
	public int materialDelete(PageData pd)throws Exception;
	
	/**
	 * Mr.Lin
	 * 查询物资全部信息
	 * @param page
	 * @throws Exception
	 * */
	public List<Materials_information> findBymaterialAll(Page page)throws Exception;
	
	/**
	 * Mr.Lin
	 * 根据id查询物资信息
	 * @param pd
	 * @throws Exception
	 * */
	public PageData findBymaterialId(PageData pd) throws Exception;
}
