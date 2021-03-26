package com.ije.mapper;



import org.apache.ibatis.annotations.Param;

import com.ije.domain.LoginVO;

public interface LoginMapper {
	
	public LoginVO read(@Param("id") String id, @Param("rdate") String rdate);
	
	public void insert(LoginVO ins);
	
	public int getCount(String id);
}
