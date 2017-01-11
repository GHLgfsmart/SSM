package com.ht.service.fhdb;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ht.entity.Page;
import com.ht.util.PageData;

/**
 * 货车Controller层
 * @author Bruse
 *
 */
@Controller
@RequestMapping("/car")
public interface CarManager{
	
	/**
	 * 新增数据
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listCar(Page page)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**获取总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getUserCount(String value)throws Exception;
	
	/**
	 * 批量删除
	 * @param IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] IDS)throws Exception;
	
	/**判断车牌号是否存在
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUN(PageData pd)throws Exception;
	
}
