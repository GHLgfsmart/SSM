package com.ht.service.system;

import java.util.List;

import com.ht.entity.Page;
import com.ht.util.PageData;


/** 费用接口类
 */
public interface MoneyManager {
	/**费用列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listMoneys(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**修改共费用
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	/**保存费用
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception;
	
	/**删除费用
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception;
	
	/**批量删除费用
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] MSGID)throws Exception;
	
}
