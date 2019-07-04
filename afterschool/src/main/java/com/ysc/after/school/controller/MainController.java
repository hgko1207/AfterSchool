package com.ysc.after.school.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ysc.after.school.domain.db.Setting;
import com.ysc.after.school.domain.db.Setting.SettingType;
import com.ysc.after.school.domain.db.Setting.StatusType;
import com.ysc.after.school.service.SettingService;

@Controller
public class MainController {
	
	@Autowired
	private SettingService settingService;

	@GetMapping("/")
    public String index() throws Exception {
		if (settingService.get(SettingType.MOBILE).getStatus() == StatusType.CLOSE) {
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
		Setting setting = settingService.get(SettingType.MOBILE);
		setting.setStatus(StatusType.OPEN);
		settingService.update(setting);
		return "success";
	}
	
	@GetMapping("/system/close")
	public String close() {
		Setting setting = settingService.get(SettingType.MOBILE);
		setting.setStatus(StatusType.CLOSE);
		settingService.update(setting);
		return "success";
	}
}
