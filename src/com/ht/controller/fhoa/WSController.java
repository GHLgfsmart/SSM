package com.ht.controller.fhoa;

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
import com.ht.entity.Warehouse;
import com.ht.service.fhoa.WSManager;
import com.ht.service.system.UserManager;
import com.ht.util.AppUtil;
import com.ht.util.DateUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;

import javafx.scene.control.Alert;

/**
 * 说明： 仓库
 * @author data
 *
 */

@Controller
@RequestMapping(value = "/warehouse")
public class WSController extends BaseController {
	String menuUrl = "warehouse/list.do"; //菜单权限
	@Resource
	private WSManager wSService;
	@Resource
	private UserManager userService;
	
	/**
	 * 显示仓库列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView listAllDepartment(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords");
		if(null != keywords && !"".equals("lastLoginStart")){
			pd.put("keywords", keywords.trim());
		}
		String lastLoginStart = pd.getString("lastLoginStat");
		String lastLoginEnd = pd.getString("lastLoginEnd");
		if(lastLoginStart != null && !"".equals(lastLoginStart)){
			pd.put("lastLoginStart", lastLoginStart+"00:00:00");
		}
		if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
			pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
		} 
		page.setPd(pd);
		List<PageData> warehouseList = wSService.listWarehouse(page);
		pd.put("ID", "1");
		mv.setViewName("fhoa/warehouse/warehouse_list");
		mv.addObject("warehouseList", warehouseList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 删除仓库
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteWare")
	public void deleteWare(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return ;}
		logBefore(logger, Jurisdiction.getUsername()+"删除Warehouse");
		PageData pd = this.getPageData();
		int a=wSService.getCount(pd);
		if(a==0){
			wSService.deleteWare(pd);
			out.write("success");
		}else{
			out.write("fall");
		}
		out.close();
	}
	
	/**
	 * 弹出新增界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goSaveWare")
	public ModelAndView goSaveWare() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Warehouse");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){  //校验权限
			return null;
		}  
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("fhoa/warehouse/warehouse_edit");
		mv.addObject("msg", "saveWare");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**保存仓库
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveWare")
	public ModelAndView saveWare(Warehouse wh) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Warehouse");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){  //校验权限
			return null;
		}
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String p = pd.getString("PRACTICAL");
		pd.put("ID", this.get32UUID()); //主键
		pd.put("WARNAME",wh.getWARNAME());
		pd.put("USER_ID", wh.getUSER_ID());
		pd.put("SIZE", wh.getSIZE());
		pd.put("UPPER_LIMIT", Integer.valueOf(wh.getUPPER_LIMIT()));
		pd.put("LOWER_LIMIT", Integer.valueOf(wh.getLOWER_LIMIT()));
		pd.put("PRACTICAL", Integer.valueOf(p));
		pd.put("ADDRESS", wh.getADDRESS());
		pd.put("ENTRY_TIME", DateUtil.getTime().toString());
		pd.put("UPDATE_TIME", DateUtil.getTime().toString());
		pd.put("NOTE", wh.getNOTE());
		pd.put("STATE", 0);
		wSService.saveWare(pd);					//执行保存
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**去修改仓库界面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditWare")
	public ModelAndView goEditWare() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Warehouse");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){  //校验权限
			return null;
		}  
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();//hqq
		pd = this.getPageData();
		pd.put("ID", pd.getString("ID"));
		pd = wSService.findById(pd);
		mv.setViewName("fhoa/warehouse/warehouse_edit");
		mv.addObject("msg", "editWare");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 修改仓库
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editWare")
	public ModelAndView editWare() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData(); 
		pd.put("UPDATE_TIME", DateUtil.getTime().toString());
		pd.put("STATE", 0);
		wSService.editWare(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
		
	}
	/**
	 * 修改状态
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editSTATE")
	public void editSTATE() throws Exception{
		PageData pd = this.getPageData(); 
		String STATE=pd.getString("STATE");
		if("0".equals(STATE)){
			pd.put("STATE", 1);
		}else if("1".equals(STATE)){
			pd.put("STATE", 0);
		}
		wSService.editSTATE(pd);
	}
	
	/**
	 * 弹出仓库选择负责人界面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/testPage")
	public ModelAndView testPage(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();//hqq
		List<PageData> list = userService.listUsers(page);//----
		mv.setViewName("fhoa/warehouse/user_list");
		mv.addObject("userList", list);
		mv.addObject("pd", pd);
		return mv;
		
	}
	
	/**
	 * 判断仓库名是否存在
	 * @return
	 */
	@RequestMapping(value="/hasW")
	@ResponseBody
	public Object hsW(){
		Map<String, String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
		pd= this.getPageData();
		if(wSService.findByName(pd) != null){
			errInfo = "error";
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 导出仓库信息到Excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){
				String keywords = pd.getString("keywords");
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart");   //开始时间
				String lastLoginEnd = pd.getString("lastLoginEnd");
				if(lastLoginStart != null && !"".equals(lastLoginStart)){
					pd.put("lastLoginStart", lastLoginStart+"00:00:00");
				}
				if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
					pd.put("lastLoginEnd", lastLoginEnd+"00:00:00");
				}
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("仓库名称");
				titles.add("仓库管理员");
				titles.add("仓库大小");
				titles.add("仓库上限");
				titles.add("仓库下限");
				titles.add("仓库实际库存");
				titles.add("仓库地址");
				titles.add("录入时间");
				titles.add("最后录入时间");
				titles.add("备注");
				titles.add("状态");
				dataMap.put("titles", titles);
				List<PageData> warehouseList = wSService.listAllWare(pd);
				List<PageData> warList = new ArrayList<PageData>();
				for(PageData i : warehouseList){
					PageData vpd = new PageData();
					vpd.put("var1",i.getString("NAME"));
					vpd.put("var2", i.getString("USERNAME"));
					vpd.put("var3",i.getString("SIZE"));
					String UPPER_LIMIT = i.get("UPPER_LIMIT")+"";
					vpd.put("var4", UPPER_LIMIT);// 4
					String LOWER_LIMIT = i.get("LOWER_LIMIT")+"";
					vpd.put("var5", LOWER_LIMIT);
					String PRACTICAL = i.get("PRACTICAL")+"";
					vpd.put("var6", PRACTICAL);
					vpd.put("var7", i.getString("ADDRESS"));
					vpd.put("var8", i.getString("ENTRY_TIME"));
					vpd.put("var9", i.getString("UPDATE_TIME"));
					vpd.put("var10",i.getString("NOTE"));
					String STATE = i.get("STATE")+"";
					vpd.put("var11", STATE);
					warList.add(vpd);
				}
				dataMap.put("varList", warList);
				ObjectExcelView erv = new ObjectExcelView();
				mv = new ModelAndView(erv, dataMap);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return mv;
	}
}
