package com.financetracker.controller;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.exception.UserException;
import com.financetracker.model.SendEmailMoneyLimitReachedThread;
import com.financetracker.model.User;
import com.financetracker.model.UserDAO;

@Controller
public class StartPageController {

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String loadStartPage(Model model, HttpSession session) {

		User user = new User();
		
		model.addAttribute("user", user);
		model.addAttribute("existingEmailMessage", "");
		
		session.setAttribute("user", user);
		
		Thread sendEmailThread= new Thread(new SendEmailMoneyLimitReachedThread());
		sendEmailThread.setDaemon(true);
		sendEmailThread.start();

		return "index";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutPage(Model model, HttpSession session) {
		
		session.removeAttribute("user");
		session.invalidate();
		
		return "redirect:index";
	}
	

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerForm(Model model, @ModelAttribute("user") User user, BindingResult result,
			HttpSession session) throws UserException {

		System.out.println(result.getAllErrors());
		if (result.hasErrors()) {
			return "redirect:index";
		} else {
			
			if (new UserDAO().checkIfExistsUserWithThatEmail(user.getEmail()) != null) {
				
				model.addAttribute("existingEmailMessage", "A user with that email already exists! Please use another email! ");
				
				return "index";
			} else {
				try {
					
					new UserDAO().registerUser(user);
					session.setAttribute("user", user);
					
				} catch (UserException e) {
					model.addAttribute("error", e);
				}

				return "redirect:budget";
			}
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginForm(Model model, @ModelAttribute("user") User user, BindingResult result, HttpSession session)
			throws UserException, NoSuchAlgorithmException {

		Integer id = new UserDAO().loginUser(user.getEmail(), user.getPassword());
		if (id == null) {
			return "redirect:index";
		} else {
			user.setId(id);
			session.setAttribute("user", user);

			return "redirect:budget";
		}
	}

}
// https://www.youtube.com/watch?v=VFgUdHzJxk0
// http://stackoverflow.com/questions/4584410/redirect-in-spring-mvc
