package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.EventDto;
import gamedori.beans.dto.EventboardDto;





public class EventboardDao {

	//context.xml에서 관리하는 자원 객체를 참조할 수 있도록 연결 코드 구현
	private static DataSource src;//리모컨 선언
	
	//static 변수의 초기화가 복잡할 경우에 사용할 수 있는 static 전용 구문
	static {
		try {
			//src = context.xml에서 관리하는 자원의 정보;
			Context ctx = new InitialContext();//탐색 도구
			Context env = (Context) ctx.lookup("java:/comp/env");//Context 설정 탐색
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	//연결 메소드
	public Connection getConnection() throws Exception {

		return src.getConnection();
	}
	
	//목록 메소드
	public List<EventboardDto> getList() throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT * FROM event ORDER BY event_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<EventboardDto> list = new ArrayList<>();
		while(rs.next()) {
			EventboardDto edto = new EventboardDto(rs);
			list.add(edto);
		}
		
		con.close();
		return list;
	}
	
	//검색 메소드
	public List<EventDto> search1(String type, String keyword) throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT * FROM event "
								+ "WHERE instr(#1, ?) > 0 "
								+ "ORDER BY event_no DESC";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		
		List<EventDto> list = new ArrayList<>();
		while(rs.next()) {
			EventDto edto2 = new EventDto(rs);
			list.add(edto2);
		}
		
		con.close();
		return list;
	
}
	//단일조회
	public EventboardDto get(int event_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT * FROM event WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		

		EventboardDto edto = rs.next() ? new EventboardDto(rs) : null;//3항 연산자
		
		con.close();
		
		return edto;
	}
	
	//조회수 증가
		public void plusReadcount(int event_no, String member_id) throws Exception {
			Connection con = getConnection();
			
			String sql = "UPDATE event "
							+ "SET event_read = event_read + 1 "
							+ "WHERE event_no = ? and member_id != ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, event_no);
			ps.setString(2, member_id);
			ps.execute();
			
			con.close();
		}
		
		//시퀀스 생성
		// - dual 테이블은 오라클이 제공하는 임시 테이블
		public int getSequence() throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT event_seq.nextval FROM dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int seq = rs.getInt(1);//rs.getInt("NEXTVAL");
			
			con.close();
			
			return seq;
		}
		
		//등록
		// - 번호가 이미 생성되어서 bdto에 들어있으므로 시퀀스 사용 금지!
		// - bdto의 상황은 크게 두 가지 경우로 나뉜다
		//		1. bdto.getSuper_no() == 0 : 새글
		//		2. bdto.getSuper_no() > 0 : 답글
		// - bdto에 들어갈 데이터(상위글번호, 그룹번호, 차수정보)를 계산하여 등록!
		// - 새글 등록 기준
		//		- 상위글번호 : 0
		//		- 그룹번호 : 글번호와 동일
		//		- 차수 : 0
		// - 답글 등록 기준
		//		- 상위글번호 : 원본글번호
		//		- 그룹번호 : 원본글 그룹번호
		//		- 차수 : 원본글 차수 + 1
		public void write(EventDto edto) throws Exception {
			if(edto.getSuper_no() == 0) {//새글이면
				//bdto에는 5개의 정보가 들어있다(번호,말머리,제목,작성자,내용)
				//- 추가로 그룹번호를 설정해주어야 한다(나머지는 0)
				edto.setGroup_no(edto.getEvent_no());
				//bdto.setSuper_no(0);
				//bdto.setDepth(0);
			}
			else {//답글이면
				//bdto에는 6개의 정보가 들어있다(번호,말머리,제목,작성자,내용,상위글번호)
				//- 추가로 그룹번호와 차수를 설정해주어야 한다
				//- 원본글의 정보가 필요하므로 불러온다
				EventboardDto find = this.get(edto.getSuper_no());//상위글 정보 불러오기
				
				//- find를 이용하여 bdto에 그룹번호와 차수를 설정
				edto.setGroup_no(find.getGroup_no());
				edto.setDepth(find.getDepth() + 1);
			}
		}
			
			//위의 코드를 지나면 bdto에는 총 ?개의 정보가 들어간다.
			
			
			
			//아래와 같이 작성하면 미 작성된 항목들은 default 값이 적용
		
		
		//게시글 삭제
		public void delete(int event_no) throws Exception {
			Connection con = getConnection();

			String sql = "DELETE event WHERE event_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, event_no);
			ps.execute();
			
			con.close();
		}
		
		//게시글 수정
		public void edit(EventboardDto edto) throws Exception {
			Connection con = getConnection();
			
			String sql = "UPDATE event SET "
								+ "event_title=?, event_content=? "
								+ "where event_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, edto.getEvent_title());
			ps.setString(2, edto.getEvent_content());
			ps.setInt(3, edto.getEvent_no());
			ps.execute();
			
			con.close();
		}
		
		//댓글 개수 카운트
		//- 1번글의 댓글 개수를 알아내라!
		//- SELECT count(*) FROM reply WHERE reply_origin = 1
		//- 1번글의 댓글 개수를 5개로 변경해라!
		//- UPDATE board SET board_replycount = 5 WHERE board_no = 1
		//- 위의 두 구문을 합쳐서 실행하도록 구현
		public void editReplycount(int event_no) throws Exception {
			Connection con = getConnection();
			
			String sql = "UPDATE board "
								+ "SET board_replycount = ("
									+ "SELECT count(*) FROM reply WHERE reply_origin = ?"
								+ ") "
								+ "WHERE board_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, event_no);
			ps.setInt(2, event_no);
			ps.execute();
			
			con.close();
		}
		
		//개수 조회 메소드 x 2
		public int getCount() throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT count(*) FROM event";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();//데이터 무조건 1개 나오므로 이동
			int count = rs.getInt(4);//또는 rs.getInt("count(*)");
			
			con.close();
			
			return count;
		}
		
		
		public List<EventDto> getidlist() throws Exception{
			
			Connection con = getConnection();
			String sql= "select e.event_title, m.member_id, e.EVENT_CONTENT, e.EVENT_DATE,e.EVENT_READ,e.EVENT_NO from event e inner join member m on e.member_no = m.member_no";
			PreparedStatement ps= con.prepareStatement(sql);
			
			ResultSet rs= ps.executeQuery();
			List<EventDto> list = new ArrayList<>();
			
			while(rs.next()) {
			EventDto edto2 = new EventDto(rs);
			
			list.add(edto2);
				
			}
		
			con.close();
			return list; 
		}
	
		public List<EventDto> getList2() throws Exception{
			Connection con = getConnection();
			
			String sql = "SELECT * FROM event ORDER BY event_no DESC";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			List<EventDto> list = new ArrayList<>();
			while(rs.next()) {
				EventDto edto2 = new EventDto(rs);
				list.add(edto2);
			}
			
			con.close();
			return list;
		}
}
	


