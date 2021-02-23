#문화기록[culture] 카테고리 개발일지 
목적 : 완료, 오류 및 해결책 등의 세세한 내용 기입
1. 테이블 생성
- 테이블명 : culture 
- 필드 : cno(PK), cdate, kind, title, content, rank, rdate, update, mno(FK) 
         추후에 mno를 FK로 추가할 예정(member테이블 생성X) 
2. 영속 계층 CRUD 구현 
- VO : CultureVO 
- Mapper 인터페이스, Mapper XML : CultureMapper
- CRUD 구현하기 전, culture 전체 리스트를 가져오는 sql 테스트 
- CRUD 구현 후, 각각 테스트
  C(insert)부분에 cdate는 sysdate로 고정으로 테스트(추후에 날짜를 넣어 테스트할 예정)
3. 비즈니스 계층 CRUD 구현 
- CultureService, CultureServiceImpl(CultureService Implement)
- 영속계층에 만들어낸 CRUD를 토대로 Service계층을 구현 후, 각각 테스트 
========================================================================================
VO > Mapper > Service순 까먹지 말 것. 
급하게 말고 천천히 테스트 해보며 진행할 것. 
git에 대한 지식이 부족하여 현 프로젝트를 repository하는데 시간이 오래 걸림 >> 지식 습득 필요 
========================================================================================
