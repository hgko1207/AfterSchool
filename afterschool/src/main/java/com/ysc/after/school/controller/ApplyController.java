package com.ysc.after.school.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.after.school.domain.db.Student;

/**
 * 수강신청 관리 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("apply")
public class ApplyController {

	/**
	 * 수강 신청 정보 화면
	 * @param model
	 */
	@GetMapping("info")
	public void info(Model model, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();
		
		model.addAttribute("name", student.getName());
		model.addAttribute("student", student.getGrade() + "학년 " + student.getClassType() + "반 " + student.getNumber() + "번");
	}
	
	/**
	 * 수강 신청 화면
	 * @param model
	 */
	@GetMapping("subscribe")
	public void subscribe(Model model) { 
	}
	
	/**
	 * 수강 신청 확인 화면
	 * @param model
	 */
	@GetMapping("mylist")
	public void mylist(Model model) { 
	}
}
