package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proj.ejb.entity.Inventory;
import com.proj.ejb.face.InventoryService;
@Controller
public class InventoryController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//InventoryServiceBean!com.proj.ejb.face.InventoryService")
	InventoryService ivnServ;

	@RequestMapping("/listInventory")
	public @ResponseBody List<Inventory> listInventory(HttpServletRequest request) {

		List<Inventory> ivnList = null;
		try {
			ivnList = ivnServ.listAllInventory();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ivnList;
	}

	@RequestMapping("/saveInventory")
	public @ResponseBody String saveInventory(@RequestBody Inventory inventory) {
		try {
			if (inventory.getIvn_id() == 0) {
				ivnServ.save(inventory);

			} else {
				ivnServ.update(inventory);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteInventory")
	public @ResponseBody String deleteInventory(@RequestBody Inventory inventory) {

		try {
			if (inventory.getIvn_id() != 0) {
				ivnServ.delete(inventory.getIvn_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findInventory")
	public @ResponseBody Inventory findInventory(@RequestBody Inventory inventory) {
		Inventory result = null;
		try {

			result = ivnServ.findInventoryById(inventory.getIvn_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
}