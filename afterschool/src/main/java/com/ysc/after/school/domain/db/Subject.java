package com.ysc.after.school.domain.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
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
	@Column(nullable = false, length = 255)
	private String name;
	
	/** 강사 */
	@Column(nullable = false, length = 45)
	private String teacher;
	
	/** 대상 */
	@Column(nullable = false, length = 45)
	private String target;
	
	/** 수강기간 */
	@Column(nullable = false, length = 255)
	private String period;
	
	/** 요일 */
	@Column(nullable = false, length = 45)
	private String week;
	
	/** 운영시간 */
	@Column(nullable = false, length = 45)
	private String time;
	
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
	
	/** 수강신청 인원 */
	private int applyNumber;
	
	/** 수강대기 인원 */
	private int waitNumber;
	
	/** 수강신청 시작 날짜 */
	@Column(nullable = false, length = 20)
	private String applyStartTime;
	
	/** 수강신청 종료 날짜 */
	@Column(nullable = false, length = 20)
	private String applyEndTime;
	
	/** 과목특징 */
	@Column(nullable = false, length = 255)
	private String description;
	
	private int subjectGroupId;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private ApplyType applyType;
	
	public enum ApplyType {
		NONE, APPLY, WAIT;
	}
}
