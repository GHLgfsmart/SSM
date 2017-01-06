package com.ht.controller.fhdb;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Page;
import com.ht.service.fhdb.impl.DrawingServiceImpl;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;

@Controller
@RequestMapping(value = "/Drawing")
public class DrawingController extends BaseController {
	String menuUrl = "Drawing/ListDrawing.do"; // 菜单地址(权限用)

	@Resource(name = "drawingServiceImpl")
	private DrawingServiceImpl drawingServiceImpl;

	/**
	 * 弹出添加页面并查询仓库名和和经手人和产品
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddPage")
	public ModelAndView goAddPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		logBefore(logger, Jurisdiction.getUsername());
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		//生成时间戳做为单据编号
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String db = "DB"+sdf.format(new Date());
		// 生成添加时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = df.format(new Date());
		//查询经手人
		List<PageData> goAddPage = drawingServiceImpl.ListWAndU(page);
		//查询仓库名
		List<PageData> ListWA = drawingServiceImpl.ListWA(page);
		PageData pd = new PageData();
		pd = this.getPageData();
		String ckID = pd.getString("ckID");//关键词检索条件
		if(null != ckID && !"".equals(ckID)){
			pd.put("ckID", ckID.trim());
		}
		page.setPd(pd);
		//查询产品
		List<PageData> sp = drawingServiceImpl.ListProduct(page);
		mv.addObject("db",db);
		mv.addObject("goAddPage", goAddPage);
		mv.addObject("ListWA", ListWA);
		mv.addObject("spList",sp);
		mv.addObject("pd", pd);
		mv.addObject("addtime",addtime);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("msg", "DrawingAdd");
		mv.setViewName("fhdb/Drawing/ListWAndU");
		return mv;
	}
	
	/**
	 * @author Mr.Lin
	 * 调拨新增
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/DrawingAdd")
	public ModelAndView warehousingAdd(Page page,HttpServletResponse response)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增调拨单");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		pd.get("ENTRY_TIME");
		System.out.println("添加单的时间:"+pd.get("ENTRY_TIME"));
		pd.getString("INSPECTOR");
		pd.getString("BIANHAO");
		pd.get("BusinessDate");
		pd.getString("JINGSHUO_ID");
		pd.getString("WAREHOUSE_OUT_ID");
		pd.getString("WAREHOUSE_PUT_ID");
		pd.getString("DRAWING_INST");
		pd.getString("MATERIALS_ID");
		//执行添加语句
		drawingServiceImpl.DrawingSave(pd);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 查询所有
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ListDrawing")
	public ModelAndView ListWarehouse(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername()+"列表Materials");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		// 生成添加时间
		 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 String updatetime = df.format(new Date());
		 List<PageData> darList = drawingServiceImpl.drwingList(page);
		 mv.addObject("darList", darList);
		 mv.addObject("pd", pd);
		 mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		 mv.addObject("updatetime",updatetime);
		 mv.setViewName("fhdb/Drawing/ListDrawing");
		 return mv;
	}
	
	/**
	 * 审核
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/Audit")
	public ModelAndView Audits(HttpServletResponse response) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"审核");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		pd.get("STATE");
		pd.getString("AUDITOR");
		pd.get("UPDATE_TIME");
		drawingServiceImpl.Audit(pd);
		response.sendRedirect("/SSM/Drawing/ListDrawing.do");
		return null;
	}
	
	/**
	 * 去审
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/Abolish")
	public ModelAndView Abolish(HttpServletResponse response) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"去审");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		pd.get("STATE");
		pd.getString("AUDITOR");
		pd.get("UPDATE_TIME");
		drawingServiceImpl.Audit(pd);
		response.sendRedirect("/SSM/Drawing/ListDrawing.do");
		return null;
	}
	
	/**批量删除
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deletewar")
	public void delete(HttpServletResponse response) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除");
		PageData pd = new PageData();
		pd = this.getPageData();
		String ID=pd.getString("ID");
		ID = ID.replace(" ", "");
		String[] idsStr = ID.split(",");
		for (int i = 0; i < idsStr.length; i++) {
			drawingServiceImpl.delDraeing(idsStr[i]);
		}
		response.sendRedirect("/SSM/Drawing/ListDrawing.do");
	}
	
	/**
	 * @author Mr.Lin
	 * 弹出调拨修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/DrawingByid")
	public ModelAndView DrawingByid()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = df.format(new Date());
		String ID=pd.getString("ID");
		pd= drawingServiceImpl.DraeingById(ID);
		//查询经手人
		Page page=null;
		List<PageData> goAddPage = drawingServiceImpl.ListWAndU(page);
		mv.addObject("updatetime",updatetime);
		mv.addObject("goAddPage", goAddPage);
		mv.addObject("pd", pd);
		mv.addObject("amend", "updatewar");
		mv.setViewName("fhdb/Drawing/DrawingByid");
		return mv;
	}
	
	/**
	 * 编辑单据
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updatewar")
	public ModelAndView update() throws Exception{
		ModelAndView mv = this.getModelAndView();
		logBefore(logger, Jurisdiction.getUsername()+"编辑单据");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		pd.get("BusinessDate");
		pd.getString("DRAWING_INST");
		pd.get("UPDATE_TIME");
		pd.get("JINGSHUO_ID");
		drawingServiceImpl.updateDraeing(pd);
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 导出数据
	 * 
	 * @return
	 * @throws Exception
	 * @throws Throwable
	 */
	@RequestMapping(value = "/Export")
	public ModelAndView ExportData(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){
			String keywords = pd.getString("keywords");				//关键词检索条件
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
				
			}
			page.setPd(pd);
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("编号");
			titles.add("业务日期");
			titles.add("录入时间");
			titles.add("最后修改时间");
			titles.add("经手人");
			titles.add("调拔说明");
			titles.add("状态"); 
			titles.add("操作员");
			titles.add("审核人");
			titles.add("调出仓库");
			titles.add("调入仓库");
			dataMap.put("titles", titles);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
			List<PageData> darList = drawingServiceImpl.drwingList(page);
			List<PageData> varList = new ArrayList<PageData>();
			for (PageData i : darList) {
				PageData vpd = new PageData();
				vpd.put("var1", i.getString("BIANHAO"));
				vpd.put("var2", i.getString("BusinessDate"));
				vpd.put("var3", i.getString("ENTRY_TIME"));
				vpd.put("var4", i.getString("UPDATE_TIME"));
				vpd.put("var5", i.getString("USERNAME"));
				vpd.put("var6", i.getString("DRAWING_INST"));
				String STATE = i.get("STATE") + "";
				vpd.put("var7", STATE+"(0代表未审核,1代表已审核)");
				vpd.put("var8", i.getString("INSPECTOR"));
				vpd.put("var9", i.getString("AUDITOR"));
				vpd.put("var10", i.getString("chu"));
				vpd.put("var11", i.getString("ru"));
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
			mv = new ModelAndView(erv, dataMap);
		}
		return mv;
	}
}