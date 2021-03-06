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

import com.proj.ejb.entity.Forest;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ForestService;
import com.proj.ejb.face.VillageService;

@Controller
public class ForestController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ForestServiceBean!com.proj.ejb.face.ForestService")
	ForestService frsServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listForest")
	public @ResponseBody List<Forest> listForest(HttpServletRequest request) {

		List<Forest> frsList = null;
		try {
			frsList = frsServ.listAllForest();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return frsList;
	}

	@RequestMapping("/saveForest")
	public @ResponseBody String saveForest(@RequestBody Forest forest, HttpServletRequest request) {

		String frs = request.getParameter("id");

		try {

			if (forest.getFrs_id() == 0) {
				forest.setLocation(vilServ.findVillageById(Long.parseLong(frs)));
				frsServ.save(forest);

			} else {
				forest.setLocation(vilServ.findVillageById(Long.parseLong(frs)));
				frsServ.update(forest);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteForest")
	public @ResponseBody String deleteForest(@RequestBody Forest forest) {

		try {
			if (forest.getFrs_id() != 0) {
				frsServ.delete(forest.getFrs_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findForest")
	public @ResponseBody Forest findForest(@RequestBody Forest forest) {
		Forest result = null;
		try {

			result = frsServ.findForestById(forest.getFrs_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userForestresource",method=RequestMethod.GET)
	public ModelAndView displayuserForestresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userForestresource");
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
	@RequestMapping(value="/nonForestresource",method=RequestMethod.GET)
	public ModelAndView displaynonForestresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonForestresource");
					return model;
		}
	@RequestMapping(value="/superForestresource",method=RequestMethod.GET)
	public ModelAndView displaysuperForestresource(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superForestresource");
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
