package com.ht.controller.fhdb;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.fhdb.impl.WarehouseAlertServiceImpl;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;

@Controller
@RequestMapping(value = "/Warehouse")
public class WarehouseAlertController extends BaseController {
	String menuUrl = "Warehouse/ListWarehouse.do"; // 菜单地址(权限用)

	@Resource(name = "warningServiceImpl")
	private WarehouseAlertServiceImpl warningServiceImpl;
	
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
		List<PageData> warList = warningServiceImpl.listWarning(page);
		if (warList.isEmpty()) {
			mv.setViewName("fhdb/WarehouseAlert/no");
			return mv;
		} else {
			mv.addObject("warList", warList);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
			mv.setViewName("fhdb/WarehouseAlert/ListWarehouse");
			return mv;
		}
	}
	
	/**
	 * 模糊查询
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/LikeList")
	public ModelAndView LikeList(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> warList = warningServiceImpl.listWarning(page);
			mv.addObject("warList", warList);
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
			mv.setViewName("fhdb/WarehouseAlert/ListWarehouse");
			return mv;
	} 
	
	/**
	 * 导出数据
	 * 
	 * @return
	 * @throws Exception
	 * @throws Throwable
	 */
	@RequestMapping(value = "/ExportData")
	public ModelAndView ExportData(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){
			String keywords = pd.getString("keywords");				//关键词检索条件
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("编号"); // 1
			titles.add("仓库名称"); // 2
			titles.add("仓库大小"); // 3
			titles.add("上限"); // 4
			titles.add("下限"); // 5
			titles.add("实际库存"); // 6
			titles.add("仓库地址"); // 7
			dataMap.put("titles", titles);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
			page.setPd(pd);
			List<PageData> warList = warningServiceImpl.listWarning(page);
			List<PageData> varList = new ArrayList<PageData>();
			for (PageData i : warList) {
				PageData vpd = new PageData();
				vpd.put("var1", i.getString("ID")); // 1
				vpd.put("var2", i.getString("NAME")); // 2
				vpd.put("var3", i.getString("SIZE"));
				String UPPER_LIMIT = i.get("UPPER_LIMIT") + "";// 3
				vpd.put("var4", UPPER_LIMIT);// 4
				String LOWER_LIMIT = i.get("LOWER_LIMIT") + "";
				vpd.put("var5", LOWER_LIMIT);// 5
				String PRACTICAl = i.get("PRACTICAl") + "";
				vpd.put("var6", PRACTICAl);// 6
				vpd.put("var7", i.getString("ADDRESS")); // 7
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
			mv = new ModelAndView(erv, dataMap);
		}
		return mv;
	}
}
