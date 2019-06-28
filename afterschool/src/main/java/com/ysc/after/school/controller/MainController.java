package com.ysc.after.school.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ysc.after.school.domain.db.Transform;
import com.ysc.after.school.domain.db.Transform.StatusType;
import com.ysc.after.school.service.TransformService;

@Controller
public class MainController {
	
	@Autowired
	private TransformService transformService;

	@GetMapping("/")
    public String index() throws Exception {
		if (transformService.get(1).getType() == StatusType.CLOSE) {
			return "default";
		}
		
		return "redirect:login";
    }
	
	@GetMapping("login")
    public void login(Model model, @RequestParam(value = "error", required = false) String error) {
		if (error != null) {
			model.addAttribute("error", "falied");
		}
	}
	
	@GetMapping("/system/open")
	public String open() {
		transformService.update(new Transform(1, StatusType.OPEN));
		return "success";
	}
	
	@GetMapping("/system/close")
	public String close() {
		transformService.update(new Transform(1, StatusType.CLOSE));
		return "success";
	}
}
