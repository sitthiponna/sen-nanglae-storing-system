package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.User;
import com.proj.ejb.entity.Water;
import com.proj.ejb.face.VillageService;
import com.proj.ejb.face.WaterService;

@Controller
public class WaterController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//WaterServiceBean!com.proj.ejb.face.WaterService")
	WaterService wtServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listWater")
	public @ResponseBody List<Water> listWater(HttpServletRequest request) {

		List<Water> wtList = null;
		try {
			wtList = wtServ.listAllWater();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return wtList;
	}

	@RequestMapping("/saveWater")
	public @ResponseBody String saveWater(@RequestBody Water water, HttpServletRequest request) {

		String wt = request.getParameter("id");
		try {
			if (water.getWater_id() == 0) {
				water.setLocation(vilServ.findVillageById(Long.parseLong(wt)));
				wtServ.save(water);

			} else {
				water.setLocation(vilServ.findVillageById(Long.parseLong(wt)));
				wtServ.update(water);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteWater")
	public @ResponseBody String deleteWater(@RequestBody Water water) {

		try {
			if (water.getWater_id() != 0) {
				wtServ.delete(water.getWater_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findWater")
	public @ResponseBody Water findWater(@RequestBody Water water) {
		Water result = null;
		try {

			result = wtServ.findWaterById(water.getWater_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userWaterresource",method=RequestMethod.GET)
	public ModelAndView displayuserWaterresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userWaterresource");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
	@RequestMapping(value="/nonWaterresource",method=RequestMethod.GET)
	public ModelAndView displaynonWaterresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
	
					ModelAndView model = new ModelAndView("nonWaterresource");
					return model;
		}
	@RequestMapping(value="/superWaterresource",method=RequestMethod.GET)
	public ModelAndView displaysuperWaterresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superWaterresource");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
}
