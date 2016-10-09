package com.financetracker.controller;

import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.SavingItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;
import com.financetracker.model.SavingItem;
import com.financetracker.model.User;
import com.financetracker.model.UserDAO;

@Controller
public class SavingItemsController {

	@RequestMapping(value = "/savingItems", method = RequestMethod.GET)
	public String loadBudgetPage(Model model, HttpSession session) throws SavingItemException, UserException {
		
		User user = (User) session.getAttribute("user");

		model.addAttribute("user", user);

		model.addAttribute("savingItem", new SavingItem());
		
		TreeSet<SavingItem> savingItems = new UserDAO().getSavingItemsByUserId(user.getId());

		model.addAttribute("savingItems", savingItems);
		
		return "savingItems";
	}

	@RequestMapping(value = "/savingItems", method = RequestMethod.POST)
	public String addBudgetItemForm(Model model, @ModelAttribute("savingItem") SavingItem sItem, BindingResult result,
			HttpSession session) throws BudgetItemException, TransactionException, UserException {

		if (result.hasErrors()) {

			model.addAttribute("user", session.getAttribute("user"));

			SavingItem savingItem = new SavingItem();

			model.addAttribute("savingItem", savingItem);

			return "savingItems";
		} else {

			try {
				User user = (User) session.getAttribute("user");

				Integer id = new UserDAO().addSavingItem(user, sItem);

				sItem.setId(id);

			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("sItem" + sItem.getId(), sItem);

			return "redirect:savingItems";
		}
	}
}
