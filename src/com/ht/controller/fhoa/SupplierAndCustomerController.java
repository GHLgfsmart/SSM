package com.ht.controller.fhoa;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.ht.controller.base.BaseController;
import com.ht.entity.Customer_categories;
import com.ht.entity.Page;
import com.ht.service.fhoa.SupplierAndCustomerManager;
import com.ht.service.fhoa.impl.CategoriesService;
import com.ht.service.system.impl.UserService;
import com.ht.util.Const;
import com.ht.util.FileDownload;
import com.ht.util.FileUpload;
import com.ht.util.Jurisdiction;
import com.ht.util.ObjectExcelRead;
import com.ht.util.ObjectExcelView;
import com.ht.util.PageData;
import com.ht.util.PathUtil;

@Controller
@RequestMapping(value="/supplierAndcustomer")
public class SupplierAndCustomerController extends BaseController{
	
	@Resource(name="userService")
	private UserService userService;
	@Resource(name="categoriesService")
	private CategoriesService categoriesService;
	String menuUrl = "supplierAndcustomer/list.do"; //菜单地址(权限用)
	
	@Resource(name="supplierAndCustomerService")
	private SupplierAndCustomerManager service;
	
	/**
	 * 列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表supplierAndCustomer");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String CATEGORIES_ID = null == pd.get("CATEGORIES_ID")?"":pd.get("CATEGORIES_ID").toString();
		if(null != pd.get("CATEGORIES_ID") && !"".equals(pd.get("CATEGORIES_ID").toString())){
			CATEGORIES_ID = pd.get("CATEGORIES_ID").toString();
		}
		pd.put("CATEGORIES_ID", CATEGORIES_ID);
		System.out.println("===========================");
		System.out.println("pd:"+pd.toString());
		List<Customer_categories> categoriesList=categoriesService.findAllName();
		mv.addObject("list",categoriesList);
		page.setPd(pd);
		List<PageData>	varList = service.list(page);
		System.out.println("varList.size:"+varList.size());
		mv.addObject("varList", varList);
		mv.setViewName("fhoa/supplierAndcustomer/list");
		mv.addObject("QX",Jurisdiction.getHC());				//按钮权限
		return mv;
	}
	
	/**进入修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goUpdate")
	public ModelAndView goUpdate()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", Jurisdiction.getUsername());
		PageData obj = service.findById(pd);	//根据ID读取
		String USER_ID=obj.getString("USER_ID");
		String address=obj.getString("ADDRESS");
		String add[] = address.split(",");
		System.out.println("ADDRESS:"+address);
		pd.put("USER_ID",USER_ID);
		String ID=pd.getString("ID");
		pd.put("ID",ID);
		List<Customer_categories> categoriesList=categoriesService.findAllName();
		mv.addObject("list",categoriesList);
		mv.addObject("obj",obj);
		mv.addObject("address",add);
		mv.addObject("pd", pd);					
		mv.setViewName("fhoa/supplierAndcustomer/save");
		mv.addObject("msg", "edit");
		return mv;
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改supplierAndCustomer");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
		String dj = sdf.format(new Date());
		pd.put("UPDATE_TIME",dj);
		service.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 
	 * 删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除supplierAndCustomer");
		PageData pd = new PageData();
		pd = this.getPageData();
		service.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**
	 * 批量删除
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	public void deleteAll(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"SUPPLIER_CATEGOIES批量删除");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String IDS = pd.getString("IDS");
		if(null != IDS && !"".equals(IDS)){
			String ArrayDATA_IDS[] = IDS.split(",");
			service.deleteAll(ArrayDATA_IDS);
			out.write("success");
		}else {
			out.write("fail");
		}
		out.close();
	}
	
	/**
	 * 
	 * 详细信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/gofindByID")
	public ModelAndView gofindByID()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData zl=service.findById(pd);
		mv.addObject("obj",zl);
		mv.setViewName("fhoa/supplierAndcustomer/zl");
		return mv;
	}
	
	/**进入新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		List<Customer_categories> categoriesList=categoriesService.findAllName();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("USERNAME", Jurisdiction.getUsername());
		mv.addObject("list",categoriesList);
		mv.addObject("pd",pd);
		mv.setViewName("fhoa/supplierAndcustomer/save");
		mv.addObject("msg", "save");
		return mv;
	}
	/**
	 * 新增
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增supplierAndCustomer");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData user=new PageData();//存储当前登录人信息
		user.put("USERNAME", Jurisdiction.getUsername());
		user=userService.findByUsername(user);
		String user_id=user.getString("USER_ID");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/HH:mm:ss");
		String dj = sdf.format(new Date());
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID());	//主键
		pd.put("USER_ID", user_id);
		pd.put("ENTRY_TIME", dj);//录入时间
		pd.put("BIANHAO", null);
		service.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 导出Excel表格
	 * @return
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){
				String keywords = pd.getString("keywords");				//关键词检索条件
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", keywords.trim());
				}
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("名称");//1
				titles.add("简码");//2
				titles.add("类型");//3
				titles.add("联系人");//4
				titles.add("联系电话");//5
				titles.add("地址");//6
				titles.add("网站地址");//7
				titles.add("传真");//8
				titles.add("邮箱");//9
				titles.add("开户行");//10
				titles.add("银行账号");//11
				titles.add("企业税号");//12
				titles.add("状态");//13
				titles.add("备注");//14
				titles.add("操作员");//15
				titles.add("录入时间");//16
				titles.add("最后修改时间");//17
				dataMap.put("titles", titles);
				List<PageData> userList = service.findBy(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<userList.size();i++){
					System.out.println("USER.LIST.:"+userList.get(i).toString());
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("SUPNAME"));//1
					vpd.put("var2", userList.get(i).getString("PINYIN"));//2
					vpd.put("var3", userList.get(i).getString("NAME"));//3
					vpd.put("var4", userList.get(i).getString("CONTACT"));//4
					vpd.put("var5", userList.get(i).getString("PHONE"));//17   5
					vpd.put("var6", userList.get(i).getString("ADDRESS"));//5
					vpd.put("var7", userList.get(i).getString("SITE_ADDRESS"));//6
					vpd.put("var8", userList.get(i).getString("FAX_PHONE"));//7
					vpd.put("var9", userList.get(i).getString("MAIL"));	//8
					vpd.put("var10", userList.get(i).getString("OPEN_ACCOUNT"));//9
					vpd.put("var11", userList.get(i).getString("BANK"));//10
					vpd.put("var12", userList.get(i).getString("EIN"));	//11
					String state=userList.get(i).get("STATE")+"";
					if(state.equals("0")){
						vpd.put("var13", "开启");	//12
					}else{
						vpd.put("var13", "关闭");	//12
					}
					vpd.put("var14", userList.get(i).getString("NOTE"));//13
					vpd.put("var15", userList.get(i).getString("USERNAME"));//14
					vpd.put("var16", userList.get(i).getString("ENTRY_TIME"));//15
					vpd.put("var17", userList.get(i).getString("UPDATE_TIME"));//16
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
}
