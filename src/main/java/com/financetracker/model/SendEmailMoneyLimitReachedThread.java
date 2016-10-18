package com.financetracker.model;

import java.net.PasswordAuthentication;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Properties;
import java.util.TreeSet;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmailMoneyLimitReachedThread implements Runnable {

	@Override
	public void run() {

		while (true) {
			try {

				Thread.currentThread().sleep(10000);

				
				for (User user : new UserDAO().getAllUsers()) {

					int userID = user.getId();

					Map<BudgetItem, LinkedList<Transaction>> itemsTransactionsMap = new BudgetItemDAO()
							.getBudgetItemsAndTransactionsByUserID(userID, LocalDate.now().minusMonths(1).toString(),
									LocalDate.now().toString());

					ArrayList<BudgetItem> budgetItems = new ArrayList<BudgetItem>(itemsTransactionsMap.keySet());

					Map<String, LinkedList<Transaction>> itemsNamesTransValues = new HashMap<>();
					itemsTransactionsMap
							.forEach((budgetItem, list) -> itemsNamesTransValues.put(budgetItem.getCategory(), list));

					int actual = 0;
					int budgeted = 0;

					for (BudgetItem budgetItem : budgetItems) {
						if (!budgetItem.isExpOrInc()) {
							budgeted += budgetItem.getPlannedMoney();
							actual += budgetItem.getPayedMoney();
						}
					}

					if (budgeted * 0.9 < actual) {
						this.sendEmail(user);
					}
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void sendEmail(User user) {

		String host = "localhost";

		String from = "ittalentstest@abv.bg";
		String password = "ittalents2016";

		String to = user.getEmail();// change accordingly

		// Get the session object
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.host", "smtp.abv.bg");
		props.put("mail.smtp.socketFactory.port", 465);
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		javax.mail.Session session = javax.mail.Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(from, password);
			}
		});

		// Compose the message
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject("javatpoint");
			message.setText("Hello " + user.getFirstName() + " " + user.getLastName() + " , \n"
					+ "You reached 90% of what you have planned to spend " + " for this month \n"
					+ "Best regards, \n FinanceTracker");
			// send the message
			Transport.send(message);

			System.out.println("message sent successfully...");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
