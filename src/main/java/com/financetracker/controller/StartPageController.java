package com.financetracker.controller;


import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.exception.UserException;
import com.financetracker.model.User;
import com.financetracker.model.UserDAO;



@Controller
public class StartPageController {

	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String loadStartPage(Model model) {
		model.addAttribute(new User());
		return "index";
	}	
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String registerForm(Model model, @Valid @ModelAttribute("registerForm")User user, BindingResult result) {
		System.err.println("Vlizash li se registreruash");
		if(result.hasErrors()){
			return "redirect:index";
		}else{
			try {
				new UserDAO().registerUser(user);
			} catch (UserException e) {
				model.addAttribute(e);
			}
			return "budget";
		}
	}	

}
//https://www.youtube.com/watch?v=VFgUdHzJxk0
//	http://stackoverflow.com/questions/4584410/redirect-in-spring-mvc
	