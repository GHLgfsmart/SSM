package com.ht.service.system;

import java.util.List;

import com.ht.entity.Page;
import com.ht.util.PageData;


/** 公告栏接口类
 */
public interface MsgManager {
	/**公告栏列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listMsgs(Page page)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**修改共公告栏
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	/**保存公告栏
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception;
	
	/**删除公告栏
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception;
	
	/**批量删除公告栏
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] MSGID)throws Exception;
	
}
