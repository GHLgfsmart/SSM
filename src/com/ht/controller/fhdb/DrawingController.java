package com.ht.controller.fhdb;
import java.io.PrintWriter;
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
import com.ht.entity.Materials_information;
import com.ht.entity.Page;
import com.ht.service.fhdb.impl.DrawingServiceImpl;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;
import com.sun.xml.internal.bind.v2.model.core.ID;

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
	 * 调拨新增
	 * @throws Exception
	 * @return
	 */
	@RequestMapping(value="/DrawingAdd")
	public ModelAndView warehousingAdd(Page page,HttpServletResponse response)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增调拨单");
		ModelAndView mv = this.getModelAndView();
		//修改数量
		PageData pds = new PageData();
		pds = this.getPageData();
		pds.get("COUNT");
		pds.getString("MATERIALS_ID");
		drawingServiceImpl.reduce(pds);
		
		//把调出的物资调入到另一个仓库
		PageData pad = new PageData();
		pad = this.getPageData();
		pad.put("ID", this.get32UUID());	//主键
		pad.getString("BIANHAO");
		pad.getString("NAME");
		pad.get("COUNT");
		pad.getString("UNIT");
		pad.getString("NOTE");
		pad.get("STATE");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String addtime = df.format(new Date());
		pad.put("ENTRY_TIME", addtime);
		drawingServiceImpl.SaveWz(pad);
		//调入到另一个仓库
	    PageData pada = new PageData();
	    pada = this.getPageData();
	    pada.put("ID", this.get32UUID());	//主键
	    pada.put("MATERIALS_ID", pad.getString("ID"));
	    pada.put("STATE", 4);
	    SimpleDateFormat sj = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = sj.format(new Date());
	 	pad.put("ENTRY_TIME", time);
	    pada.getString("WAREHOUSE_PUT_ID");
	    drawingServiceImpl.SaveCk(pada);

		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		pd.get("ENTRY_TIME");
		pd.get("COUNT");
		pd.getString("INSPECTOR");
		pd.getString("DBbIANHAO");
		pd.get("BusinessDate");
		pd.getString("JINGSHUO_ID");
		pd.getString("WAREHOUSE_OUT_ID");
		pd.getString("WAREHOUSE_PUT_ID");
		pd.getString("DRAWING_INST");
		pd.getString("MATERIALS_ID");
		//执行添加语句
		int result=  drawingServiceImpl.DrawingSave(pd);
		if(result>0) {
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
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
		 mv.addObject("At", "Audit");
		 mv.addObject("As","Abolish");
		 mv.setViewName("fhdb/Drawing/ListDrawing");
		 return mv;
	}
	

	/**
	 * 审核
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/Audit")
	public ModelAndView Audits() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"审核");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		pd.get("STATE");
		pd.getString("AUDITOR");
		pd.get("UPDATE_TIME");
		drawingServiceImpl.Audit(pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 去审
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/Abolish")
	public ModelAndView Abolish() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"去审");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		pd.get("STATE");
		pd.getString("AUDITOR");
		pd.get("UPDATE_TIME");
		drawingServiceImpl.Audit(pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/singleDel")
	public void singleDel(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"调拨删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		int result = drawingServiceImpl.delDraeing(pd);
		if(result>0) {
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	
	/**批量删除
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deletewar")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"调拨删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除");
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS=pd.getString("ID");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0; i<ArrayDATA_IDS.length; i++) {
				pd.put("ID", ArrayDATA_IDS[i]);
				drawingServiceImpl.delDraeing(pd);
			}
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}

	/**
	 * @author Mr.Lin
	 * 弹出调拨修改界面
	 * @throws Exception 
	 * @return
	 * */
	@RequestMapping(value="/DrawingByid")
	public ModelAndView DrawingByid(Page page)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pdda = new PageData();
		pdda = this.getPageData();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updatetime = df.format(new Date());
		String ID=pdda.getString("ID");
		//根据id查询出业务日期,经手人,调拨说明,单据编号,业务日期  
		PageData paa= drawingServiceImpl.DraeingById(ID);
		//查询出全部的经手人
		Page pa=null;
		List<PageData> goAddPage = drawingServiceImpl.ListWAndU(pa);
		//查询出当前的仓库名称
		PageData pds=drawingServiceImpl.DraeingBywname(ID);
		//查询出所有的仓库名
		List<PageData> ListWA = drawingServiceImpl.ListWA(pa);
		
		PageData pd = new PageData();
		pd = this.getPageData();
		String ckID = pd.getString("ckID");
		if(null != ckID && !"".equals(ckID)){
			pd.put("ckID", ckID.trim());
		}
		String mi=pd.getString("MATERIALS_ID");
		if(null != mi && !"".equals(mi)){
			pd.put("MATERIALS_ID", mi.trim());
		}
		page.setPd(pd);
		//根据MATERIALS_ID查询出所在仓库里的物资
		PageData pdID=drawingServiceImpl.byIDPage(page);
		
		//根据ID查询出所在仓库里的所有已入库的物资
		List<PageData> walist = drawingServiceImpl.ListProduct(page);
		
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("updatetime",updatetime);
		mv.addObject("pd", paa);
		mv.addObject("pds", pds);
		mv.addObject("ListWA", ListWA);
		mv.addObject("goAddPage", goAddPage);
		mv.addObject("pdID", pdID);
		mv.addObject("walist", walist);
		mv.addObject("amend", "updatewar");
		mv.addObject("update", "updatewar");
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
		//修改数量
		PageData pds = new PageData();
		pds = this.getPageData();
		pds.get("COUNT");
		pds.getString("MATERIALS_ID");
		drawingServiceImpl.reduce(pds);
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.getString("ID");
		pd.getString("BusinessDate");
		pd.getString("DRAWING_INST");
		pd.getString("UPDATE_TIME");
		pd.getString("WAREHOUSE_OUT_ID");
		pd.getString("WAREHOUSE_PUT_ID");
		pd.getString("MATERIALS_ID");
		pd.getString("JINGSHUO_ID");
		pd.get("COUNT");
		int result=  drawingServiceImpl.updateDraeing(pd); 
		if(result>0) {
			mv.addObject("msg","success");
		}else {
			mv.addObject("msg","fail");
		}
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
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