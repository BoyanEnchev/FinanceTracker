package com.financetracker.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Component;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.UserException;

@Component
public class User {
	
	private static final String EMAIL_REGEX = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";
	private static final int MIN_LENGTH_FOR_PASSWORD = 6;
	@NotNull
	@NotEmpty
	private String firstName;
	@NotNull
	@NotEmpty
	private String lastName;
	@NotNull
	@NotEmpty
	@Email
	private String email;
	@NotNull
	@NotEmpty
	@Length(min=6, max=50)
	private String password;
	@NotNull
	@NotEmpty
	@Length(min=6, max=50)
	private String confirm;
	private int id;
	private List<BudgetItem> budgetItems = new ArrayList<BudgetItem>();
	private Set<SavingItem> savingItems = new HashSet<SavingItem>();
	
	public User(String firstName, String lastName, String email, String password, String confirm) throws UserException {
		
		this.setFirstName(firstName);
		this.setLastName(lastName);
		this.setEmail(email);
		this.setPassword(password);
		this.setConfirm(confirm);
	}

	public User() {
		
	}

	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) throws UserException {
		if(isStringValid(firstName)){
			this.firstName = firstName;
		}else{
			throw new UserException("Invalid first name! ");
		}
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) throws UserException {
		if(isStringValid(lastName)){
			this.lastName = lastName;
		}else{
			throw new UserException("Invalid last name! ");
		}
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) throws UserException {
		if(isEmailValid(email)){
			this.email = email;
		}else{
			throw new UserException("Invalid email! ");
		}
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) throws UserException {
		if(isPasswordValid(password)){
			this.password = password;
		}else{
			throw new UserException("Invalid password! ");
		}
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	static boolean isEmailValid(String email) {
		return email.matches(EMAIL_REGEX);
	}
	static boolean isStringValid(String string) {
		return ((string != null) && (string.trim().length() > 0));
	}
	

	public void addBudgetItem(BudgetItem item) throws UserException{
		if(item != null){
			this.budgetItems.add(item);
			//new UserDAO().addBudgetItem(this, item);
		}else{
			throw new UserException("Invalid bugdet item! ");
		}
	}
	
	public void addTransactionToBudgetItem(BudgetItem item, Transaction transaction) throws BudgetItemException, UserException{
		if(item != null && transaction != null 
				&& this.budgetItems.contains(item)){
		item.addTransaction(transaction);
		}else{
			throw new UserException("Invalid adding of a transaction! ");
		}	
	}
	
	public void addSavingItem(SavingItem item) throws UserException{
		if(item != null){
			this.savingItems.add(item);
			new SavingItemDAO().addSavingItem(this, item);
		}else{
			throw new UserException("Invalid saving item! ");
		}
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
	
		this.confirm = confirm;
	}

	@Override
	public String toString() {
		return "User [firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", password=" + password
				+ ", confirm=" + confirm + ", id=" + id + ", budgetItems=" + budgetItems + ", savingItems="
				+ savingItems + "]";
	}
	
	// 1 malka bukva, 1 glavna bukva, 1 cifra, dyljina-6
		static boolean isPasswordValid(String password) {
			
			
			boolean hasSmallCase = false, hasUpperCase = false, hasDigit = false;
			if (password.length() >= MIN_LENGTH_FOR_PASSWORD) {
				for (int symbol = 0; symbol < password.length(); symbol++) {
					if ((password.charAt(symbol) >= 'a') && (password.charAt(symbol) <= 'z')) {
						hasSmallCase = true;
					}
					if ((password.charAt(symbol) >= 'A') && (password.charAt(symbol) <= 'Z')) {
						hasUpperCase = true;
					}
					if ((password.charAt(symbol) >= '0') && (password.charAt(symbol) <= '9')) {
						hasDigit = true;
					}
				}
			}
			
			boolean check = hasSmallCase && hasUpperCase && hasDigit;
			
		}
	
}
