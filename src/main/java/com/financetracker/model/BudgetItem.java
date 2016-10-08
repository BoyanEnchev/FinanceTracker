package com.financetracker.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.UserException;

public class BudgetItem {

	private static final Set<String> expCategories = new HashSet<String>();
	private static final Set<String> incCategories = new HashSet<String>();

	private int plannedMoney;
	private int payedMoney;
	private String category;
	private LocalDateTime timeOfAdding;
	private boolean expOrInc;
	private int id;
	private List<Transaction> transactions = new ArrayList<Transaction>();

	static {
		expCategories.add("Housing");
		expCategories.add("Shopping");
		expCategories.add("Grocery");
		expCategories.add("Automotive");
		expCategories.add("Fuel");
		expCategories.add("Car");
		expCategories.add("Bank activity");
		expCategories.add("Business");
		expCategories.add("Child expenses");
		expCategories.add("Debth");
		expCategories.add("Education");
		expCategories.add("Entertainment");
		expCategories.add("Gifts");
		expCategories.add("Medical");
		expCategories.add("Insurance");
		expCategories.add("Personal care");
		expCategories.add("Taxes");
		expCategories.add("Travel");
		expCategories.add("Utilities");
		expCategories.add("Uncategorised");

		incCategories.add("Salary");
		incCategories.add("Deposits");
		incCategories.add("Interest");
		incCategories.add("Investment income");
		incCategories.add("Other income");
		incCategories.add("Paychecks");
		incCategories.add("Refunds");
		incCategories.add("Retiremend income");
		incCategories.add("Sales");
		
	}

	public BudgetItem() throws BudgetItemException {
		this.setTimeOfAdding(LocalDateTime.now());
	}

	public BudgetItem(int plannedMoney, String category, boolean expOrInc, LocalDateTime timeOfAdding)
			throws BudgetItemException {

		this.setPlannedMoney(plannedMoney);
		this.payedMoney = 0;
		this.setCategory(category);
		this.setTimeOfAdding(timeOfAdding);
	}

	public int getPlannedMoney() {
		return plannedMoney;
	}

	public void setPlannedMoney(int plannedMoney) throws BudgetItemException {
		if (plannedMoney > 0) {
			this.plannedMoney = plannedMoney;
		} else {
			throw new BudgetItemException("Invalid planned money! ");
		}
	}

	public int getPayedMoney() {
		/*
		int amount = 0;
		for (Transaction tr : this.transactions) {
			amount += tr.getAmount();
		}
		return amount;
		*/
		return this.payedMoney;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) throws BudgetItemException {
		if (category != null && (BudgetItem.expCategories.contains(category) || BudgetItem.incCategories.contains(category))) {
			 if(BudgetItem.expCategories.contains(category)){
				 this.setExpOrInc(false);
			 }else{
				 this.setExpOrInc(true);
			 }
			 this.category = category;
		} else {
			throw new BudgetItemException("Invalid category! ");
		}
	}

	public LocalDateTime getTimeOfAdding() {
		return timeOfAdding;
	}

	public void setTimeOfAdding(LocalDateTime timeOfAdding) throws BudgetItemException {
		if (timeOfAdding != null) {
			this.timeOfAdding = timeOfAdding;
		} else
			throw new BudgetItemException("Invalid time of adding! ");
	}

	public void addTransaction(Transaction transaction) throws BudgetItemException, UserException {
		if (transaction != null) {
			this.transactions.add(transaction);
			this.payedMoney += transaction.getAmount();
			//new UserDAO().setBudgetItemPayedMoney(this, transaction);
			//new UserDAO().addTransactionToBudgetIteam(this.getId(), transaction);
		} else {
			throw new BudgetItemException("Invalid transaction! ");
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isExpOrInc() {
		return expOrInc;
	}

	public void setExpOrInc(boolean expOrInc) {
		this.expOrInc = expOrInc;
	}

	@Override
	public String toString() {
		return "BudgetItem [plannedMoney=" + plannedMoney + ", payedMoney=" + payedMoney + ", category=" + category
				+ ", timeOfAdding=" + timeOfAdding + ", expOrInc=" + expOrInc + ", id=" + id + ", transactions="
				+ transactions + "]";
	}

	public static Set<String> getCategories() {
		return expCategories;
	}

	public List<Transaction> getTransactions() {
		return transactions;
	}

	public void setTransactions(List<Transaction> transactions) {
		this.transactions = transactions;
	}

	public void setPayedMoney(int payedMoney) {
		this.payedMoney = payedMoney;
	}
	
	public static Set<String> getIncomeCategories(){
		Set<String> allC = new TreeSet<String>((o1, o2) -> o1.compareTo(o2));
		allC.addAll(BudgetItem.incCategories);
		
		return allC;
	}
	public static Set<String> getExpenseCategories(){
		Set<String> allC1 = new TreeSet<String>((o1, o2) -> o1.compareTo(o2));
		allC1.addAll(BudgetItem.expCategories);
		
		return allC1;
	}

}
