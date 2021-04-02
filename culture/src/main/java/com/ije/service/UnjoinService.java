package com.ije.service;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.UnjoinVO;

public interface UnjoinService {
	public void register(UnjoinVO ins);
	public List<UnjoinVO> getList(Criteria cri); 
	public int getCount();
	public UnjoinVO get(Long uno);
}
