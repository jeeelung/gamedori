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

import gamedori.beans.dto.CommunityDto;
import gamedori.beans.dto.EventboardDto;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.ReplyDto;
public class ReplyDao {

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
	
	public Connection getConnection() throws Exception{
		return src.getConnection();
	}

	
	//  reply추출 메소드
		public int getSequence() throws Exception{
			Connection con = getConnection();
			String sql = "SELECT reply_.nextval FROM dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			int seq = rs.getInt(1);
			
			con.close();
			return seq;
		}
	//단일 조화
		public ReplyDto get(int reply_no) throws Exception {
			Connection con = getConnection();
			String sql = "SELECT * FROM reply WHERE reply_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, reply_no);
			ResultSet rs = ps.executeQuery();
			
			ReplyDto rdto = rs.next()? new ReplyDto(rs): null;
			con.close();
			
			return rdto;
		}
		//작성자 조회
		public MemberDto getWriter(int member_no) throws Exception {
			Connection con = getConnection();
			String sql = "SELECT m.* "
					+ "FROM member m INNER JOIN reply r "
					+ "ON m.member_no = r.member_no "
					+ "WHERE r.member_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, member_no);
			ResultSet rs = ps.executeQuery();
			
			MemberDto mdto = rs.next()? new MemberDto(rs): null;
			
			con.close();
			
			return mdto;
		}
		
		
		
	
		// 게시물 등록 메소드
		public void write(ReplyDto rdto) throws Exception{
			if(rdto.getReply_super_no() == 0) {
				rdto.setReply_group_no(rdto.getReply_no());
			} else {
				ReplyDto find = this.get(rdto.getReply_super_no());
				rdto.setReply_group_no(find.getReply_group_no());
				rdto.setReply_depth(find.getReply_depth()+1);
			}
			
			Connection con = getConnection();
			String sql = "INSERT INTO reply"
					+ "("
					+ "reply_no, "
					+ "member_no, "
					+ "reply_content, "
					+ "reply_date, "
					+ "reply_super_no, "
					+ "reply_group_no, "
					+ "reply_depth"
					+ ") "
					+ "values(reply_seq.nextval, ?, ?, sysdate, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, rdto.getMember_no());
			ps.setString(2, rdto.getReply_content());
			
			
			if(rdto.getReply_super_no() == 0) {
				ps.setNull(3, Types.INTEGER);
			} else {
				ps.setInt(3, rdto.getReply_super_no());
			}
			ps.setInt(4, rdto.getReply_group_no());
			ps.setInt(5, rdto.getReply_depth());
			
			ps.execute();
			con.close();
		}
		
		//삭제
		public void delete(int reply_no) throws Exception{
			Connection con = getConnection();
			
			String sql = "DELETE reply WHERE reply_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, reply_no);
			ps.execute();
			
			con.close();
		}
		//리스트 조회
		public List<ReplyDto> getList(int start, int finish) throws Exception{
			Connection con = getConnection();
			String sql = "SELECT * FROM( "
						+ "SELECT ROWNUM rn, T.* FROM( "
						+ "SELECT * FROM reply "
						+ "CONNECT BY PRIOR reply_no = reply_super_no "  
						+ "START WITH reply_super_no IS NULL " 
						+ "ORDER SIBLINGS BY reply_group_no DESC, reply_no ASC"
						+ ")T"
					+ ") WHERE rn BETWEEN ? and ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, finish);
			ResultSet rs = ps.executeQuery();
			
			List<ReplyDto> list = new ArrayList<ReplyDto>();
			while(rs.next()) {
				ReplyDto rdto = new ReplyDto(rs);
				list.add(rdto);
			}
			con.close();
			return list;
		}
}
	
	


