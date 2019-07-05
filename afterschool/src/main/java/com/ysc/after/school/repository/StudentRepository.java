package com.ysc.after.school.repository;

import com.ysc.after.school.domain.db.Student;

public interface StudentRepository extends DefaultRepository<Student, Integer> {

	Student findByNameAndTel(String name, String tel);

	Student findByResidentNumber(String residentNumber);

	Student findByNameAndTelAndGradeAndClassTypeAndNumber(String name, String string, 
			int grade, int classType, int number);

}
