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

import com.proj.ejb.entity.Electricity;
import com.proj.ejb.face.ElectricityService;
import com.proj.ejb.face.VillageService;

@Controller
public class ElectricityController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ElectricityServiceBean!com.proj.ejb.face.ElectricityService")
	ElectricityService elecServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;

	@RequestMapping("/listElectricity")
	public @ResponseBody List<Electricity> listElectricity(HttpServletRequest request) {

		List<Electricity> elecList = null;
		try {
			elecList = elecServ.listAllElectricity();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return elecList;
	}

	@RequestMapping("/saveElectricity")
	public @ResponseBody String saveElectricity(@RequestBody Electricity electricity, HttpServletRequest request) {

		String elec = request.getParameter("id");

		try {

			if (electricity.getElec_id() == 0) {
				electricity.setLocation(vilServ.findVillageById(Long.parseLong(elec)));
				elecServ.save(electricity);

			} else {
				electricity.setLocation(vilServ.findVillageById(Long.parseLong(elec)));
				elecServ.update(electricity);
			}
		} catch (Exception e) {

			e.printStackTrace();
			return "-1";
		}

		return "1";
	}

	@RequestMapping("/deleteElectricity")
	public @ResponseBody String deleteCommerce(@RequestBody Electricity electricity) {

		try {
			if (electricity.getElec_id() != 0) {
				elecServ.delete(electricity.getElec_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findElectricity")
	public @ResponseBody Electricity findElectricity(@RequestBody Electricity electricity) {
		Electricity result = null;
		try {

			result = elecServ.findElectricityById(electricity.getElec_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/electric",method=RequestMethod.GET)
	public ModelAndView displayElectricity(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("electric");
		
		return model;
	}
}
