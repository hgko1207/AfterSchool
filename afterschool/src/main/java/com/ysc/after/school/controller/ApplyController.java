package com.ysc.after.school.controller;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.after.school.domain.db.Apply;
import com.ysc.after.school.domain.db.Student;
import com.ysc.after.school.domain.db.Student.TargetType;
import com.ysc.after.school.domain.db.Subject;
import com.ysc.after.school.domain.db.Subject.ApplyType;
import com.ysc.after.school.service.ApplyService;
import com.ysc.after.school.service.GuidanceService;
import com.ysc.after.school.service.SubjectGroupService;
import com.ysc.after.school.service.SubjectService;

/**
 * 수강신청 관리 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("apply")
public class ApplyController {
	
	@Autowired
	private SubjectGroupService subjectGroupService;
	
	@Autowired
	private SubjectService subjectService;
	
	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private GuidanceService guidanceService;

	/**
	 * 수강 신청 정보 화면
	 * @param model
	 */
	@GetMapping("info")
	public void info(Model model, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();
		model.addAttribute("guidance", guidanceService.get(1));
		model.addAttribute("name", student.getName());
		model.addAttribute("student", student.getGrade() + "학년 " + student.getClassType() + "반 " + student.getNumber() + "번");
	}
	
	/**
	 * 수강 그룹 리스트 화면
	 * @param model
	 */
	@GetMapping("subscribe1")
	public void subscribe1(Model model) {
		model.addAttribute("subjectGroups", subjectGroupService.getList());
	}
	
	/**
	 * 수강 신청 리스트 화면
	 * @param model
	 */
	@GetMapping("subscribe2")
	public void subscribe2(Model model, int groupId, Authentication authentication) { 
		Student student = (Student) authentication.getPrincipal();
		
		List<Subject> subjects = subjectService.getList(groupId).stream()
//		.filter(subject -> {
//			if (subject.getTargetType() == TargetType.전체 || subject.getTargetType() == student.getTargetType()
//					|| subject.getTargetType() == TargetType.초_중등) {
//				return subject.targetTrue(subject.getGradeType(), student.getGrade());
//			}
//			
//			return false;
//		})		
		.map(data -> {
			if (applyService.search(student.getId(), data.getId())) {
				data.setApplyType(ApplyType.APPLY);
			} else if (data.getFixedNumber() <= data.getApplyNumber()) {
				data.setApplyType(ApplyType.FILL);
			} else {
				if (data.getTargetType() == TargetType.전체 || data.getTargetType() == student.getTargetType()
						|| data.getTargetType() == TargetType.초_중등) {
					if (data.targetTrue(data.getGradeType(), student.getGrade())) {
						data.setApplyType(ApplyType.NONE);
					} else {
						data.setApplyType(ApplyType.NOTAPPLY);
					}
				} else {
					data.setApplyType(ApplyType.NOTAPPLY);
				}
			}
			data.setTarget(data.getTargetType().getName() + " " + data.getGradeType().getName());
			return data;
		}).sorted(Comparator.comparing(subject -> subject.getOrdered())).collect(Collectors.toList());
		
		model.addAttribute("subjectGroup", subjectGroupService.get(groupId));
		model.addAttribute("subjects", subjects);
	}
	
	/**
	 * 수강 신청 기능
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@PostMapping("regist")
	public ResponseEntity<?> regist(int subjectId, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();

		List<Apply> applies = applyService.getList(student.getId());
		if (applies.size() == 2) {
			return new ResponseEntity<String>("한 학생이 최대 2개 강좌까지<br> 신청 할 수 있습니다.", HttpStatus.BAD_REQUEST);
		}
		
		Subject subject = subjectService.get(subjectId);
		if (subject.getFixedNumber() <= subject.getApplyNumber()) {
			return new ResponseEntity<String>("정원 초과입니다.", HttpStatus.BAD_REQUEST);
		}
		
		if (applyService.regist(new Apply(student.getId(), subject))) {
			subject.setApplyNumber(subject.getApplyNumber() + 1);
			subjectService.update(subject);
			return new ResponseEntity<>(HttpStatus.OK);
		}
		
		return new ResponseEntity<String>("수강신청 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
	
	/**
	 * 수강 취소 기능
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@DeleteMapping("delete")
	public ResponseEntity<?> delete(int applyId) {
		Apply apply = applyService.get(applyId);
		if (applyService.delete(apply)) {
			Subject subject = apply.getSubject();
			subject.setApplyNumber(subject.getApplyNumber() - 1);
			subjectService.update(subject);
			return new ResponseEntity<>(HttpStatus.OK);
		}
		return new ResponseEntity<String>("수강취소 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
	
	/**
	 * 수강 신청 확인 화면
	 * @param model
	 */
	@GetMapping("mylist")
	public void mylist(Model model, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();
		
		model.addAttribute("applies", applyService.getList(student.getId()));
	}
}
