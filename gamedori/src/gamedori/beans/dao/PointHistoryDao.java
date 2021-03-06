package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.PointDto;
import gamedori.beans.dto.PointHistoryDto;

public class PointHistoryDao {private static DataSource src;
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

// 등록
	public void insert(PointHistoryDto phdto ,int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "INSERT INTO Point_history VALUES(point_his_seq.nextval, ? , ? , sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, member_no);
		ps.setInt(2, phdto.getPoint_no());
		ps.execute();

		con.close();
	}

	// 수정
	public void edit(PointHistoryDto phdto) throws Exception {
		Connection con = getConnection();
		String sql = "UPDATE point_history SET point_his_no=?,member_no=? , point_no=? , point_his_date where point_no=?";
	
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, phdto.getPoint_his_no());
		ps.setInt(2, phdto.getMember_no());
		ps.setInt(3, phdto.getPoint_no());
		ps.setString(4, phdto.getPoint_his_date());
		
		ps.execute();

		con.close();
	}

	// 삭제
	public void delete(int point_his_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE point_history WHERE point_his_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, point_his_no);
		ps.execute();

		con.close();
	}
	//단일조회
			public PointHistoryDto get(int point_his_no) throws Exception {
				Connection con = getConnection();
				
				String sql = "SELECT * FROM point_history WHERE point_his_no = ?";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1,point_his_no);
				ResultSet rs = ps.executeQuery();
				

				PointHistoryDto phdto = rs.next() ? new PointHistoryDto(rs) : null;//3항 연산자
				
				con.close();
				
				return phdto;
}
			//개수 조회 메소드
			public int getCount() throws Exception{
				Connection con = getConnection();
				String sql="select count(*) from point_history";
				PreparedStatement ps=con.prepareStatement(sql);
				ResultSet rs= ps.executeQuery();
				rs.next();
				int count =rs.getInt(1); //또는 rs.getInt ("count(*)");
				con.close();
				
				return count;
			}
			
			public int getCount(String type,String keyword,int member_no, String auth) throws Exception{
				Connection con = getConnection();
				String sql = "SELECT count (*)  FROM point_history ph  INNER JOIN MEMBER m ON ph.member_no = m.member_no "
						+ "WHERE instr(#1, ?) > 0 and (ph.member_no= ? or '관리자'=?) "
						+ "order by point_his_no desc";
						
				sql = sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, keyword);
				ps.setInt(2, member_no);
				ps.setString(3, auth);
				
				
				ResultSet rs= ps.executeQuery();
				rs.next();
				int count = rs.getInt(1); //또는 rs.getInt("count(*));
				
				con.close();
				return count;
				
			}
			public int getCount(int member_no, String auth) throws Exception{
				Connection con = getConnection();
				String sql = "SELECT count (*)  FROM point_history ph  INNER JOIN MEMBER m ON ph.member_no = m.member_no "
						+ "WHERE (ph.member_no= ? or '관리자'=?) "
						+ "order by point_his_no desc";
						
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, member_no);
				ps.setString(2, auth);
				
				
				ResultSet rs= ps.executeQuery();
				rs.next();
				int count = rs.getInt(1); //또는 rs.getInt("count(*));
				
				con.close();
				return count;
			}
			
			
			
			//회원 포인트
			public int getPoint(int member_no) throws Exception{
				Connection con = getConnection();
				
				String sql = "SELECT SUM(point_score) AS point_score FROM point p INNER JOIN point_history ph ON p.point_no=ph.point_no WHERE member_no=?";
				PreparedStatement ps = con.prepareStatement(sql);
				
				ps.setInt(1, member_no);
				
				ResultSet rs = ps.executeQuery();
				int result=0;
				while(rs.next()) {
					result = rs.getInt("point_score");
				}
				con.close();
				return result;
			}
			
			//목록 메소드
			public List<Map<String,Object>> getList(int start , int finish) throws Exception{
				Connection con = getConnection();
				String sql = "SELECT * FROM "
						+ "(SELECT ROWNUM rn, T.* FROM "
						+ "(SELECT * FROM point "
						+ "ORDER BY point_no asc) T ) WHERE rn BETWEEN ? and ?";

				PreparedStatement ps = con.prepareStatement(sql);
				
				ps.setInt(1, start);
				ps.setInt(2, finish);
				
				ResultSet rs = ps.executeQuery();
				List<Map<String,Object>> list = new ArrayList<>();
				while(rs.next()) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("point_type",rs.getString("point_type"));
					temp.put("point_score",rs.getInt("point_score"));
					temp.put("point_no",rs.getInt("point_no"));
					list.add(temp);
				}
				con.close();
				return list;
			}
			
			public List<Map<String,Object>> getListForNormal(int member_no, int start , int finish) throws Exception{
				Connection con = getConnection();
				String sql = "SELECT * FROM "
						+ "(SELECT ROWNUM rn, T.* FROM "
						+ "(SELECT p.point_type, ph.point_his_no, ph.point_his_date, p.point_score FROM point_history ph LEFT OUTER JOIN point p on p.point_no = ph.point_no  WHERE MEMBER_NO=?"
						+ " ORDER BY p.point_no asc) T ) WHERE rn BETWEEN ? and ?";

				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, member_no);
				ps.setInt(2, start);
				ps.setInt(3, finish);
				
				ResultSet rs = ps.executeQuery();
				List<Map<String,Object>> list = new ArrayList<>();
				while(rs.next()) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("point_type",rs.getString("point_type"));
					temp.put("point_his_date",rs.getString("point_his_date"));
					temp.put("point_score",rs.getInt("point_score"));
					temp.put("point_his_no",rs.getInt("point_his_no"));
					
					list.add(temp);
				}
				con.close();
				return list;
			}
			
			public List<Map<String,Object>> getListAll(int start , int finish) throws Exception{
				Connection con = getConnection();
				String sql = "SELECT * FROM "
						+ "(SELECT ROWNUM rn, T.* FROM "
						+ "(SELECT p.point_type, ph.point_his_no, ph.point_his_date, p.point_score FROM point_history ph LEFT OUTER JOIN point p on p.point_no = ph.point_no "
						+ " ORDER BY p.point_no asc) T ) WHERE rn BETWEEN ? and ?";

				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, finish);
				
				ResultSet rs = ps.executeQuery();
				List<Map<String,Object>> list = new ArrayList<>();
				while(rs.next()) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("point_type",rs.getString("point_type"));
					temp.put("point_his_date",rs.getString("point_his_date"));
					temp.put("point_score",rs.getInt("point_score"));
					temp.put("point_his_no",rs.getInt("point_his_no"));
					
					list.add(temp);
				}
				con.close();
				return list;
			}
			
			public List<Map<String,Object>>search(String type, String keyword,String auth, int member_no, int start, int finish) throws Exception{
				Connection con = getConnection();
				
				String sql = "SELECT * FROM "
						+ "(SELECT ROWNUM rn, T.* FROM "
						+ "(SELECT * FROM point WHERE "
						+ "(instr(#1, ?) > 0) )T) WHERE rn BETWEEN ? and ?";
						
				sql = sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);			
				ps.setString(1, keyword);
			
				ps.setInt(2, start);
				ps.setInt(3, finish);
				
				ResultSet rs = ps.executeQuery();
				
				List<Map<String,Object>> list = new ArrayList<>();
				while(rs.next()) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("point_type",rs.getString("point_type"));
					temp.put("point_score",rs.getInt("point_score"));
					temp.put("point_no",rs.getInt("point_no"));
					
					list.add(temp);
				}
				con.close();
				return list;
			}
			
}