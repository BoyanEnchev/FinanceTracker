package com.financetracker.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.financetracker.model.User;

@Controller
public class TestController {
	
	@RequestMapping(value = "/NewFile", method = RequestMethod.GET)
	public String loadStartPage(Model model) {
		
	

		return "NewFile";
	}

}
