package com.financetracker.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.exception.UserException;
import com.financetracker.model.BudgetItem;
import com.financetracker.model.User;
import com.financetracker.model.UserDAO;

//@Controller
public class AddBudgetItemController {
	/*
	@RequestMapping(value = "/addBudgetItem", method = RequestMethod.GET)
	public String getBudgetItemForm(Model model) {
		
		return "budget";
	}
*/
	/*
	@RequestMapping(value = "/addBudgetItem", method = RequestMethod.POST)
	public String addBudgetItemForm(Model model, @ModelAttribute("item") BudgetItem item, BindingResult result, HttpSession session) {
	
	
	
		if (result.hasErrors()) {
			return "budget";
		} else {
			try {
				User user = (User) session.getAttribute("user");
				new UserDAO().addBudgetItem(user, item);
			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("item" + item.getId(), item);
			return "budget";
		}
	}
	*/

}
