package com.financetracker.model;

import com.financetracker.exception.SavingItemException;

public class SavingItem {
	
	private String name;
	private String description;
	private int price;
	private int id;
	
	public SavingItem(){
		
	}
	
	public SavingItem(String name, String description, int price) throws SavingItemException {
		this.setName(name);
		this.setDescription(description);
		this.setPrice(price);
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) throws SavingItemException {
		if(User.isStringValid(name)){
			this.name = name;
		}else{
			throw new SavingItemException("Invalid name! ");
		}
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) throws SavingItemException {
		if(User.isStringValid(description)){
			this.description = description;
		}else{
			throw new SavingItemException("Invalid description! ");
		}
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) throws SavingItemException {
		if(price > 0){
			this.price = price;
		}else{
			throw new SavingItemException("Invalid price! ");
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
}
