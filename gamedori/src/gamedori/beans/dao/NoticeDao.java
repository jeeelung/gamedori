package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.NoticeDto;

public class NoticeDao {

	private static DataSource src;// 리모컨 선언

	// static 변수의 초기화가 복잡할 경우에 사용할 수 있는 static 전용 구문
	static {
		try {
			// src = context.xml에서 관리하는 자원의 정보;
			Context ctx = new InitialContext();// 탐색 도구
			Context env = (Context) ctx.lookup("java:/comp/env");// Context 설정 탐색
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// 연결 메소드
	public Connection getConnection() throws Exception {
		return src.getConnection();
	}

	// 목록 메소드
	public List<NoticeDto> getList() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM notice ORDER BY notice_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<NoticeDto> list = new ArrayList<>();
		while (rs.next()) {
			NoticeDto ndto = new NoticeDto(rs);
			list.add(ndto);
		}

		con.close();
		return list;
	}

	// 검색 메소드
	public List<NoticeDto> search(String type, String keyword) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM notice " + "WHERE instr(#1, ?) > 0 " + "ORDER BY notice_no DESC";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<NoticeDto> list = new ArrayList<>();
		while (rs.next()) {
			NoticeDto ndto = new NoticeDto(rs);
			list.add(ndto);
		}

		con.close();
		return list;
	}

	// 단일조회
	public NoticeDto get(int notice_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM notice WHERE notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ResultSet rs = ps.executeQuery();

		NoticeDto ndto = rs.next() ? new NoticeDto(rs) : null;// 3항 연산자

		con.close();

		return ndto;
	}

	// 조회수 증가
	public void plusReadcount(int notice_no, String member_id) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE notice " + "SET notice_read = notice_read + 1 " + "WHERE notice_no = ? and member_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ps.setString(2, member_id);
		ps.execute();

		con.close();
	}

	// 시퀀스 생성
	// - dual 테이블은 오라클이 제공하는 임시 테이블
	public int getSequence() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT notice_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);// rs.getInt("NEXTVAL");

		con.close();

		return seq;
	}

	// 등록 메소드
	public void write(NoticeDto ndto) throws Exception {
		if (ndto.getSuper_no() == 0) {// 새글이면
			ndto.setGroup_no(ndto.getNotice_no());
		} else {// 답글이면
				
			NoticeDto find = this.get(ndto.getSuper_no());// 상위글 정보 불러오기

			// - find를 이용하여 ndto에 그룹번호와 차수를 설정
			ndto.setGroup_no(find.getGroup_no());
			ndto.setDepth(find.getDepth() + 1);
		}

		// 위의 코드를 지나면 bdto에는 총 ?개의 정보가 들어간다.

		Connection con = getConnection();

		// 아래와 같이 작성하면 미 작성된 항목들은 default 값이 적용
		String sql = "INSERT INTO notice" + "(" + "notice_no, " + "member_no, " + "notice_title," 
				+ "notice_content," + "super_no, " + "group_no, " + "depth" + ") " + "VALUES(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, ndto.getNotice_no());
		ps.setInt(2, ndto.getMember_no());
		ps.setString(3, ndto.getNotice_title());		
		ps.setString(4, ndto.getNotice_content());
		if (ndto.getSuper_no() == 0) {// 새글이면 NULL을 설정
			ps.setNull(5, Types.INTEGER);
		} else {// 답글이면 번호를 설정
			ps.setInt(5, ndto.getSuper_no());
		}
		ps.setInt(6, ndto.getGroup_no());
		ps.setInt(7, ndto.getDepth());
		ps.execute();

		con.close();
	}

	// 게시글 삭제
	public void delete(int notice_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE notice WHERE notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ps.execute();

		con.close();
	}

	// 게시글 수정
	public void edit(NoticeDto ndto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE notice SET " + "notice_title=?, notice_content=?, where notice_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, ndto.getNotice_title());
		ps.setString(2, ndto.getNotice_content());
		ps.setInt(3, ndto.getMember_no());
		ps.execute();

		con.close();
	}

}
