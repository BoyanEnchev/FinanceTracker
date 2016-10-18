package com.financetracker.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;
import com.financetracker.model.BudgetItem;
import com.financetracker.model.BudgetItemDAO;
import com.financetracker.model.Transaction;
import com.financetracker.model.User;
import com.google.gson.Gson;

@Controller
public class ChartsController {

	@RequestMapping(value = "/charts", method = RequestMethod.GET)
	public String loadBudgetPage(Model model, HttpSession session) throws UserException, BudgetItemException, TransactionException{
	
		int userID = ((User) session.getAttribute("user")).getId();
		

		Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new BudgetItemDAO()
				.getBudgetItemsAndTransactionsByUserID(userID, LocalDate.now().minusMonths(1).toString(), LocalDate.now().toString());

		ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());
		
		String budgetItemsJson = new Gson().toJson(budgetItems);
		
		model.addAttribute("budgetItemsJson", budgetItemsJson);
		
		return "charts";
	}

	
}
