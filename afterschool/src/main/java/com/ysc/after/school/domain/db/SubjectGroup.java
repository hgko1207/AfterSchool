package com.ysc.after.school.domain.db;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.ysc.after.school.domain.Domain;

import lombok.Data;

/**
 * 과목 그룹 관리 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_subject_group")
@Data
public class SubjectGroup implements Domain {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/** 이름 */
	@Column(nullable = false, length = 20)
	private String name;
	
	/** 설명 */
	@Column(nullable = false, length = 255)
	private String description;
	
	@CreationTimestamp
	private LocalDateTime createDate;
	
	@UpdateTimestamp
	private LocalDateTime updateDate;
}
