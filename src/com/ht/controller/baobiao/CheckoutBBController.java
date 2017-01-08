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
import com.ht.entity.Checkout;
import com.ht.service.fhdb.WarehousingManager;

@Controller
@RequestMapping("/checkout")
public class CheckoutBBController extends BaseController{
	
	String menuUrl = "checkout/barChar.do"; //菜单地址(权限用)
	
	@Resource(name="warehousingService")
	private WarehousingManager warehousingService;
	
	@RequestMapping("/barChar")
	@ResponseBody
	public ModelAndView barChar(HttpSession session) throws Exception {
		ModelAndView mv = this.getModelAndView();
		try{
			
			List<Checkout> list1 = warehousingService.barChar1();
			Iterator<Checkout> iterator1 = list1.iterator();
			List<Checkout> list2 = warehousingService.barChar2();
			Iterator<Checkout> iterator2 = list2.iterator();
			//String []months = {"前15天","后15天"};
			//前15天的数据
			String data3="[";
			String data4="[";
			String data5="[";
			String data6="[";
			for (int i = 0, j = list1.size(); i < j; i++ ) {
				Checkout ck = (Checkout) iterator1.next();
				data3 += ck.getQUANTITY();//总数量
				data4 += ck.getDAMAGEDQTY();//坏货数量
				data5 += ck.getSHORTQTY();//缺货数量
				data6 += ck.getQUANTITY() - (ck.getDAMAGEDQTY()+ck.getSHORTQTY());//入库多少
			}
			//后15天的数据
			for (int i = 0, j = list2.size(); i < j; i++ ) {
				Checkout ck = (Checkout) iterator2.next();
				data3 += ","+ck.getQUANTITY();//总数量
				data4 += ","+ ck.getDAMAGEDQTY();//坏货数量
				data5 += ","+ ck.getSHORTQTY();//缺货数量
				data6 += ","+ (ck.getQUANTITY() - (ck.getDAMAGEDQTY()+ck.getSHORTQTY()));//入库多少
			}
			mv.addObject("data3", data3+"]");
			mv.addObject("data4", data4+"]");
			mv.addObject("data5", data5+"]");
			mv.addObject("data6", data6+"]");
			mv.setViewName("system/output/checkOutBB");
		}catch(Exception e){
			e.getStackTrace();
			mv.setViewName("404");
		}

			
		return mv;
	}

}
