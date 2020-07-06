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

import gamedori.beans.dto.FAQDto;

public class FAQDao {
	
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
	public List<FAQDto> getList() throws Exception{
		Connection con = getConnection();
		
//		String sql = "SELECT * FROM FAQ ORDER BY FAQ_no DESC";
		
//		트리 정렬 : 상하 관계로 연결되어 있는 구조의 데이터를 불러오기 위한 정렬방식
//		- CONNECT BY PRIOR를 이용하여 항목을 연결하며 상하관계를 알려준다
//		- START WITH 를 이용하여 시작 지점을 알려준다
//		- ORDER SIBLINGS BY를 이용하여 정렬 순서를 알려준다
		
//		아래의 구문은 다음의 뜻을 가진다.
//		"게시글들을 
//		FAQ_no와 super_no가 같으면 연결되어 있는 것으로 생각하고
//		super_no가 NULL인 항목부터 시작해서 추출해라.
//		이렇게 추출되는 글 그룹들을 그룹번호 내림차순, 글번호 오름차순으로 정렬해라!"
		String sql = "SELECT * FROM FAQ oder by faq_no desc";	
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<FAQDto> list = new ArrayList<>();
		while(rs.next()) {
			FAQDto fdto = new FAQDto(rs);
			list.add(fdto);
		}
		
		con.close();
		return list;
	}
	
	//검색 메소드
	public List<FAQDto> search(String type, String keyword) throws Exception{
		Connection con = getConnection();
		
		String sql = 
							"SELECT * FROM FAQ "
								+ "WHERE instr(#1, ?) > 0 "
								+ "ORDER BY FAQ_no ASC";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		List<FAQDto> list = new ArrayList<>();
		while(rs.next()) {
			FAQDto fdto = new FAQDto(rs);
			list.add(fdto);
		}
		
		con.close();
		return list;
	}
	
	//단일조회
	public FAQDto get(int faq_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT * FROM FAQ WHERE FAQ_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faq_no);
		ResultSet rs = ps.executeQuery();
		
//		FAQDto fdto = 객체 or null;
//		FAQDto fdto;
//		if(rs.next()) {
//			fdto = new FAQDto(rs);
//		}
//		else {
//			fdto = null;
//		}
		FAQDto fdto = rs.next() ? new FAQDto(rs) : null;//3항 연산자
		
		con.close();
		
		return fdto;
	}
	
	//조회수 증가
	public void plusReadcount(int faq_no, int member_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "UPDATE FAQ "
						+ "SET FAQ_read = FAQ_read + 1 "
						+ "WHERE FAQ_no = ? and FAQ_writer_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faq_no);
		ps.setInt(2, member_no);
		ps.execute();
		
		con.close();
	}
	
	//시퀀스 생성
	// - dual 테이블은 오라클이 제공하는 임시 테이블
	public int getSequence() throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT FAQ_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);//rs.getInt("NEXTVAL");
		
		con.close();
		
		return seq;
	}
	
	//등록
	// - 번호가 이미 생성되어서 fdto에 들어있으므로 시퀀스 사용 금지!
	// - fdto의 상황은 크게 두 가지 경우로 나뉜다
	//		1. fdto.getSuper_no() == 0 : 새글
	//		2. fdto.getSuper_no() > 0 : 답글
	// - fdto에 들어갈 데이터(상위글번호, 그룹번호, 차수정보)를 계산하여 등록!
	// - 새글 등록 기준
	//		- 상위글번호 : 0
	//		- 그룹번호 : 글번호와 동일
	//		- 차수 : 0
	// - 답글 등록 기준
	//		- 상위글번호 : 원본글번호
	//		- 그룹번호 : 원본글 그룹번호
	//		- 차수 : 원본글 차수 + 1
	public void write(FAQDto fdto) throws Exception {		
		Connection con = getConnection();
		String sql = "INSERT INTO FAQ"
								+ "("
									+ "FAQ_no, "
									+ "FAQ_head, "
									+ "FAQ_title, "
									+ "FAQ_writer_no, "
									+ "FAQ_content,"
								+ ") "
						+ "VALUES(?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fdto.getFaq_no());
		ps.setString(2, fdto.getFaq_head());
		ps.setString(3, fdto.getFaq_title());
		ps.setInt(4, fdto.getFaq_writer_no());
		ps.setString(5, fdto.getFaq_content());
		ps.execute();
		
		con.close();
	}
	
	//게시글 삭제
	public void delete(int faq_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE FAQ WHERE FAQ_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, faq_no);
		ps.execute();
		
		con.close();
	}
	
	//게시글 수정
	public void edit(FAQDto fdto) throws Exception {
		Connection con = getConnection();
		
		String sql = "UPDATE FAQ SET "
							+ "FAQ_head=?, FAQ_title=?, FAQ_content=? "
							+ "where FAQ_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, fdto.getFaq_head());
		ps.setString(2, fdto.getFaq_title());
		ps.setString(3, fdto.getFaq_content());
		ps.setInt(4, fdto.getFaq_no());
		ps.execute();
		
		con.close();
	}
	

	//개수 조회 메소드 x 2
	public int getCount() throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT count(*) FROM FAQ";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();//데이터 무조건 1개 나오므로 이동
		int count = rs.getInt(1);//또는 rs.getInt("count(*)");
		
		con.close();
		
		return count;
	}
	public int getCount(String type, String keyword) throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT count(*) FROM FAQ WHERE instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();//데이터 무조건 1개 나오므로 이동
		int count = rs.getInt(1);//또는 rs.getInt("count(*)");
		
		con.close();
		
		return count;
	}
}