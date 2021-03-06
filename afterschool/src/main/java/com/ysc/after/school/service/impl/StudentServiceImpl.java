package com.ysc.after.school.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.after.school.domain.db.Student;
import com.ysc.after.school.repository.StudentRepository;
import com.ysc.after.school.service.StudentService;

@Transactional
@Service
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentRepository studentRepository;

	@Override
	public List<Student> getList() {
		return studentRepository.findAll();
	}

	@Override
	public boolean regist(Student domain) {
		if (isNew(domain)) {
			return studentRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(Student domain) {
		if (!isNew(domain)) {
			return studentRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Integer id) {
		studentRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Student domain) {
		return !studentRepository.existsById(domain.getId());
	}

	@Override
	public Student login(String name, String tel) {
		return studentRepository.findByNameAndTel(name, tel);
	}

	@Override
	public boolean search(Student student) {
		return studentRepository.findByNameAndTel(student.getName(), student.getService() + student.getTel()) != null;
	}

	@Override
	public boolean jumin(Student student) {
		return studentRepository.findByResidentNumber(student.getJumin1() + "-" + student.getJumin2()) != null;
	}

	@Override
	public Student get(Integer id) {
		return studentRepository.findById(id).get();
	}

}