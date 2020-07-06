package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

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
//		Class.forName("oracle.jdbc.OracleDriver");
//		return DriverManager.getConnection(
//				"jdbc:oracle:thin:@localhost:1521:xe", "c##kh", "c##kh");
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
	public List<EventboardDto> search(String type, String keyword) throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT * FROM event "
								+ "WHERE instr(#1, ?) > 0 "
								+ "ORDER BY event_no DESC";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		
		List<EventboardDto> list = new ArrayList<>();
		while(rs.next()) {
			EventboardDto edto = new EventboardDto(rs);
			list.add(edto);
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
						+ "WHERE event_no = ? and member_no != ?";
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

	public void write(EventboardDto edto) throws Exception {
		Connection con = getConnection();
		
		//아래와 같이 작성하면 미 작성된 항목들은 default 값이 적용
		String sql = 
		"INSERT INTO event"
		+ "(event_no, member_no, event_title, event_content, ) "
		+ "VALUES(?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, edto.getEvent_no());
		ps.setInt(2, edto.getMember_no());
		ps.setString(3, edto.getEvent_title());
		ps.setString(4, edto.getEvent_content());
		
		ps.execute();
		
		con.close();
	}
	
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
	

	}
	


