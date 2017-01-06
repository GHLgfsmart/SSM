package com.ht.controller.fhdb;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.util.ResponseUtil;
import com.ht.controller.base.BaseController;
import com.ht.service.fhdb.impl.DrawingServiceImpl;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

import net.sf.json.JSONArray;

/**
 * 入库统计报表
 * @author liujie
 *
 */
@Controller
@RequestMapping(value="/TheReport")
public class InventoryReportController extends BaseController {
	String menuUrl = "TheReport/notPage.do"; // 菜单地址(权限用)
	
	@Resource(name = "drawingServiceImpl")
	private DrawingServiceImpl drawingServiceImpl;
	
	
	/**
	 * 去统计待入库的物资报表的页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notPage")
	public ModelAndView notPage()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.setViewName("fhdb/Inventory_report/notSupplies");
		return mv;
	}
	
	/**
	 * 查询出待入库的物资并已报表的形式统计出来
	 * @throws Exception
	 */
	@RequestMapping(value="/notThereport")
	public void notThereport(HttpServletResponse response)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		List<PageData> notSupplies =drawingServiceImpl.notSuppliesList(pd);
		JSONArray jsonArray=JSONArray.fromObject(notSupplies);
		ResponseUtil.write(response, jsonArray);
	}
}
