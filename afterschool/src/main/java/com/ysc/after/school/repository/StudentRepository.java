package com.ysc.after.school.repository;

import com.ysc.after.school.domain.db.Student;

public interface StudentRepository extends DefaultRepository<Student, Integer> {

	Student findByNameAndTel(String name, String tel);

}
