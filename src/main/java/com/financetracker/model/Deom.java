package com.financetracker.model;

import java.util.LinkedList;
import java.util.Map;

import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;

public class Deom {

	public static void main(String[] args) {
		
		try {
			Map<BudgetItem, LinkedList<Transaction>> test =new UserDAO().getBudgetItemsAndTransactionsByUserID(17);
			
			test.forEach((k, v) -> System.out.println(k));
		} catch (UserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (BudgetItemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransactionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
