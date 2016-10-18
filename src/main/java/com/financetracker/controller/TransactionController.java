package com.financetracker.controller;

import java.time.LocalDate;
import java.util.ArrayList;
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
import com.financetracker.model.TransactionDAO;
import com.financetracker.model.User;

@Controller
public class TransactionController {
	
	private static final int YEAR_POS = 0;
	private static final int MONTH_POS = 1;
	private static final int DAY_POS = 2;
	

	@RequestMapping(value = "/transactions", method = RequestMethod.GET)
	public String loadTransactionsPage(Model model, HttpSession session)
			throws UserException, BudgetItemException, TransactionException {

		int userID = ((User) session.getAttribute("user")).getId();

		TreeSet<Transaction> transactions = (TreeSet<Transaction>) new TransactionDAO()
				.getTransactionsForTheLastFewDaysByUserId(userID);
		
		ArrayList<Transaction> transactionsInTimeSpan = new TransactionDAO().searchTransactionsForTimeSpan(LocalDate.now(), LocalDate.now(), userID);

		model.addAttribute("transactionsInTimeSpan", transactionsInTimeSpan);

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
			
			int userID = ((User) session.getAttribute("user")).getId();
			Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new BudgetItemDAO()
					.getBudgetItemsAndTransactionsByUserID(userID, LocalDate.now().toString(), LocalDate.now().toString());

			ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

			TreeSet<Transaction> transactions = (TreeSet<Transaction>) new TransactionDAO()
					.getTransactionsForTheLastFewDaysByUserId(userID);

			model.addAttribute("budgetItems", budgetItems);
			model.addAttribute("user", session.getAttribute("user"));
			model.addAttribute("transactions", transactions);
			model.addAttribute("editedTransaction", new Transaction());


			return "budget";
		} else {

			try {
				transaction.setTimeOfTransaction();

				new TransactionDAO().addTransactionToBudgetIteam(transaction);
			} catch (UserException e) {
				model.addAttribute("error", e);
			}
			session.setAttribute("transaction" + transaction.getId(), transaction);

			return "redirect:budget";
		}
	}

	@RequestMapping(value = "/deleteTransaction", method = RequestMethod.POST)
	public String deleteTransaction(@RequestParam("deletedID") int transactionID,
			@RequestParam("deletedItemID") int transactionItemID,
			@RequestParam("deletedAmount") int transactionAmount) throws UserException {

		
			new BudgetItemDAO().setBudgetItemPayedMoneyByItemID(transactionItemID, transactionAmount);
			new TransactionDAO().deleteTransaction(transactionID);

		

		return "forward:budget";
	}

	@RequestMapping(value = "/editTransaction", method = RequestMethod.POST)
	    public String editTransaction(@RequestParam("editedID") int transactionID, @RequestParam("editedItemID") int transactionItemID,@RequestParam("editedAmount") int transactionAmount, @ModelAttribute("editedTransaction") Transaction transaction, BindingResult result,
				HttpSession session) throws BudgetItemException, TransactionException, UserException {
		   

		transaction.setTimeOfTransaction();
		transaction.setId(transactionID);
		
			
			new TransactionDAO().updateTransactionByTransactionID(transaction, transactionAmount);
			
		   
	        return "forward:budget";
	    }
	
	@RequestMapping(value = "/listTransactions", method = RequestMethod.GET)
    public String searchTransaction(Model model, @RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate, HttpSession session) throws TransactionException, UserException {
	  
		if(startDate != null && endDate != null){
			String[] startDateArr = startDate.split("-");
			String[] endDateArr = endDate.split("-");
			
			int startYear = Integer.parseInt(startDateArr[YEAR_POS]);
			int startMonth = Integer.parseInt(startDateArr[MONTH_POS]);
			int startDayOfMonth = Integer.parseInt(startDateArr[DAY_POS]);
			
			int endYear = Integer.parseInt(endDateArr[YEAR_POS]);
			int endMonth = Integer.parseInt(endDateArr[MONTH_POS]);
			int endDayOfMonth = Integer.parseInt(endDateArr[DAY_POS]);
			
			LocalDate startDateSQL = LocalDate.of(startYear, startMonth, startDayOfMonth);
			LocalDate endDateSQL = LocalDate.of(endYear, endMonth, endDayOfMonth);

			int userID = ((User)(session.getAttribute("user"))).getId();
			
			ArrayList<Transaction> transactionsInTimeSpan = new TransactionDAO().searchTransactionsForTimeSpan(startDateSQL, endDateSQL, userID);

			model.addAttribute("transactionsInTimeSpan", transactionsInTimeSpan);
		}else{
			throw new TransactionException("Transactions cannot be listed right now! ");
		}
		
	   
        return "transactions";
    }


}
