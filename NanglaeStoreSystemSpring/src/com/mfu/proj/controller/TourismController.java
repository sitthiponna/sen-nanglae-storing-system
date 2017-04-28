package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.Tourism;
import com.proj.ejb.face.TourismService;
import com.proj.ejb.face.VillageService;

@Controller
public class TourismController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//TourismServiceBean!com.proj.ejb.face.TourismService")
	TourismService tourServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listTourism")
	public @ResponseBody List<Tourism> listTourism(HttpServletRequest request) {

		List<Tourism> tourList = null;
		try {
			tourList = tourServ.listAllTourism();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tourList;
	}

	@RequestMapping("/saveTourism")
	public @ResponseBody String saveTourism(@RequestBody Tourism tourism, HttpServletRequest request) {
		String tour = request.getParameter("id");
		try {
			if (tourism.getTour_id() == 0) {
				tourism.setLocation(vilServ.findVillageById(Long.parseLong(tour)));
				tourServ.save(tourism);

			} else {
				tourism.setLocation(vilServ.findVillageById(Long.parseLong(tour)));
				tourServ.update(tourism);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteTourism")
	public @ResponseBody String deleteTourism(@RequestBody Tourism tourism) {

		try {
			if (tourism.getTour_id() != 0) {
				tourServ.delete(tourism.getTour_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findTourism")
	public @ResponseBody Tourism findTourism(@RequestBody Tourism tourism) {
		Tourism result = null;
		try {

			result = tourServ.findTourismById(tourism.getTour_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/tourism",method=RequestMethod.GET)
	public ModelAndView displayTourism(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("tourism");
		
		return model;
	}
	@RequestMapping(value="/nonTourism",method=RequestMethod.GET)
	public ModelAndView displaynonTourism(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("nonTourism");
		
		return model;
	}
}
