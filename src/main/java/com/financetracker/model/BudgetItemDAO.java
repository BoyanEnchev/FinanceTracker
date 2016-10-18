package com.financetracker.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.financetracker.controller.DBConnection;
import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;

public class BudgetItemDAO {

	private static final String INSERT_BUDGET_ITEM_SQL = "INSERT INTO budget_items Values (null, ?, ?, ?, ?, ?, ?)";
	private static final String SET_BUDGET_ITEM_PAYED_MONEY_SQL = "UPDATE budget_items SET payed_money = ? WHERE item_id = ?";
	private static final String GET_PAYED_MONEY_OF_ITEM_BY_ID_SQL = "SELECT payed_money FROM budget_items WHERE item_id = ?";
	private static final String GET_BUDGET_ITEM_BY_ID_SQL = "SELECT * FROM budget_items WHERE item_id = ?";
	private static final String SELECT_BUDGET_ITEMS_SQL = "SELECT * FROM budget_items WHERE user_id = ? AND time_of_adding BETWEEN ? AND ?ORDER BY time_of_adding;";
	private static final String SELECT_ALL_BUDGET_ITEMS_SQL = "SELECT * FROM budget_items WHERE user_id = ?";
	private static final String SELECT_TRANSACTIONS_SQL = "SELECT * FROM transactions WHERE item_id = ?";
	private static final String DELETE_BUDGET_ITEM_BY_ITEM_ID_SQL = "DELETE FROM budget_items WHERE item_id = ?;";
	private static final String DELETE_TRANSACTIONS_BY_ITEM_ID_SQL = "DELETE FROM transactions WHERE item_id = ?;";
	private static final String GET_INCCATEGORIES_SQL = "SELECT * FROM inccategories;";
	private static final String GET_EXPCATEGORIES_SQL = "SELECT * FROM expcategories;";

	private static final int YEAR_POS = 0;
	private static final int MONTH_POS = 1;
	private static final int DAY_POS = 2;

	public Integer addBudgetItem(int userID, BudgetItem item) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_BUDGET_ITEM_SQL, Statement.RETURN_GENERATED_KEYS);

			ps.setInt(1, item.getPlannedMoney());
			ps.setInt(2, item.getPayedMoney());
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

	public void updateBudgetItemPayedMoney(int itemId, int oldTransaAmount, int newTransValue) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {

			PreparedStatement ps = connection.prepareStatement(SET_BUDGET_ITEM_PAYED_MONEY_SQL);
			ps.setInt(1, this.getPayedMneyOfItemByID(itemId) - oldTransaAmount + newTransValue);
			ps.setInt(2, itemId);

			ps.executeUpdate();

		} catch (SQLException e) {
			throw new UserException("Update cannot be made right now, please try again later!", e);
		}
	}

	public void setBudgetItemPayedMoneyByItemID(int itemID, int amount) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {

			PreparedStatement ps = connection.prepareStatement(SET_BUDGET_ITEM_PAYED_MONEY_SQL);
			ps.setInt(1, new BudgetItemDAO().getPayedMneyOfItemByID(itemID) - amount);
			ps.setInt(2, itemID);

			ps.executeUpdate();

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}
	}

	public int getPayedMneyOfItemByID(int itemID) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {

			PreparedStatement ps = connection.prepareStatement(GET_PAYED_MONEY_OF_ITEM_BY_ID_SQL);
			ps.setInt(1, itemID);

			ResultSet rs = ps.executeQuery();

			rs.next();

			int amount = rs.getInt(1);

			return amount;

		} catch (SQLException e) {
			throw new UserException("Payed money cannot be showed right now, please try again later!", e);
		}
	}

	public BudgetItem getBugdgetItemByItemID(int itemID) throws BudgetItemException, UserException {
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

	public Map<BudgetItem, LinkedList<Transaction>> getBudgetItemsAndTransactionsByUserID(int id, String startDate,
			String endDate) throws UserException, BudgetItemException, TransactionException {
		Connection connection = DBConnection.getInstance().getConnection();

		Map<BudgetItem, LinkedList<Transaction>> itemsWithTransactions = new HashMap<BudgetItem, LinkedList<Transaction>>();
		try {

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

			java.util.Date date1 = Date.from(startDateSQL.atStartOfDay(ZoneId.systemDefault()).toInstant());
			java.sql.Date startDateDB = new java.sql.Date(date1.getTime());

			java.util.Date date2 = Date.from(endDateSQL.atStartOfDay(ZoneId.systemDefault()).toInstant());
			java.sql.Date endDateDB = new java.sql.Date(date2.getTime());

			PreparedStatement ps = connection.prepareStatement(SELECT_BUDGET_ITEMS_SQL);
			ps.setInt(1, id);
			ps.setDate(2, startDateDB);
			ps.setDate(3, endDateDB);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

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

				while (rs1.next()) {

					Transaction transaction = new Transaction(rs1.getInt(2), rs1.getString(4));
					transaction.setId(rs1.getInt(1));
					transaction.setTimeOfTransactionString(rs1.getDate(3).toString());
					transaction.setTimeOfTransaction();

					transactions.add(transaction);

				}

				itemsWithTransactions.put(item, transactions);
			}

			return itemsWithTransactions;

		} catch (SQLException e) {
			
			throw new UserException("Budget items cannon be listed right now, please try again later!", e);
		}
	}

	public void deleteBudgetItem(int item_id) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {

			PreparedStatement ps1 = connection.prepareStatement(DELETE_TRANSACTIONS_BY_ITEM_ID_SQL);
			ps1.setInt(1, item_id);

			ps1.executeUpdate();

			PreparedStatement ps = connection.prepareStatement(DELETE_BUDGET_ITEM_BY_ITEM_ID_SQL);
			ps.setInt(1, item_id);

			ps.executeUpdate();

		} catch (SQLException e) {
			throw new UserException("Budget item cannot be deleted right now, please try again later.", e);
		}
	}

	public List<BudgetItem> getBudgetItems(int userID) throws UserException, BudgetItemException {

		Connection connection = DBConnection.getInstance().getConnection();
		List<BudgetItem> allBudgetItems = new ArrayList<>();

		try {

			PreparedStatement ps = connection.prepareStatement(SELECT_ALL_BUDGET_ITEMS_SQL);
			ps.setInt(1, userID);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Date ts = rs.getDate(4);
				Instant instant = Instant.ofEpochMilli(ts.getTime());
				LocalDateTime res = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());

				BudgetItem item = new BudgetItem(rs.getInt(2), rs.getString(5), rs.getBoolean(6), res);

				item.setId(rs.getInt(1));
				item.setPayedMoney(rs.getInt(3));

				allBudgetItems.add(item);
			}

			return allBudgetItems;

		} catch (SQLException e) {
			throw new UserException("Budget item cannot be listed right now, please try again later.", e);
		}
	}

	public List<String> getIncomeCategories() throws BudgetItemException {

		Connection connection = DBConnection.getInstance().getConnection();
		List<String> incomeCategories = new ArrayList<>();

		try {

			PreparedStatement ps = connection.prepareStatement(GET_INCCATEGORIES_SQL);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String category = rs.getString(2);
				incomeCategories.add(category);
			}

			return incomeCategories;

		} catch (SQLException e) {
			throw new BudgetItemException("Income categories cannot be listed right now, please try again later.", e);
		}
	}
	
	public List<String> getExpenseCategories() throws BudgetItemException {

		Connection connection = DBConnection.getInstance().getConnection();
		List<String> expenseCategories = new ArrayList<>();

		try {

			PreparedStatement ps = connection.prepareStatement(GET_EXPCATEGORIES_SQL);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String category = rs.getString(2);
				expenseCategories.add(category);
			}

			return expenseCategories;

		} catch (SQLException e) {
			throw new BudgetItemException("Expense categories cannot be listed right now, please try again later.", e);
		}
	}

}
