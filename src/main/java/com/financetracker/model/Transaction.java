package com.financetracker.model;

import java.time.LocalDateTime;

import com.financetracker.exception.TransactionException;


public class Transaction {
	
	private int amount;
	private LocalDateTime timeOfTransaction;
	private String description;
	private int id;
	
	public Transaction(int amount, LocalDateTime timeOfTransaction, String description) throws TransactionException {
	
		this.setAmount(amount);
		this.setTimeOfTransaction(timeOfTransaction);
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

	public LocalDateTime getTimeOfTransaction() {
		return timeOfTransaction;
	}

	public void setTimeOfTransaction(LocalDateTime timeOfTransaction) throws TransactionException {
		if(timeOfTransaction != null){
			this.timeOfTransaction = timeOfTransaction;
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
	
	
}
