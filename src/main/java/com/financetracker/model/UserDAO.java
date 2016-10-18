package com.financetracker.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.financetracker.controller.DBConnection;
import com.financetracker.exception.UserException;


public class UserDAO {

	private static final String INSERT_USER_SQL = "INSERT INTO users VALUES (null, ?, ?, ?, md5(?))";
	private static final String EXISTS_USER_SQL = "SELECT user_id FROM users WHERE email = ? AND password = ?";
	private static final String GET_USER_BY_EMAIL_SQL = "SELECT user_id FROM users WHERE email like ?;";
	private static final String GET_ALL_USERS_SQL = "SELECT * FROM users;";

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

	public Integer loginUser(String email, String password) throws UserException, NoSuchAlgorithmException {
		Connection connection = DBConnection.getInstance().getConnection();

		try {
			PreparedStatement ps = connection.prepareStatement(EXISTS_USER_SQL);
			ps.setString(1, email);
			
			MessageDigest md = MessageDigest.getInstance("MD5");
	        md.update(password.getBytes());

	        byte byteData[] = md.digest();

	        //convert the byte to hex format method 1
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
			
			ps.setString(2,sb.toString());

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

	

	
	public Integer checkIfExistsUserWithThatEmail(String email) throws UserException{
		Connection connection = DBConnection.getInstance().getConnection();

		try {


			PreparedStatement ps = connection.prepareStatement(GET_USER_BY_EMAIL_SQL);
			ps.setString(1, email);

			ResultSet rs = ps.executeQuery();
			
			if(!rs.next()){
				return null;
			}else{
				return 1;
			}


		} catch (SQLException e) {
			throw new UserException("User cannot be selected right now, please try again later.", e);
		}
	}
	
	public ArrayList<User> getAllUsers() throws UserException{
		Connection connection = DBConnection.getInstance().getConnection();

		try {


			PreparedStatement ps = connection.prepareStatement(GET_ALL_USERS_SQL);

			ResultSet rs = ps.executeQuery();
			
			ArrayList<User> allUsers = new ArrayList<User>();
			
			while(rs.next()){
				int user_id = rs.getInt(1);
				String email = rs.getString(2);
				String firstName = rs.getString(3);
				String lastName = rs.getString(4);
				String password = rs.getString(5);
				
				User user = new User(firstName, lastName, email, password, password);
				
				user.setId(user_id);
				
				allUsers.add(user);
			}
			
			return allUsers;
		} catch (SQLException e) {
			throw new UserException("Users cannot be selected right now, please try again later.", e);
		}
	}
}
