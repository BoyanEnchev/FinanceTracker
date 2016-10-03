package com.financetracker.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BudgetController {

	@RequestMapping(value = "/budget", method = RequestMethod.GET)
	public String loadBudgetPage(Model model) {

		return "budget";
	}

}
