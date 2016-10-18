package com.financetracker.controller;

import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.SavingItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;
import com.financetracker.model.SavingItem;
import com.financetracker.model.SavingItemDAO;
import com.financetracker.model.User;

@Controller
public class SavingItemsController {

	@RequestMapping(value = "/savingItems", method = RequestMethod.GET)
	public String loadBudgetPage(Model model, HttpSession session) throws SavingItemException, UserException {
		
		User user = (User) session.getAttribute("user");

		model.addAttribute("user", user);

		model.addAttribute("savingItem", new SavingItem());
		
		TreeSet<SavingItem> savingItems = new SavingItemDAO().getSavingItemsByUserId(user.getId());

		model.addAttribute("savingItems", savingItems);
		
		return "savingItems";
	}

	@RequestMapping(value = "/savingItems", method = RequestMethod.POST)
	public String addSavingItemForm(Model model, @ModelAttribute("savingItem") SavingItem item, BindingResult result,
			HttpSession session) throws BudgetItemException, TransactionException, UserException {

		if (result.hasErrors()) {

			model.addAttribute("user", session.getAttribute("user"));

			return "savingItems";
		} else {

			try {
				User user = (User) session.getAttribute("user");
				
				new SavingItemDAO().addSavingItem(user, item);
				
				//item.setId(id);

			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("sItem" + item.getId(), item);

			return "redirect:savingItems";
		}
	}
	
	  @RequestMapping(value = "/deleteSavingItem", method = RequestMethod.POST)
	    public String deleteSavingItemForm(@RequestParam("deletedItemName") String itemName, @RequestParam("deletedItemDesc") String itemDesc,@RequestParam("deletedItemPrice") int itemPrice, HttpSession session) throws SavingItemException {
		   
		   try {
			   User user = (User) session.getAttribute("user");
			   
			new SavingItemDAO().deleteSavingItem(itemName, itemDesc, itemPrice, user.getId());
			
		} catch (UserException e) {

		throw new SavingItemException("Saving item cannot be deleted right now! ");
		}
		   
	        return "forward:savingItems";
	    }
	}
