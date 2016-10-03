package com.financetracker.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.ZoneId;

import com.financetracker.controller.DBConnection;
import com.financetracker.exception.UserException;



public class UserDAO {

	private static final String INSERT_USER_SQL = "INSERT INTO users VALUES (null, ?, ?, ?, ?)";
	private static final String EXISTS_USER_SQL = "SELECT user_id FROM users WHERE email = ? AND password = ?";
	private static final String INSERT_BUDGET_ITEM_SQL = "INSERT INTO budget_items Values (null, ?, ?, ?, ?, ?, ?)";
	private static final String INSERT_TRANSACTION_SQL = "INSERT INTO transactions Values (null, ?, ?, ?, ?)";
	private static final String INSERT_SAVING_ITEM_SQL = "INSERT INTO saving_items Values (null, ?, ?, ?, ?)";
	private static final String SET_BUDGET_ITEM_PAYED_MONEY_SQL = "UPDATE budget_items SET payed_money = ? WHERE item_id = ?";

	public Integer registerUser(User user) throws UserException {
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
			System.out.println(rs);
			Integer userId = null;
			if (rs.next()) {
				userId = rs.getInt(1);
			}

			return userId;
		} catch (SQLException e) {
			throw new UserException("User cannot be registered now, please try again later.", e);
		}
	}
	
	public Integer addBudgetItem(User user, BudgetItem item) throws UserException{
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
			ps.setInt(6, user.getId());

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

	public Integer addTransactionToBudgetIteam(BudgetItem item, Transaction transaction) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_TRANSACTION_SQL, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, transaction.getAmount());
			ps.setDate(2, new Date(transaction.getTimeOfTransaction().atZone(ZoneId.systemDefault()).toInstant().toEpochMilli()));
			ps.setString(3, transaction.getDescription());
			ps.setInt(4, item.getId());
			Integer result = null;
			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();
			rs.next();
			result = rs.getInt(1);
			transaction.setId(result);
			return result;

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}		
	}

	public void setBudgetItemPayedMoney(BudgetItem item, Transaction transaction) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(SET_BUDGET_ITEM_PAYED_MONEY_SQL);
			ps.setInt(1, transaction.getAmount());
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
	
}
