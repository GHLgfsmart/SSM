package com.ht.service.system;

import java.util.List;

import com.ht.entity.Page;
import com.ht.util.PageData;


/** 单表接口类
 */
public interface PriceManager {
	/**单表列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPrices(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**修改单表
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	/**保存单表
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception;
	
	/**删除单表
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception;
	/**批量删除
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] PRICE_IDS)throws Exception;
}
