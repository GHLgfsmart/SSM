package com.ht.controller.system;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.system.PriceManager;
import com.ht.util.AppUtil;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

/** 
 * 类名称：PriceController
 */
@Controller
@RequestMapping(value="/price")
public class PriceController extends BaseController{
	String menuUrl = "price/list.do"; //菜单地址(权限用)
	@Resource(name="priceService")
	private PriceManager priceService;
	/**显示列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView listUsers(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	listPrices = priceService.listPrices(page);	//列表
		if (listPrices.size()==0) {
			pd.put("sizes", "sizes");
		}else{
			int a=0;
			for(int i=0;i<listPrices.size();i++){
				if (!"0".equals(listPrices.get(i).getString("STATE"))) {
					a=a+1;
				}
			}
			if(a==listPrices.size()){//判断状态有没有“0”
				pd.put("sizes", "sizes");
			}
		}
		pd.put("UserName",Jurisdiction.getUsername() );
		mv.setViewName("system/price_money/price_list");
		mv.addObject("listPrices", listPrices);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**去修改页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditU")//
	public ModelAndView goEditU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PRICE_ID", pd.getString("PRICE_ID"));
		pd = priceService.findById(pd);
		mv.setViewName("system/price_money/price_edit"); 
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 修改
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限判断当前操作者有无用户管理修改权限
		priceService.editU(pd);	//执行修改
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**去新增页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddU")////goAddU
	public ModelAndView goAddU()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/price_money/price_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		return mv;
	}
	/**保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveU")
	public ModelAndView saveU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增Price");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PRICE_ID", this.get32UUID());	
		pd.put("STATE", '0');	
		pd.put("MONEYTIME", DateUtil.getTime().toString());
		priceService.saveU(pd); 
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteU")
	public void deleteU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除price");
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!"admin".equals(Jurisdiction.getUsername())){
			pd.put("STATE", "1");
		}
		priceService.deleteU(pd);
		out.write("success");
		out.close();
	}
	/**
	 * 批量删除
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteAllU")
	@ResponseBody
	public Object deleteAllU() throws Exception {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"批量删除");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String PRICE_ID = pd.getString("PRICE_ID");
		if(null != PRICE_ID && !"".equals(PRICE_ID)){
			String ArrayUSER_IDS[] = PRICE_ID.split(",");
			priceService.deleteAllU(ArrayUSER_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
}
