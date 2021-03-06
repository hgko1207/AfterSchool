package com.ysc.after.school.controller;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysc.after.school.domain.db.Student;
import com.ysc.after.school.domain.db.Student.TargetType;
import com.ysc.after.school.service.SchoolService;
import com.ysc.after.school.service.StudentService;

/**
 * 학생 관리 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("student")
public class StudentController {
	
	@Autowired
	private SchoolService schoolService;
	
	@Autowired
	private StudentService studentService;

	/**
	 * 학생 등록 화면
	 * @param model
	 */
	@GetMapping("regist")
	public void regist(Model model) { 
		model.addAttribute("schools", schoolService.getList().stream().map(data -> {
			if (data.getName().contains("분교")) {
				return data.getName();
			}
			return data.getName() + data.getSchoolType().getName();
		}).sorted().collect(Collectors.toList()));
	}
	
	/***
	 * 등록된 학생인지 확인
	 * @param student
	 * @return
	 */
	@GetMapping("search")
	@ResponseBody
	public boolean search(Student student) {
		return studentService.search(student);
	}
	
	/***
	 * 등록된 학생인지 확인
	 * @param student
	 * @return
	 */
	@GetMapping("jumin")
	@ResponseBody
	public boolean jumin(Student student) {
		return studentService.jumin(student);
	}
	
	/**
	 * 학생 등록 기능
	 * @param student
	 */
	@PostMapping(value = "regist")
	@ResponseBody
	public ResponseEntity<?> regist(Student student) {
		student.setTel(student.getService() + student.getTel());
		student.setTargetType(student.getSchool().contains("초등학교") ? TargetType.초등 : TargetType.중등);
		if (student.isAgree()) {
			student.setResidentNumber(student.getJumin1() + "-" + student.getJumin2());
		}
		
		if (studentService.regist(student)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
}
