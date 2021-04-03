package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList(); 
	
	//CRUD 구현 
	public void insert(BoardVO ins); 
	public void insertKey(BoardVO ins); 
	public BoardVO read(Long bno); 
	public int delete(Long bno); 
	public int update(BoardVO upt); 
	public int reportUpdate(@Param("reporter") String reporter, @Param("bno") Long bno); 
	
	/*리스트 출력 */
	public List<BoardVO> getListPaging(@Param("cri") Criteria cri, @Param("kind") String kind); 
	public int getCount(@Param("cri") Criteria cri, @Param("kind") String kind);
	public List<BoardVO> topList(String kind);
	public List<BoardVO> topWriterList(String writer);
	public int getWriterCount(String writer);
	/* 댓글수 업데이트 */
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	/* 게시판 답글 관련 */
	public List<BoardVO> findByRefNo(Long bno);
	public int updateDel(Long bno);
	public int updateGno(@Param("gno") Long gno, @Param("bno") Long bno);
	public BoardVO findByLast(Long gno);
	public Long findByGno(Long refno);
	public int deleteGno(Long gno);
}
