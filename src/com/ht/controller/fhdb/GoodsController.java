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
import com.ht.entity.Car;
import com.ht.entity.Driver;
import com.ht.entity.Goods;
import com.ht.entity.Page;
import com.ht.entity.Picking;
import com.ht.service.fhdb.GoodsManager;
import com.ht.util.AppUtil;
import com.ht.util.Jurisdiction;
import com.ht.util.PageData;

/**
 * 装箱操作Controller
 * @author Bruse
 *
 */
@Controller
@RequestMapping("/goods")
public class GoodsController extends BaseController{
	
	String menuUrl = "goods/list.do"; //菜单地址(权限用)
	
	@Resource
	private GoodsManager goodsService;
	
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
		
		List<PageData>	goodsList = goodsService.listGoods(page);	//列出用户列表
		mv.setViewName("system/Vehicle_management/goods_list");
		mv.addObject("pd", pd);
		mv.addObject("goodsList", goodsList);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
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
		System.out.println("===="+pd);
		pd.put("username", Jurisdiction.getUsername());
		mv.setViewName("system/Vehicle_management/goods_edit");
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
	public ModelAndView saveU(Goods g) throws Exception {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		logBefore(logger, Jurisdiction.getUsername()+"新增装箱信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		String D_ID = pd.getString("D_ID");
		String C_ID = pd.getString("C_ID");
		String P_ID = pd.getString("P_ID");
		pd.put("ID", this.get32UUID());	//ID 主键
		pd.put("D_ID", D_ID);
		pd.put("C_ID", C_ID);
		pd.put("P_ID", P_ID);
		pd.put("D_NAME", g.getD_NAME());
		pd.put("C_BRAND", g.getC_BRAND());
		pd.put("C_WEIGHT", Integer.valueOf(g.getC_WEIGHT()));
		pd.put("P_COUNT", Integer.valueOf(g.getP_COUNT()));
		pd.put("P_MATCOUNT", Integer.valueOf(g.getP_MATCOUNT()));
		pd.put("START_ADDRESS", g.getSTART_ADDRESS());
		pd.put("ADDRESS", g.getADDRESS());
		pd.put("STATE",0);					//状态
		goodsService.saveU(pd);
		edit2();
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 修改拣货状态为2   已装车
	 */
	public void edit2() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		PageData pd = new PageData();
		pd = this.getPageData();
		String P_ID = pd.getString("P_ID");
		pd.put("P_ID", P_ID);
		pd.put("STATE", "2");
		goodsService.edit2(pd);	//执行修改
	}
	
	/**
	 * 修改拣货状态为1   未装车
	 */
	public void edit1(PageData pd) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		goodsService.edit2(pd);	//执行修改
	}
	
	/**
	 * 修改多条拣货状态为1   未装车
	 *//*
	public void edit3(PageData pd) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		goodsService.edit3(pd);	//执行修改
	}*/
	
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
		pd = goodsService.findById(pd);								//根据ID读取
		mv.setViewName("system/Vehicle_management/goods_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU(Goods g) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		if(!Jurisdiction.getUsername().equals(pd.getString("USERNAME"))){		//如果当前登录用户修改用户资料提交的用户名非本人
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}  //校验权限 判断当前操作者有无用户管理查看权限
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限判断当前操作者有无用户管理修改权限
			if("admin".equals(pd.getString("USERNAME")) && !"admin".equals(Jurisdiction.getUsername())){return null;}	//非admin用户不能修改admin
		}
		String D_ID = pd.getString("D_ID");
		String C_ID = pd.getString("C_ID");
		String P_ID = pd.getString("P_ID");
		String DID = pd.getString("DID");
		String CID = pd.getString("CID");
		String PID = pd.getString("PID");
		if(D_ID != null && !"".equals(D_ID)){
			pd.put("D_ID", D_ID);
		}else{
			pd.put("D_ID", DID);
		}
		if(P_ID != null && !"".equals(P_ID)){
			pd.put("P_ID", P_ID);
		}else{
			pd.put("P_ID", PID);
		}
		if(C_ID != null && !"".equals(C_ID)){
			pd.put("C_ID", C_ID);
		}else{
			pd.put("C_ID", CID);
		}
		pd.put("D_NAME", g.getD_NAME());
		pd.put("C_BRAND", g.getC_BRAND());
		pd.put("C_WEIGHT", Integer.valueOf(g.getC_WEIGHT()));
		pd.put("P_COUNT", Integer.valueOf(g.getP_COUNT()));
		pd.put("P_MATCOUNT", Integer.valueOf(g.getP_MATCOUNT()));
		pd.put("START_ADDRESS", g.getSTART_ADDRESS());
		pd.put("ADDRESS", g.getADDRESS());
		goodsService.editU(pd);	//执行修改
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
		logBefore(logger, Jurisdiction.getUsername()+"删除");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STATE", "1");
		goodsService.deleteU(pd);
		edit1(pd);
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
		String PIDS = pd.getString("PIDS");
		if(null != IDS && !"".equals(IDS)){
			String ArrayIDS[] = IDS.split(",");
			String arrayPIDS[] = PIDS.split(",");
			goodsService.deleteAllU(ArrayIDS);
			goodsService.edit3(arrayPIDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 弹出司机选择页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/testPage1")
	public ModelAndView testPage1(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表SIJI");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<Driver> list = goodsService.findByDriverAll(page);
		mv.setViewName("system/Vehicle_management/elect_sj");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 弹出货物选择页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/testPage3")
	public ModelAndView testPage3(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表HW");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("STATE", "1");
		page.setPd(pd);
		List<Picking> list = goodsService.findByMaterialAll(page);
		mv.setViewName("system/Vehicle_management/elect_hw");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 弹出货车选择页面
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/testPage2")
	public ModelAndView testPage2(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表HC");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<Car> list = goodsService.findByCarAll(page);
		mv.setViewName("system/Vehicle_management/elect_hc");
		mv.addObject("varList", list);
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 修改状态为2   派送成功
	 */
	@RequestMapping(value="/yes")
	public ModelAndView yes(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("username", Jurisdiction.getUsername());
		pd = this.getPageData();
		pd.put("STATE", 2);
		Date date = new Date();
		String dateStr = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
		pd.put("END_TIME", dateStr);
		goodsService.ok(pd);	//执行修改
		List<PageData>	goodsList = goodsService.listGoods(page);//列出列表
		mv.setViewName("system/Vehicle_management/goods_list");
		mv.addObject("pd", pd);
		mv.addObject("msg","success");
		mv.addObject("goodsList", goodsList);
		return mv;
	}
	
	/**
	 * 修改状态为1   派送中
	 */
	@RequestMapping(value="/faHuo")
	public ModelAndView faHuo(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("username", Jurisdiction.getUsername());
		pd = this.getPageData();
		pd.put("STATE", 1);
		Date date = new Date();
		String dateStr = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
		pd.put("START_TIME", dateStr);
		goodsService.ps(pd);	//执行修改
		List<PageData>	goodsList = goodsService.listGoods(page);//列出列表
		mv.setViewName("system/Vehicle_management/goods_list");
		mv.addObject("pd", pd);
		mv.addObject("msg","success");
		mv.addObject("goodsList", goodsList);
		return mv;
	}
	
	/**
	 * 时间类型绑定
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
}
