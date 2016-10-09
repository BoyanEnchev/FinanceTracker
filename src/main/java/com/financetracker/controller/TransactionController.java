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
public class TransactionController {
	
	
	@RequestMapping(value = "/transactions", method = RequestMethod.GET)
	public String loadTransactionsPage(Model model, HttpSession session) throws UserException, BudgetItemException, TransactionException{
		
		int userID = ((User) session.getAttribute("user")).getId();
		
		TreeSet<Transaction> transactions = (TreeSet<Transaction>) new UserDAO().getTransactionsForTheLastFewDaysByUserId(userID);

		model.addAttribute("transactions", transactions);

		
		return "transactions";
	}
	

	@RequestMapping(value = "/transactionForm", method = RequestMethod.GET)
	public String getBudgetItemForm(Model model) throws BudgetItemException {
		model.addAttribute("item", new BudgetItem());
		
		return "redirect:budget";
	}
	
	@RequestMapping(value = "/transactionForm", method = RequestMethod.POST)
	public String addTransactionForm(Model model, @ModelAttribute("transaction") Transaction transaction,
			BindingResult result, HttpSession session) throws BudgetItemException, TransactionException, UserException {
		

		if (result.hasErrors()) {
			/*
			 	BudgetItem item = new BudgetItem();
			//BudgetItem item1 = new BudgetItem();
			Transaction transaction1 = new Transaction();
			model.addAttribute("item", item);
			//model.addAttribute("item1", item1);
			model.addAttribute("transaction", transaction1);
			 */
			int userID = ((User) session.getAttribute("user")).getId();
			Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new UserDAO().getBudgetItemsAndTransactionsByUserID(userID);
			
			ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());
			
			TreeSet<Transaction> transactions = (TreeSet<Transaction>) new UserDAO().getTransactionsForTheLastFewDaysByUserId(userID);

						
			model.addAttribute("budgetItems", budgetItems);
			model.addAttribute("user",session.getAttribute("user"));
			model.addAttribute("transactions", transactions);
			
			
			return "budget";
		} else {

			try {
				transaction.setTimeOfTransaction();
				new UserDAO().addTransactionToBudgetIteam(transaction);
			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("transaction" + transaction.getId(), transaction);

			return "redirect:budget";
		}
	}
	
	
}
