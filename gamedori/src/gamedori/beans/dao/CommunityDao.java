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

import gamedori.beans.dto.CommunityDto;
import gamedori.beans.dto.MemberDto;

public class CommunityDao {
	
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
	
	// community_no 추출 메소드
	public int getSequence() throws Exception{
		Connection con = getConnection();
		String sql = "SELECT commu_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	// 게시물 단일 조회 메소드
	public CommunityDto get(int commu_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM community WHERE commu_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commu_no);
		ResultSet rs = ps.executeQuery();
		
		CommunityDto cdto = rs.next()? new CommunityDto(rs): null;
		con.close();
		
		return cdto;
	}
	
	// 게시물 등록 메소드
	public void write(CommunityDto cdto) throws Exception{
		if(cdto.getCommu_super_no() == 0) {
			cdto.setCommu_group_no(cdto.getCommu_no());
		} else {
			CommunityDto find = this.get(cdto.getCommu_super_no());
			cdto.setCommu_group_no(find.getCommu_group_no());
			cdto.setCommu_depth(find.getCommu_depth()+1);
		}
		
		Connection con = getConnection();
		String sql = "INSERT INTO community"
				+ "("
				+ "commu_no, "
				+ "member_no, "
				+ "commu_head, "
				+ "commu_title, "
				+ "commu_content, "
				+ "commu_super_no, "
				+ "commu_group_no, "
				+ "commu_depth"
				+ ") "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, cdto.getCommu_no());
		ps.setInt(2, cdto.getMember_no());
		ps.setString(3, cdto.getCommu_head());
		ps.setString(4, cdto.getCommu_title());
		ps.setString(5, cdto.getCommu_content());
		
		if(cdto.getCommu_super_no() == 0) {
			ps.setNull(6, Types.INTEGER);
		} else {
			ps.setInt(6, cdto.getCommu_super_no());
		}
		ps.setInt(7, cdto.getCommu_group_no());
		ps.setInt(8, cdto.getCommu_depth());
		ps.execute();
		con.close();
	}
	
	// 작성자 메소드
	public MemberDto getWriter(int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT m.* "
				+ "FROM member m INNER JOIN community c "
				+ "ON m.member_no = c.member_no "
				+ "WHERE c.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		MemberDto mdto = rs.next()? new MemberDto(rs): null;
		
		con.close();
		
		return mdto;
	}
	
	// 게시물 목록 메소드
	public List<CommunityDto> getList(int start, int finish) throws Exception{
		Connection con = getConnection();
		String sql = "SELECT ROWNUM rn, T.* FROM("
				+ "SELECT * FROM community "
				+ "CONNECT BY PRIOR commu_no = commu_super_no "  
				+ "START WITH commu_super_no IS NULL " 
				+ "ORDER SIBLINGS BY commu_group_no DESC, commu_no ASC"
				+ ")T"
			+ ") WHERE rn BETWEEN ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, finish);
		ResultSet rs = ps.executeQuery();
		
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		while(rs.next()) {
			CommunityDto cdto = new CommunityDto(rs);
			list.add(cdto);
		}
		con.close();
		return list;
	}
	
	// 조회수 서블릿
	public void plusReadCount(int commu_no, int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "UPDATE community "
				+ "SET commu_read = commu_read + 1 "
				+ "WHERE commu_no = ? "
				+ "AND member_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commu_no);
		ps.setInt(2, member_no);
		ps.execute();
		
		con.close();
	}
	
	// 검색 서블릿
	public List<CommunityDto> search(String type, String keyword, int start, int finish) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT ROWNUM rn, T.* FROM("
						+"SELECT * FROM community "
						+ "WHERE instr(#1, ?) > 0 "
						+ "CONNECT BY PRIOR commu_no = commu_super_no "  
						+ "START WITH commu_super_no IS NULL " 
						+ "ORDER SIBLINGS BY commu_group_no DESC, commu_no ASC"
						+ ")T"
					+ ") WHERE rn BETWEEN ? and ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, start);
		ps.setInt(3, finish);
		ResultSet rs = ps.executeQuery();
		
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		
		while(rs.next()) {
			CommunityDto cdto = new CommunityDto(rs);
			list.add(cdto);
		}
		
		con.close();
		return list;
	}

}
