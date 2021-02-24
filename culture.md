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
  C(insert)부분에 cdate는 sysdate로 고정으로 테스트 >> 임의의 날짜 데이트도 잘 들어가는지 확인 완료
3. 비즈니스 계층 CRUD 구현 
- CultureService, CultureServiceImpl(CultureService Implement)
- 영속계층에 만들어낸 CRUD를 토대로 Service계층을 구현 후, 각각 테스트 
========================================================================================
VO > Mapper > Service순 까먹지 말 것. 
급하게 말고 천천히 테스트 해보며 진행할 것. 
git에 대한 지식이 부족하여 현 프로젝트를 repository하는데 시간이 오래 걸림 >> 지식 습득 필요 
========================================================================================
4. 웹 계층 CRUD 구현 
- CultureController에 아래와 같은 표로 구현 
|구분|URL|Method|Parameter|From|URL이동|
|---|--------|---|---|--------|---|
|목록|/culture/list|get||||
|상세|/culture/get|get|cno|||
|등록|/culture/register|post|모든항목|입력화면필요|O|
|수정|/culture/modify|post|모든항목|입력화면필요|O|
|삭제|/culture/remove|post|cno|입력화면필요|O|
- MockMVC로 각각 화면 테스트 
5. 화면단 처리 
- [부트스트랩을 이용] : https://startbootstrap.com/theme/sb-admin-2
- 나의 기록 목록 화면 완료, 현재 등록폼 작성중 
========================================================================================
오류 : java.lang.NoClassDefFoundError: javax/servlet/SessionCookieConfig
Junit으로 테스트 케이스를 만들어 세션에 어떤 작업을 할 때, MockHttpSession 객체를 생성하게 되는데, 서블릿 버전 3.1 이하에서는 SessionCookieConfig 클래스를 찾지 못하는 오류가 발생  
해결책 : 서블릿 jar 파일을 3.1 버전으로 업데이트 해 주면 해결된다.
오류 : java.lang.IllegalStateException: Failed to load ApplicationContext
Caused by: java.io.FileNotFoundException: src\main\webapp\WEB-INF\spring\servlet-context.xml (지정된 파일을 찾을 수 없습니다)
해결책 : 파일 경로가 제대로 되는지 한번 더 체크 
두개의 오류가 발생한 이유는 테스트를 급하게 하느라 발생하는 것으로, 한번 더 체크하는 습관을 들이도록 하자
========================================================================================
- 상세, 등록, 수정, 삭제 완료 
- 등록/수정/삭제 처리 후, 모달창 띄우기 완료 
========================================================================================
오류 : 뒤로가기 문제 
등록 처리 후, 다시 뒤로 갔다가 되돌아오면 모달창이 띄워지는 문제가 발생
해결책 : history API의 replaceState 이용하여 초기화해준 뒤, 모달창 나오지 않게 막음  
========================================================================================