package com.ysc.after.school.domain.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.ysc.after.school.domain.Domain;

import lombok.Data;

/**
 * 과목 관리 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_subject")
@Data
public class Subject implements Domain {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/** 이름 */
	@Column(nullable = false, length = 20)
	private String name;
	
	/** 강사 */
	@Column(nullable = false, length = 45)
	private String teacher;
	
	/** 대상 */
	@Column(nullable = false, length = 45)
	private String targer;
	
	/** 수강기간 */
	@Column(nullable = false, length = 255)
	private String period;
	
	/** 요일 */
	@Column(nullable = false, length = 45)
	private String week;
	
	/** 시작시간 */
	@Column(nullable = false, length = 20)
	private String startTime;
	
	/** 종료시간 */
	@Column(nullable = false, length = 20)
	private String endTime;
	
	/** 장소 */
	@Column(nullable = false, length = 255)
	private String location;
	
	/** 재료비 및 교구비 */
	private int cost;
	
	/** 재료비 및 교구비 부가적인 설명 */
	@Column(nullable = false, length = 45)
	private String costDesc;
	
	/** 정원 */
	private int fixedNumber;
	
	/** 과목특징 */
	@Column(nullable = false, length = 255)
	private String description;
	
	private int subjectGroupId;
}
