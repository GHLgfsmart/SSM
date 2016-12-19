package com.ht.controller.fhdb;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.fhdb.impl.WarningServiceImpl;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

@Controller
@RequestMapping(value = "/Warehouse")
public class WarehouseAlertController extends BaseController {
	String menuUrl = "Warehouse/ListWarehouse.do"; // 菜单地址(权限用)
	
	@Resource(name="warningServiceImpl")
	private WarningServiceImpl warningServiceImpl;

	/**
	 * 查询所有警报
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ListWarehouse")
	public ModelAndView ListWarehouse(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> warList = warningServiceImpl.listWarning(page);
		if (warList!=null) {
			mv.setViewName("warehouse/ListWarehouse");
			mv.addObject("warList", warList);
			mv.addObject("pd", pd);
			return mv;
		}else{
			mv.setViewName("warehouse/no");
			return mv;
		}
	}
}
