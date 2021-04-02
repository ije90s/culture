package com.ije.service;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.MemberLogVO;

public interface MemberLogService {
	
	public List<MemberLogVO> getList(Criteria cri); 
	public int getCount(Criteria cri);
	public MemberLogVO get(Long lno); 
	public boolean register(MemberLogVO ins); 
	public boolean modify(MemberLogVO upt); 
	public boolean remove(Long lno);
	public List<MemberLogVO> getByTarget(Criteria cri, String target); 
	public int getByTargetCount(String target);
}
