package com.ht.controller.fhdb;


import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Inventory;
import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.service.fhdb.InventoryManager;
import com.ht.service.fhdb.WarehousingManager;
import com.ht.util.AppUtil;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

/**
 * 仓库盘点Controller层
 * @author Bruse
 *
 */
@Controller
@RequestMapping("/inventory")
public class InventoryController extends BaseController{
	
	String menuUrl = "inventory/list.do"; //菜单地址(权限用)
	
	@Resource
	private InventoryManager inventoryService;
	@Resource
	private WarehousingManager warehouseService;
	@RequestMapping("/list")
	public ModelAndView list(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("username", Jurisdiction.getUsername());
		String state = pd.getString("state");
		if(state != null) {
			pd.put("STATE",state);
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastStart = pd.getString("lastStart");	//开始时间
		String lastEnd = pd.getString("lastEnd");		//结束时间
		if(lastStart != null && !"".equals(lastStart)){
			pd.put("lastStart", lastStart+" 00:00:00");
		}
		if(lastEnd != null && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd+" 00:00:00");
		} 
		page.setPd(pd);
		
		List<PageData>	inventoryList = inventoryService.listInventory(page);	//列出用户列表
		mv.setViewName("system/inventory/inventory_list");
		mv.addObject("pd", pd);
		mv.addObject("inventoryList", inventoryList);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**
	*@WMF
	*盘点差异列表
	*/
	@RequestMapping(value="/cylist")
	public ModelAndView cylist(Page page)throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"盘点差异报表列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> cylist=inventoryService.cylist(page);
		List<PageData> wz=new ArrayList<PageData>();
		int ck=0;
		for(int i=0;i<cylist.size();i++){
			pd.put("warehouse_ID", cylist.get(i).get("warehouse_ID"));
			pd.put("MATERIALS_ID",cylist.get(i).get("MATERIALS_ID"));
			PageData t=new PageData();
			t.put("MID", cylist.get(i).get("MATERIALS_ID"));
			t.put("MNAME", cylist.get(i).get("NAME"));
			t.put("WID",cylist.get(i).get("warehouse_ID"));
			t.put("WNAME",cylist.get(i).get("WNAME"));
			wz.add(t);
			ck=warehouseService.cknumber(pd);
			cylist.get(i).put("ck",ck);
		}
		mv.addObject("cylist",cylist); 
		mv.addObject("wz",wz);
		mv.addObject("pd",pd);
		mv.setViewName("system/inventory/difference");
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	/**去新增用户页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddU")
	public ModelAndView goAddU()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("username", Jurisdiction.getUsername());
		mv.setViewName("system/inventory/inventory_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveU")
	public ModelAndView saveU(Inventory it) throws Exception {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		logBefore(logger, Jurisdiction.getUsername()+"新增盘点信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		String MATERIALS_ID = pd.getString("MATERIALS_ID");
		pd.put("ID", this.get32UUID());	//ID 主键
		pd.put("MATERIALS_ID", MATERIALS_ID);
		pd.put("BIANHAO", "KC"+DateUtil.getCurrentDateStr());
		pd.put("PRO_NAME", it.getPRO_NAME());
		pd.put("PRACTICAL", Integer.valueOf(it.getPRACTICAL()));
		pd.put("MANY", Integer.valueOf(it.getMANY()));
		pd.put("PRACTICAL", Integer.valueOf(it.getPRACTICAL()));
		pd.put("DECREASE_COUNT", Integer.valueOf(it.getDECREASE_COUNT()));
		pd.put("ENTRY_TIME", it.getENTRY_TIME() +" 00:00:00");
		/*pd.put("UPDATE_TIME", it.getUPDATE_TIME() +" 00:00:00");	*/			//最后登录时间
		pd.put("STATE",0);					//状态
		inventoryService.saveU(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去修改页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditU")
	public ModelAndView goEditU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = inventoryService.findById(pd);								//根据ID读取
		mv.setViewName("system/inventory/inventory_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU(Inventory it) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.getUsername().equals(pd.getString("USERNAME"))){		//如果当前登录用户修改用户资料提交的用户名非本人
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}  //校验权限 判断当前操作者有无用户管理查看权限
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限判断当前操作者有无用户管理修改权限
			if("admin".equals(pd.getString("USERNAME")) && !"admin".equals(Jurisdiction.getUsername())){return null;}	//非admin用户不能修改admin
		}
		String MATERIALS_ID = pd.getString("MATERIALS_ID");
		pd.put("PRO_NAME", it.getPRO_NAME());
		pd.put("MANY", it.getMANY());
		pd.put("NOTE", it.getNOTE());
		pd.put("MATERIALS_ID", MATERIALS_ID);
		pd.put("PRACTICAL", it.getPRACTICAL());
		pd.put("DECREASE_COUNT", it.getDECREASE_COUNT());
		pd.put("ENTRY_TIME", it.getENTRY_TIME());
		Date date = new Date();
		String dateStr = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
		pd.put("UPDATE_TIME", dateStr);
		inventoryService.editU(pd);	//执行修改
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 修改状态为1   通过
	 */
	@RequestMapping(value="/yes")
	public ModelAndView yes(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("username", Jurisdiction.getUsername());
		pd = this.getPageData();
		pd.put("STATE", 1);
		inventoryService.yes(pd);	//执行修改
		List<PageData>	inventoryList = inventoryService.listInventory(page);	//列出用户列表
		mv.setViewName("system/inventory/inventory_list");
		mv.addObject("pd", pd);
		mv.addObject("inventoryList", inventoryList);
		return mv;
	}
	
	/**
	 * 修改状态为2   未通过
	 */
	@RequestMapping(value="/no")
	public ModelAndView no(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("username", Jurisdiction.getUsername());
		pd = this.getPageData();
		pd.put("STATE", 2);
		inventoryService.yes(pd);	//执行修改
		List<PageData>	inventoryList = inventoryService.listInventory(page);	//列出用户列表
		mv.setViewName("system/inventory/inventory_list");
		mv.addObject("pd", pd);
		mv.addObject("inventoryList", inventoryList);
		return mv;
	}
	
	/**
	 * 修改状态为0   默认状态   未审核
	 */
	@RequestMapping(value="/quShen")
	public ModelAndView quShen(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("username", Jurisdiction.getUsername());
		pd = this.getPageData();
		pd.put("STATE", 0);
		inventoryService.yes(pd);	//执行修改
		List<PageData>	inventoryList = inventoryService.listInventory(page);	//列出用户列表
		mv.setViewName("system/inventory/inventory_list");
		mv.addObject("pd", pd);
		mv.addObject("inventoryList", inventoryList);
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteU")
	public void deleteU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除");
		PageData pd = new PageData();
		pd = this.getPageData();
		inventoryService.deleteU(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除user");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String IDS = pd.getString("IDS");
		if(null != IDS && !"".equals(IDS)){
			String ArrayIDS[] = IDS.split(",");
			inventoryService.deleteAllU(ArrayIDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasN")
	@ResponseBody
	public Object hasN(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(inventoryService.findByUN(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 弹出物资选择页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/testPage")
	public ModelAndView testPage(Page page) throws Exception{
		System.out.println("******************");
		logBefore(logger, Jurisdiction.getUsername()+"列表Materials");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<Materials_information> list = inventoryService.findBymaterialAll(page);
		mv.setViewName("system/inventory/elect_wuzi");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}
