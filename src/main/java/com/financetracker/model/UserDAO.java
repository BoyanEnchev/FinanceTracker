package com.financetracker.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import com.financetracker.controller.DBConnection;
import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;



public class UserDAO {

	private static final String INSERT_USER_SQL = "INSERT INTO users VALUES (null, ?, ?, ?, ?)";
	private static final String EXISTS_USER_SQL = "SELECT user_id FROM users WHERE email = ? AND password = ?";
	private static final String INSERT_BUDGET_ITEM_SQL = "INSERT INTO budget_items Values (null, ?, ?, ?, ?, ?, ?)";
	private static final String INSERT_TRANSACTION_SQL = "INSERT INTO transactions Values (null, ?, ?, ?, ?)";
	private static final String INSERT_SAVING_ITEM_SQL = "INSERT INTO saving_items Values (null, ?, ?, ?, ?)";
	private static final String SET_BUDGET_ITEM_PAYED_MONEY_SQL = "UPDATE budget_items SET payed_money = ? WHERE item_id = ?";
	private static final String SELECT_BUDGET_ITEMS_SQL = "SELECT * FROM budget_items WHERE user_id = ?";
	private static final String SELECT_TRANSACTIONS_SQL = "SELECT * FROM transactions WHERE item_id = ?";
	private static final String GET_BUDGET_ITEM_BY_ID_SQL = "SELECT * FROM budget_items WHERE item_id = ?";;


	public Integer registerUser(User user) throws UserException {
		System.out.println(user);
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_USER_SQL, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getFirstName());
			ps.setString(3, user.getLastName());
			ps.setString(4, user.getPassword());

			Integer result = null;
			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();
			rs.next();
			result = rs.getInt(1);
			user.setId(result);
			return result;

		} catch (SQLException e) {
			throw new UserException("User cannot be registered now, please try again later.", e);
		}
	}

	public Integer loginUser(String email, String password) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(EXISTS_USER_SQL);
			ps.setString(1, email);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			Integer userId = null;
			if (rs.next()) {
				userId = rs.getInt(1);
			}

			return userId;
		} catch (SQLException e) {
			throw new UserException("User cannot be registered now, please try again later.", e);
		}
	}
	
	public Integer addBudgetItem(int userID, BudgetItem item) throws UserException{
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_BUDGET_ITEM_SQL, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, item.getPlannedMoney());
			ps.setInt(2, item.getPayedMoney());
			//ps.setDate(3, new Date(new java.util.Date().getTime()));
			ps.setDate(3, new Date(item.getTimeOfAdding().atZone(ZoneId.systemDefault()).toInstant().toEpochMilli()));
			ps.setString(4, item.getCategory());
			int myInt = (item.isExpOrInc()) ? 1 : 0;
			ps.setInt(5, myInt);
			ps.setInt(6, userID);

			Integer result = null;
			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();
			rs.next();
			result = rs.getInt(1);
			item.setId(result);
			return result;

		} catch (SQLException e) {
			throw new UserException("Budget item cannot be added right now, please try again later!", e);
		}
	}
	
	public BudgetItem getBugdgetItemByItemID(int itemID) throws BudgetItemException, UserException{
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(GET_BUDGET_ITEM_BY_ID_SQL);
			ps.setInt(1, itemID);
			

			ResultSet rs = ps.executeQuery();
			rs.next();
		
			Date ts = rs.getDate(4);
			Instant instant = Instant.ofEpochMilli(ts.getTime());
			LocalDateTime res = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
			
			BudgetItem item = new BudgetItem(rs.getInt(2), rs.getString(5), rs.getBoolean(6), res);
			
			item.setId(rs.getInt(1));
			item.setPayedMoney(rs.getInt(3));
			
			return item;

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}		
	}

	public Integer addTransactionToBudgetIteam(Transaction transaction) throws UserException, BudgetItemException {
		Connection connection = DBConnection.getInstance().getConnection();

		
		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_TRANSACTION_SQL, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, transaction.getAmount());
			java.util.Date utilDate = Date.from(transaction.getTimeOfTransaction().atStartOfDay(ZoneId.systemDefault()).toInstant());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			ps.setDate(2, sqlDate);
			ps.setString(3, transaction.getDescription());
			ps.setInt(4, transaction.getItem_id());
			Integer result = null;
			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();
			rs.next();
			result = rs.getInt(1);

			transaction.setId(result);
		
			
			this.setBudgetItemPayedMoney(this.getBugdgetItemByItemID(transaction.getItem_id()), transaction);								
			
			return result;

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}		
	}

	public void setBudgetItemPayedMoney(BudgetItem item, Transaction transaction) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			
			PreparedStatement ps = connection.prepareStatement(SET_BUDGET_ITEM_PAYED_MONEY_SQL);
			ps.setInt(1, item.getPayedMoney() + transaction.getAmount());
			ps.setInt(2, item.getId());
			
			ps.executeUpdate();


		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}		
	}
	
	public void addSavingItem(User user, SavingItem item) throws UserException{
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_SAVING_ITEM_SQL);
			ps.setInt(1, item.getPrice());
			ps.setString(2, item.getName());
			ps.setString(3, item.getDescription());
			ps.setInt(4, user.getId());
			
			ps.executeUpdate();


		} catch (SQLException e) {
			throw new UserException("Saving item cannot be added right now, please try again later!", e);
		}
	}
	
	public Map<BudgetItem, LinkedList<Transaction>> getBudgetItemsAndTransactionsByUserID(int id) throws UserException, BudgetItemException, TransactionException{
		Connection connection = DBConnection.getInstance().getConnection();

		Map<BudgetItem, LinkedList<Transaction>> itemsWithTransactions = new HashMap<BudgetItem, LinkedList<Transaction>>();
		try {
			PreparedStatement ps = connection.prepareStatement(SELECT_BUDGET_ITEMS_SQL);
			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				
				
				Date ts = rs.getDate(4);
				Instant instant = Instant.ofEpochMilli(ts.getTime());
				LocalDateTime res = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
				
				BudgetItem item = new BudgetItem(rs.getInt(2), rs.getString(5), rs.getBoolean(6), res);
				
				item.setId(rs.getInt(1));
				item.setPayedMoney(rs.getInt(3));
				
				LinkedList<Transaction> transactions = new LinkedList<Transaction>();
				
				PreparedStatement ps1 = connection.prepareStatement(SELECT_TRANSACTIONS_SQL);
				
				ps1.setInt(1, item.getId());
				ResultSet rs1 = ps1.executeQuery();
				
				while(rs1.next()){
					Date ts1 = rs1.getDate(3);
					Instant instant1 = Instant.ofEpochMilli(ts1.getTime());
					LocalDateTime res1 = LocalDateTime.ofInstant(instant1, ZoneId.systemDefault());
					
					Transaction transaction = new Transaction(rs1.getInt(2),rs1.getString(4));
					transaction.setId(rs1.getInt(1));
					transaction.setTimeOfTransactionString(rs1.getDate(3).toString());
					transaction.setTimeOfTransaction();
					
					transactions.add(transaction);
					//item.addTransaction(transaction);
				
				}
				
				
				itemsWithTransactions.put(item, transactions);
			}
			
			return itemsWithTransactions;

		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			throw new UserException("Saving item cannot be added right now, please try again later!", e);
		}
	}

}
