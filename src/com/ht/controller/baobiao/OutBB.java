package com.ht.controller.baobiao;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ht.controller.base.BaseController;
import com.ht.entity.Picking;
import com.ht.service.fhdb.WarehousingManager;

@Controller
@RequestMapping("/outBB")
public class OutBB extends BaseController{

	String menuUrl = "outBB/barChar.do"; //菜单地址(权限用)
	
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	
	@RequestMapping("/barChar")
	@ResponseBody
	public ModelAndView barChar(HttpSession session) throws Exception {
		ModelAndView mv = this.getModelAndView();
		try{
		List<Picking> list1 = warehousingService.barChar3();
		Iterator<Picking> iterator1 = list1.iterator();
		List<Picking> list2 = warehousingService.barChar4();
		Iterator<Picking> iterator2 = list2.iterator();
		//String []months = {"前15天","后15天"};
		//前15天的数据
		String data3="[";
		for (int i = 0, j = list1.size(); i < j; i++ ) {
			Picking ck = (Picking) iterator1.next();
			data3 += ck.getCOUNT();//总数量
		}
		//后15天的数据
		for (int i = 0, j = list2.size(); i < j; i++ ) {
			Picking ck = (Picking) iterator2.next();
			data3 += ","+ck.getCOUNT();//总数量
		}
		mv.addObject("data3", data3+"]");
		mv.setViewName("system/output/outBB");
		mv.addObject("msg","success");
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("404");
		}
		return mv;
	}
	
}
