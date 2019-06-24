package com.ysc.after.school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

	@GetMapping("/")
    public String index() throws Exception {
        return "redirect:login";
    }
	
	@GetMapping("login")
    public void login(Model model, @RequestParam(value = "error", required = false) String error) {
		
		if (error != null) {
			model.addAttribute("error", "falied");
		}
	}
}
