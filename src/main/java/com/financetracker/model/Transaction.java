package com.financetracker.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.financetracker.exception.TransactionException;


public class Transaction {
	
	private static final int YEAR_POS = 0;
	private static final int MONTH_POS = 1;
	private static final int DAY_POS = 2;
	
	private int amount;
	private LocalDate timeOfTransaction;
	private String description;
	private int id;
	private int item_id;
	private String timeOfTransactionString;
	private String category;
	
	public Transaction(int amount, String timeOfTransactionString, String description) throws TransactionException {
		this.timeOfTransactionString = timeOfTransactionString;
		this.setAmount(amount);
		this.setDescription(description);
	}

	public Transaction() throws TransactionException {
		
	}

	public Transaction(int amount, String description) throws TransactionException {
		this.setAmount(amount);
		this.setDescription(description);
	}

	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) throws TransactionException {
		if(amount > 0){
			this.amount = amount;
		}else{
			throw new TransactionException("Invalid transaction amount! ");
		}
	}

	public LocalDate getTimeOfTransaction() {
		return timeOfTransaction;
	}

	public void setTimeOfTransaction() throws TransactionException {
		if(timeOfTransactionString != null){
			String[] dateArr = this.timeOfTransactionString.split("-");
			int year = Integer.parseInt(dateArr[YEAR_POS]);
			int month = Integer.parseInt(dateArr[MONTH_POS]);
			int dayOfMonth = Integer.parseInt(dateArr[DAY_POS]);
			
			this.timeOfTransaction = LocalDate.of(year, month, dayOfMonth);
		}else{
			throw new TransactionException("Invalid time of transaction! ");
		}
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) throws TransactionException {
		if(description != null && User.isStringValid(description)){
			this.description = description;
		}else{
			throw new TransactionException("Invalid description! ");
		}
	}

	@Override
	public String toString() {
		return "Transaction [amount=" + amount + ", timeOfTransaction=" + timeOfTransaction + ", description="
				+ description + ", id=" + id + ", item_id=" + item_id + "]";
	}

	public int getItem_id() {
		return this.item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getTimeOfTransactionString() {
		return timeOfTransactionString;
	}

	public void setTimeOfTransactionString(String timeOfTransactionString) {
		this.timeOfTransactionString = timeOfTransactionString;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	
}
