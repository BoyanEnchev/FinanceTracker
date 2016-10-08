package com.financetracker.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;
import com.financetracker.model.BudgetItem;
import com.financetracker.model.Transaction;
import com.financetracker.model.User;
import com.financetracker.model.UserDAO;

@Controller
public class BudgetController {

	@RequestMapping(value = "/budget", method = RequestMethod.GET)
	public String loadBudgetPage(Model model, HttpSession session)
			throws BudgetItemException, UserException, TransactionException {
		/*
		 * if (session.getAttribute("user") == null) { return "redirect: index";
		 * } else {
		 */
		BudgetItem item = new BudgetItem();
		// BudgetItem item1 = new BudgetItem();
		Transaction transaction = new Transaction();
		model.addAttribute("item", item);
		// model.addAttribute("item1", item1);
		model.addAttribute("transaction", transaction);

		int userID = ((User) session.getAttribute("user")).getId();
		Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new UserDAO()
				.getBudgetItemsAndTransactionsByUserID(userID);

		ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

		TreeSet<String> incomeCategories = (TreeSet<String>) BudgetItem.getIncomeCategories();
		TreeSet<String> expenseCategories = (TreeSet<String>) BudgetItem.getExpenseCategories();

		Map<String, LinkedList<Transaction>> itemsNamesTransValues = new HashMap<>();
		itemsTransactionsMap.forEach((budgetItem, list) -> itemsNamesTransValues.put(budgetItem.getCategory(), list));

		itemsNamesTransValues.forEach((k, v) -> System.out.println(v));

		model.addAttribute("budgetItems", budgetItems);
		model.addAttribute("incomeCategories", incomeCategories);
		model.addAttribute("expenseCategories", expenseCategories);
		model.addAttribute("itemsNamesTransValues", itemsNamesTransValues);

		session.setMaxInactiveInterval(-1);

		return "budget";
	}

	@RequestMapping(value = "/budget", method = RequestMethod.POST)
	public String addBudgetItemForm(Model model, @ModelAttribute("item") BudgetItem item, BindingResult result,
			HttpSession session) throws BudgetItemException, TransactionException, UserException {

		if (result.hasErrors()) {
			BudgetItem item1 = new BudgetItem();
			// BudgetItem item1 = new BudgetItem();
			Transaction transaction = new Transaction();
			model.addAttribute("item", item1);
			// model.addAttribute("item1", item1);
			model.addAttribute("transaction", transaction);

			int userID = ((User) session.getAttribute("user")).getId();
			Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new UserDAO()
					.getBudgetItemsAndTransactionsByUserID(userID);

			ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

			model.addAttribute("budgetItems", budgetItems);

			return "budget";
		} else {

			try {
				User user = (User) session.getAttribute("user");

				new UserDAO().addBudgetItem(user.getId(), item);
			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("item" + item.getId(), item);

			return "redirect:budget";
		}
	}
	/*
	 * @RequestMapping(value = "/budget1", method = RequestMethod.POST) public
	 * String addExpenseItemForm(Model model, @ModelAttribute("item1")
	 * BudgetItem item1, BindingResult result, HttpSession session) {
	 * 
	 * if (result.hasErrors()) { return "budget"; } else {
	 * 
	 * try { User user = (User) session.getAttribute("user");
	 * System.err.println(user);
	 * 
	 * new UserDAO().addBudgetItem(user.getId(), item1); } catch (UserException
	 * e) { model.addAttribute("error", e); } session.setAttribute("item1" +
	 * item1.getId(), item1);
	 * 
	 * return "redirect:budget"; } }
	 */
}
