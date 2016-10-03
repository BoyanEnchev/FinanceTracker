package com.financetracker.controller;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private Connection connection;
	private static DBConnection theChosenOneDBConnection;
	
	private static final String DB_HOSTNAME = "127.0.0.1";
	private static final String DB_PORT = "3306";
	private static final String DATABASE = "financetracker?useSSL=false";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "mysqlrootpassword";
	
	private DBConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			this.connection = 
					DriverManager.getConnection("jdbc:mysql://" + 
							DB_HOSTNAME + ":" + 
							DB_PORT + "/" + DATABASE, 
							DB_USER, DB_PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public synchronized static DBConnection getInstance() {
		if (theChosenOneDBConnection == null) {
			theChosenOneDBConnection = new DBConnection();
		}
		return theChosenOneDBConnection;
	}

	public Connection getConnection() {
		return connection;
	}

}
