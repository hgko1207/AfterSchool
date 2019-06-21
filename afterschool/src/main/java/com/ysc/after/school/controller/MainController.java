package com.ysc.after.school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@GetMapping("/")
    public String index() throws Exception {
        return "redirect:login";
    }
	
	@GetMapping("login")
    public void login() {
		
	}
}
