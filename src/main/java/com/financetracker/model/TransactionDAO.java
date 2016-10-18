package com.financetracker.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.TreeSet;

import com.financetracker.controller.DBConnection;
import com.financetracker.exception.BudgetItemException;
import com.financetracker.exception.TransactionException;
import com.financetracker.exception.UserException;

public class TransactionDAO {

	private static final String INSERT_TRANSACTION_SQL = "INSERT INTO transactions Values (null, ?, ?, ?, ?)";
	private static final String GET_TRANSACTIONS_BY_USER_ID_SQL = "SELECT  amount, time_of_transaction, description, X.item_id, X.category_name "
			+ "FROM (SELECT t.amount, t.time_of_transaction, t.description, u.user_id, b.item_id, b.category_name FROM transactions t "
			+ "JOIN budget_items b ON (t.item_id = b.item_id) JOIN users u ON (b.user_id = u.user_id)) AS X "
			+ "WHERE time_of_transaction > DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND time_of_transaction <= CURDATE() AND user_id = ? "
			+ "ORDER BY time_of_transaction;";
	private static final String GET_TRANSACTIONS_FOR_TIME_SPAN_SQL = "SELECT  amount, time_of_transaction, description, X.item_id, X.category_name "
			+ "FROM (SELECT t.amount, t.time_of_transaction, t.description, u.user_id, b.item_id, b.category_name FROM transactions t "
			+ "JOIN budget_items b ON (t.item_id = b.item_id) JOIN users u ON (b.user_id = u.user_id)) AS X "
			+ "WHERE time_of_transaction BETWEEN ? AND ? AND user_id = ? ORDER BY time_of_transaction;";
	private static final String DELETE_TRANSACTION_BY_ID_SQL = "DELETE FROM transactions WHERE transaction_id = ?;";
	private static final String UPDATE_TRANSACTION_SQL = "UPDATE transactions SET amount = ?, time_of_transaction = ?, description = ? WHERE transaction_id = ?";
	
	
	public Integer addTransactionToBudgetIteam(Transaction transaction) throws UserException, BudgetItemException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_TRANSACTION_SQL, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, transaction.getAmount());
			java.util.Date utilDate = Date
					.from(transaction.getTimeOfTransaction().atStartOfDay(ZoneId.systemDefault()).toInstant());
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

			new BudgetItemDAO().setBudgetItemPayedMoney(new BudgetItemDAO().getBugdgetItemByItemID(transaction.getItem_id()), transaction);

			return result;

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}
	}
	
	public TreeSet<Transaction> getTransactionsForTheLastFewDaysByUserId(int userId)
			throws UserException, TransactionException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(GET_TRANSACTIONS_BY_USER_ID_SQL);
			// ps.setInt(1, days);
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			TreeSet<Transaction> transactions = new TreeSet<Transaction>(new Comparator<Transaction>() {
				@Override
				public int compare(Transaction o1, Transaction o2) {

					if (o1.getTimeOfTransaction().equals(o2.getTimeOfTransaction())) {
						return o1.getDescription().compareTo(o2.getDescription());
					}
					return o1.getTimeOfTransaction().compareTo(o2.getTimeOfTransaction());
				}
			});
			while (rs.next()) {

				int amount = rs.getInt(1);
				Date date = rs.getDate(2);
				String description = rs.getString(3);

				Transaction tr = new Transaction(amount, date.toString(), description);
				tr.setTimeOfTransaction();
				tr.setItem_id(rs.getInt(4));
				tr.setCategory(rs.getString(5));

				transactions.add(tr);
			}

			return transactions;

		} catch (SQLException e) {
			throw new UserException("Transactions cannot be listed right now, please try again later.", e);
		}
	}
	
	public ArrayList<Transaction> searchTransactionsForTimeSpan(LocalDate startDate, LocalDate endDate, int userID) throws UserException, TransactionException{
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			java.util.Date startDateSQL = Date
					.from(startDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
			java.sql.Date startDateDB = new java.sql.Date(startDateSQL.getTime());
			
			java.util.Date endDateSQL = Date
					.from(endDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
			java.sql.Date endDateDB = new java.sql.Date(endDateSQL.getTime());
			
			PreparedStatement ps = connection.prepareStatement(GET_TRANSACTIONS_FOR_TIME_SPAN_SQL);
			ps.setDate(1, startDateDB);
			ps.setDate(2, endDateDB);
			ps.setInt(3, userID);
			
			ResultSet rs = ps.executeQuery();

			ArrayList<Transaction> transactionsInTimeSpan = new ArrayList<Transaction>();
						
			while(rs.next()){
				
				int amount = rs.getInt(1);
				Date date = rs.getDate(2);
				String description = rs.getString(3);
				int item_id = rs.getInt(4);
				String category = rs.getString(5);

				
				Transaction tr = new Transaction(amount, date.toString(), description);
				tr.setTimeOfTransaction();
				tr.setItem_id(item_id);
				tr.setCategory(category);
				tr.setItem_id(item_id);
				transactionsInTimeSpan.add(tr);
			}
			
			return transactionsInTimeSpan;

		} catch (SQLException e) {
			throw new UserException("Transactions cannot be listed right now! ", e);
		}
	}
	


	
	public void deleteTransaction(int item_id) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {

			PreparedStatement ps = connection.prepareStatement(DELETE_TRANSACTION_BY_ID_SQL);
			ps.setInt(1, item_id);

			ps.executeUpdate();

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be deleted right now, please try again later.", e);
		}

	}

	public void updateTransactionByTransactionID(Transaction editedTransaction, int oldTransAmount) throws UserException, BudgetItemException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(UPDATE_TRANSACTION_SQL);
			ps.setInt(1, editedTransaction.getAmount());
			java.util.Date utilDate = Date
					.from(editedTransaction.getTimeOfTransaction().atStartOfDay(ZoneId.systemDefault()).toInstant());
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			ps.setDate(2, sqlDate);	
			ps.setString(3, editedTransaction.getDescription());
			ps.setInt(4, editedTransaction.getId());
			
			System.out.println("DAO" + editedTransaction.getAmount());
			System.out.println("DAO" + sqlDate);
			System.out.println("DAO" + editedTransaction.getDescription());
			System.out.println("DAO" + editedTransaction.getId());
						
			ps.executeUpdate();

			new BudgetItemDAO().updateBudgetItemPayedMoney(editedTransaction.getItem_id(), oldTransAmount, editedTransaction.getAmount());

		} catch (SQLException e) {
			throw new UserException("Transaction cannot be added right now, please try again later!", e);
		}
	}


	
}
