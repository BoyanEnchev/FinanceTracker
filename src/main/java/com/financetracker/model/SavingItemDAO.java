package com.financetracker.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Comparator;
import java.util.TreeSet;

import com.financetracker.controller.DBConnection;
import com.financetracker.exception.SavingItemException;
import com.financetracker.exception.UserException;

public class SavingItemDAO {

	private static final String INSERT_SAVING_ITEM_SQL = "INSERT INTO saving_items Values (null, ?, ?, ?, ?)";
	private static final String GET_SAVING_ITEMS_BY_USER_ID_SQL = "SELECT * FROM saving_items WHERE user_id = ?";
	private static final String DELETE_SAVING_ITEM_BY_ITEM_ID_SQL = "DELETE FROM saving_items WHERE name = ? AND description = ? AND price = ? AND user_id = ?;";

	
	public Integer addSavingItem(User user, SavingItem item) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(INSERT_SAVING_ITEM_SQL, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, item.getPrice());
			ps.setString(2, item.getName());
			ps.setString(3, item.getDescription());
			ps.setInt(4, user.getId());

			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();

			rs.next();

			Integer sItemId = rs.getInt(1);
			
			item.setId(sItemId);
			
			return sItemId;

		} catch (SQLException e) {
			throw new UserException("Saving item cannot be added right now, please try again later!", e);
		}
	}

	

	public TreeSet<SavingItem> getSavingItemsByUserId(int userId) throws SavingItemException, UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(GET_SAVING_ITEMS_BY_USER_ID_SQL);
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			TreeSet<SavingItem> savingItems = new TreeSet<SavingItem>(new Comparator<SavingItem>() {
				@Override
				public int compare(SavingItem o1, SavingItem o2) {

					if (o1.getName().equals(o2.getName())) {
						return o1.getDescription().compareTo(o2.getDescription());
					}
					return o1.getName().compareTo(o2.getName());
				}
			});

			while (rs.next()) {

				int price = rs.getInt(2);
				String name = rs.getString(3);
				String description = rs.getString(4);

				SavingItem sI = new SavingItem(name, description, price);

				savingItems.add(sI);
			}

			return savingItems;

		} catch (SQLException e) {
			throw new UserException("Saving items cannot be listed right now, please try again later.", e);
		}
	}

	
	public void deleteSavingItem(String name, String desc, int price, int user_id) throws UserException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {


			PreparedStatement ps = connection.prepareStatement(DELETE_SAVING_ITEM_BY_ITEM_ID_SQL);
			ps.setString(1, name);
			ps.setString(2, desc);
			ps.setInt(3,  price);
			ps.setInt(4, user_id);
			ps.executeUpdate();

		} catch (SQLException e) {
			throw new UserException("Saving item cannot be deleted right now, please try again later.", e);
		}
		
	}
}
