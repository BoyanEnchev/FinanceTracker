package com.financetracker.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.UserException;

public class BudgetItem {
	
	private static final Set<String>categories = new HashSet<String>();
	
	private int plannedMoney;
	private int payedMoney;
	private String category;
	private LocalDateTime timeOfAdding;
	private boolean expOrInc;
	private int id;
	private List<Transaction> transactions = new ArrayList<Transaction>();
	
	static{
		categories.add("Housing");
		categories.add("Shopping");
		categories.add("Salary");
	}
	
	public BudgetItem(int plannedMoney, String category, LocalDateTime timeOfAdding, boolean expOrInc) throws BudgetItemException {

		this.setPlannedMoney(plannedMoney);
		this.payedMoney = 0;
		this.setCategory(category);
		this.setTimeOfAdding(timeOfAdding);
		this.expOrInc = expOrInc;
	}
	public int getPlannedMoney() {
		return plannedMoney;
	}
	public void setPlannedMoney(int plannedMoney) throws BudgetItemException {
		if(plannedMoney > 0){
			this.plannedMoney = plannedMoney;
		}else{
			throw new BudgetItemException("Invalid planned money! ");
		}
	}
	public int getPayedMoney() {
		return payedMoney;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) throws BudgetItemException {
		if(category != null && BudgetItem.categories.contains(category)){
			this.category = category;
		}else{
			throw new BudgetItemException("Invalid category! ");
		}
	}
	public LocalDateTime getTimeOfAdding() {
		return timeOfAdding;
	}
	public void setTimeOfAdding(LocalDateTime timeOfAdding) throws BudgetItemException {
		if(timeOfAdding != null){
			this.timeOfAdding = timeOfAdding;
		}else throw new BudgetItemException("Invalid time of adding! ");
	}
	public void addTransaction(Transaction transaction) throws BudgetItemException, UserException{
		if(transaction != null){
			this.transactions.add(transaction);
			this.payedMoney += transaction.getAmount();
			new UserDAO().setBudgetItemPayedMoney(this, transaction);
			new UserDAO().addTransactionToBudgetIteam(this, transaction);
		}else{
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
	
}
