package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.EventFileDto;
import gamedori.beans.dto.EventboardDto;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.event_participateDto;

public class EventboardDao {

	private static DataSource src;
	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// 연결 메소드
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		return src.getConnection();
	}

	public int getSequence() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT event_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int seq = rs.getInt(1);

		con.close();
		return seq;
	}

	// 게시물 단일 조회 메소드
	public EventboardDto get(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM event WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();

		EventboardDto edto = rs.next() ? new EventboardDto(rs) : null;
		con.close();

		return edto;
	}

	// 이벤트 파일 단일 조회 매소드
	public EventFileDto getfile(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM event_file WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();

		EventFileDto efdto = rs.next() ? new EventFileDto(rs) : null;
		con.close();

		return efdto;
	}

	// 게시물 등록 메소드
	public void write(EventboardDto edto) throws Exception {

		Connection con = getConnection();
		String sql = "INSERT INTO event" + "(" + "event_no, " + "member_no, " + "event_title, " + "event_content" + ") "
				+ "VALUES(?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, edto.getEvent_no());
		ps.setInt(2, edto.getMember_no());
		ps.setString(3, edto.getEvent_title());
		ps.setString(4, edto.getEvent_content());

		ps.execute();
		con.close();
	}

	// 작성자 메소드
	public MemberDto getWriter(int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT m.* " + "FROM member m INNER JOIN event e " + "ON m.member_no = e.member_no "
				+ "WHERE e.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();

		MemberDto mdto = rs.next() ? new MemberDto(rs) : null;

		con.close();

		return mdto;
	}

	// 이벤트 참여
	public EventboardDto getPartici_no(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT e.* " + "FROM event e INNER JOIN event_partici ep " + "ON e.event_no = ep.event_no "
				+ "WHERE ep.event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();

		EventboardDto edto = rs.next() ? new EventboardDto(rs) : null;

		con.close();

		return edto;
	}

	// 조회수 서블릿
	public void plusReadcount(int event_no, int member_no) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE event SET event_read = event_read + 1 WHERE event_no = ? and member_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ps.setInt(2, member_no);
		ps.execute();

		con.close();
	}

	// 개수 조회 메소드
	public int getCount() throws Exception {
		Connection con = getConnection();
		String sql = "select count(*) from event";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

	public int getCount(String type, String keyword) throws Exception {
		Connection con = getConnection();
		String sql = "select count(*) from event where instr(#1,?) > 0";
		
		sql = sql.replace("#1", type);
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, keyword);
		
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		
		int count = rs.getInt(1);

		con.close();

		return count;
	}

	public List<EventboardDto> search(String type, String keyword, int start, int finish) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM(SELECT ROWNUM rn, E.* FROM (SELECT * FROM event WHERE instr(#1, ?) > 0 ORDER BY event_no DESC) E ) WHERE rn BETWEEN ? AND ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, start);
		ps.setInt(3, finish);
		ResultSet rs = ps.executeQuery();

		List<EventboardDto> list = new ArrayList<>();
		while (rs.next()) {
			EventboardDto edto = new EventboardDto(rs);
			list.add(edto);
		}

		con.close();
		return list;
	}

	// 게시글 삭제
	public void delete(int event_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE event WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ps.execute();

		con.close();
	}

	// 게시글 수정
	public void edit(EventboardDto edto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE event SET event_title=?, event_content=? where event_no=?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, edto.getEvent_title());
		ps.setString(2, edto.getEvent_content());
		ps.setInt(3, edto.getEvent_no());
		ps.execute();

		con.close();
	}

	// 리스트
	public List<EventboardDto> getList(int start, int finish) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM (SELECT ROWNUM rn, E.* FROM( " + "SELECT * FROM event ORDER BY event_no DESC )E "
				+ ") WHERE rn BETWEEN ? AND ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, finish);
		ResultSet rs = ps.executeQuery();

		List<EventboardDto> list = new ArrayList<>();
		while (rs.next()) {
			EventboardDto bdto = new EventboardDto(rs);
			list.add(bdto);
		}

		con.close();
		return list;
	}

}