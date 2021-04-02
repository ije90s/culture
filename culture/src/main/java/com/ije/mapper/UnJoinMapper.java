package com.ije.mapper;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.UnjoinVO;

public interface UnJoinMapper {
	
	public void insert(UnjoinVO ins);
	public List<UnjoinVO> getList(Criteria cri);
	public int getCount();
	public UnjoinVO read(Long uno);
}
