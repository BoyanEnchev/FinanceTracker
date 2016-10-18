package com.financetracker.controller;

import java.time.LocalDate;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;
import com.financetracker.model.BudgetItem;
import com.financetracker.model.BudgetItemDAO;
import com.financetracker.model.Transaction;
import com.financetracker.model.User;

@Controller
public class BudgetController {

	@RequestMapping(value = "/budget", method = RequestMethod.GET)
	public String loadBudgetPage(Model model, HttpSession session)
			throws BudgetItemException, UserException, TransactionException {

		if (((User)(session.getAttribute("user"))).getId() == 0) {
			return "redirect: index";
		} else {
			
			BudgetItem item = new BudgetItem();
			Transaction transaction = new Transaction();

			int userID = ((User) session.getAttribute("user")).getId();

			Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new BudgetItemDAO()
					.getBudgetItemsAndTransactionsByUserID(userID, LocalDate.now().minusMonths(1).toString(),
							LocalDate.now().toString());

			ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

			TreeSet<String> incomeCategories = (TreeSet<String>) BudgetItem.getIncomeCategories();
			TreeSet<String> expenseCategories = (TreeSet<String>) BudgetItem.getExpenseCategories();

			Map<String, LinkedList<Transaction>> itemsNamesTransValues = new HashMap<>();
			itemsTransactionsMap
					.forEach((budgetItem, list) -> itemsNamesTransValues.put(budgetItem.getCategory(), list));

			int actual = 0;
			int budgeted = 0;
			int income = 0;

			for (BudgetItem budgetItem : budgetItems) {
				if (!budgetItem.isExpOrInc()) {
					budgeted += budgetItem.getPlannedMoney();
					actual += budgetItem.getPayedMoney();
				} else {
					income += budgetItem.getPlannedMoney();
				}
			}

			model.addAttribute("item", item);
			model.addAttribute("income", income);
			model.addAttribute("actual", actual);
			model.addAttribute("budgeted", budgeted);
			model.addAttribute("transaction", transaction);
			model.addAttribute("budgetItems", budgetItems);
			model.addAttribute("incomeCategories", incomeCategories);
			model.addAttribute("expenseCategories", expenseCategories);
			model.addAttribute("itemsNamesTransValues", itemsNamesTransValues);
			model.addAttribute("editedTransaction", new Transaction());

			session.setMaxInactiveInterval(-1);

			return "budget";
		}
	}

	@RequestMapping(value = "/budget", method = RequestMethod.POST)
	public String addBudgetItemForm(Model model, @ModelAttribute("item") BudgetItem item, BindingResult result,
			HttpSession session) throws BudgetItemException, TransactionException, UserException {

		if (result.hasErrors()) {
			BudgetItem item1 = new BudgetItem();
			Transaction transaction = new Transaction();

			int userID = ((User) session.getAttribute("user")).getId();
			
			Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new BudgetItemDAO()
					.getBudgetItemsAndTransactionsByUserID(userID, LocalDate.now().minusMonths(1).toString(),
							LocalDate.now().toString());

			ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

			model.addAttribute("budgetItems", budgetItems);

			int actual = 0;
			int budgeted = 0;
			int income = 0;

			for (BudgetItem budgetItem : budgetItems) {
				if (!budgetItem.isExpOrInc()) {
					budgeted += budgetItem.getPlannedMoney();
					actual += budgetItem.getPayedMoney();
				} else {
					income += budgetItem.getPlannedMoney();
				}
			}

			model.addAttribute("item", item1);
			model.addAttribute("transaction", transaction);
			model.addAttribute("income", income);
			model.addAttribute("actual", actual);
			model.addAttribute("budgeted", budgeted);
			model.addAttribute("editedTransaction", new Transaction());

			return "budget";
		} else {

			try {
				User user = (User) session.getAttribute("user");

				new BudgetItemDAO().addBudgetItem(user.getId(), item);
			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("item" + item.getId(), item);

			return "redirect:budget";
		}
	}

	@RequestMapping(value = "/deleteBudgetItem", method = RequestMethod.POST)
	public String deleteBudgetItemForm(@RequestParam("deleted") int itemID) {

		try {
			new BudgetItemDAO().deleteBudgetItem(itemID);

		} catch (UserException e) {

			e.printStackTrace();
		}

		return "forward:budget";
	}

	@RequestMapping(value = "/listBudgetItems", method = RequestMethod.GET)
	public String searchBudgetItems(Model model, @RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate, HttpSession session)
			throws BudgetItemException, TransactionException, UserException {

		BudgetItem item = new BudgetItem();
		Transaction transaction = new Transaction();

		int userID = ((User) (session.getAttribute("user"))).getId();

		Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new BudgetItemDAO()
				.getBudgetItemsAndTransactionsByUserID(userID, startDate,
					endDate);

		ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

		TreeSet<String> incomeCategories = (TreeSet<String>) BudgetItem.getIncomeCategories();
		TreeSet<String> expenseCategories = (TreeSet<String>) BudgetItem.getExpenseCategories();

		Map<String, LinkedList<Transaction>> itemsNamesTransValues = new HashMap<>();
		itemsTransactionsMap.forEach((budgetItem, list) -> itemsNamesTransValues.put(budgetItem.getCategory(), list));

		int actual = 0;
		int budgeted = 0;
		int income = 0;

		for (BudgetItem budgetItem : budgetItems) {
			if (!budgetItem.isExpOrInc()) {
				budgeted += budgetItem.getPlannedMoney();
				actual += budgetItem.getPayedMoney();
			} else {
				income += budgetItem.getPlannedMoney();
			}
		}

		model.addAttribute("item", item);
		model.addAttribute("income", income);
		model.addAttribute("actual", actual);
		model.addAttribute("budgeted", budgeted);
		model.addAttribute("transaction", transaction);
		model.addAttribute("budgetItems", budgetItems);
		model.addAttribute("incomeCategories", incomeCategories);
		model.addAttribute("expenseCategories", expenseCategories);
		model.addAttribute("itemsNamesTransValues", itemsNamesTransValues);
		model.addAttribute("editedTransaction", new Transaction());

		session.setMaxInactiveInterval(-1);

		return "budget";
	}

}
