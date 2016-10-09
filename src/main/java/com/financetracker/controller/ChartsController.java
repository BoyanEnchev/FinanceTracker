package com.financetracker.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChartsController {

	@RequestMapping(value = "/charts", method = RequestMethod.GET)
	public String loadBudgetPage(Model model, HttpSession session){
	

		return "charts";
	}
	
}
