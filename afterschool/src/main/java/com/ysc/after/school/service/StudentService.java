package com.ysc.after.school.service;

import com.ysc.after.school.domain.db.Student;

public interface StudentService extends CRUDService<Student> {

	Student login(String name, String tel);

	boolean search(Student student);

	boolean jumin(Student student);

}
