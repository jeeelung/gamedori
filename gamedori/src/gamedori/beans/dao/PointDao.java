package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.GenreDto;
import gamedori.beans.dto.PointDto;
import gamedori.beans.dto.QnaDto;

public class PointDao {
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
	
	// 등록
		public void pointInsert(PointDto pdto ) throws Exception {
			Connection con = getConnection();
			String sql = "INSERT INTO Point VALUES(point_seq.nextval , ? , ?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, pdto.getPoint_type());
			ps.setInt(2, pdto.getPoint_score());			
			ps.execute();

			con.close();
		}

		// 수정
		public void edit(PointDto pdto) throws Exception {
			Connection con = getConnection();

			String sql = "UPDATE point SET point_type=? , point_score=? where point_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, pdto.getPoint_type());
			ps.setInt(2, pdto.getPoint_score());
			ps.setInt(3, pdto.getPoint_no());
			ps.execute();

			con.close();
		}

		// 삭제
		public void delete(int point_no,String point_type) throws Exception {
			Connection con = getConnection();

			String sql = "DELETE point WHERE  point_no= ? and point_type=? ";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, point_no);
			ps.setString(2, point_type);
			ps.execute();

			con.close();
		}
		//단일조회
				public PointDto get(int point_no) throws Exception {
					Connection con = getConnection();
					
					String sql = "SELECT * FROM point WHERE point_no = ?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1,point_no);
					ResultSet rs = ps.executeQuery();
					

					PointDto pdto = rs.next() ? new PointDto(rs) : null;//3항 연산자
					
					con.close();
					
					return pdto;
	}
				//개수 조회 메소드
				public int getCount() throws Exception{
					Connection con = getConnection();
					String sql="select count(*) from point";
					PreparedStatement ps=con.prepareStatement(sql);
					ResultSet rs= ps.executeQuery();
					rs.next();
					int count =rs.getInt(1); //또는 rs.getInt ("count(*)");
					con.close();
					
					return count;
				}
				
				public int getCount(String type,String keyword, String auth) throws Exception{
					Connection con = getConnection();
					String sql ="SELECT count (*)  FROM point WHERE instr('#1',?) > 0 and '관리자'= ? order by point_no DESC";
							
					sql = sql.replace("#1", type);
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, keyword);
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
					int result = 0;
					while(rs.next()) {
						result = rs.getInt("point_score");
					}
					
					con.close();
					return result;
				}
				
				//목록 메소드
				public List<PointDto> getList(String auth, int start , int finish) throws Exception{
					Connection con = getConnection();
					String sql = "SELECT * FROM(SELECT ROWNUM rn, T.* FROM(SELECT * FROM point WHERE ('관리자' = ? )ORDER BY point_no asc)T ) WHERE rn BETWEEN ? and ?";
					PreparedStatement ps = con.prepareStatement(sql);
					
					ps.setString(1, auth);
					ps.setInt(2, start);
					ps.setInt(3, finish);
					
					ResultSet rs = ps.executeQuery();
					List<PointDto> list = new ArrayList<>();
					while(rs.next()) {
						PointDto pdto = new PointDto(rs);
						
						list.add(pdto);
					}
					
					con.close();
					return list;
				}
				
				public List<PointDto> search(String type,  String keyword,String auth,int start, int finish) throws Exception{
					Connection con = getConnection();
					
					String sql = "SELECT * FROM(SELECT ROWNUM rn, T.* FROM(SELECT * FROM point WHERE (instr(#1, ?) > 0 and ('관리자' = ? )) )T ) WHERE rn BETWEEN ? and ?";
							
					sql = sql.replace("#1", type);
					PreparedStatement ps = con.prepareStatement(sql);			
					ps.setString(1, keyword);
					ps.setString(2,auth);
					ps.setInt(3, start);
					ps.setInt(4, finish);
					
					ResultSet rs = ps.executeQuery();
					
					List<PointDto> list = new ArrayList<>();
					while(rs.next()) {
						PointDto pdto = new PointDto(rs);
						list.add(pdto);
					}
					con.close();
					return list;
				}
				public int getPoint_no() throws Exception{
					Connection con = getConnection();

					String sql = "SELECT CAST(point_seq.nextval as NUMBER) as point_no  FROM DUAL";
					PreparedStatement ps = con.prepareStatement(sql);
					int result = 0;
					
					ResultSet rs =ps.executeQuery();
					if(rs.next()) {
						result =rs.getInt("point_no"); 
					}
					con.close();
					
					return result;
					
				}
				
				public int getSequence() throws Exception {
					Connection con = getConnection();
					String sql = "SELECT point_seq.nextval FROM dual";
					PreparedStatement ps = con.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					rs.next();
					int seq = rs.getInt(1);
					
					con.close();
					
					return seq;
				}
				
				public void add_point(int member_no , int point)throws Exception{
		               Connection con = getConnection();
		               String sql = "update member set MEMBER_POINT = MEMBER_POINT + #1 where member_no = ?";
		               sql = sql.replace("#1", point+"");
		               PreparedStatement ps = con.prepareStatement(sql);
		        
		               ps.setInt(1, member_no);
		               ps.execute();
		               
		               con.close();
		            }
				public PointDto getByType(String point_type) throws Exception {
					Connection con = getConnection();
					
					String sql = "SELECT * FROM point WHERE point_type = ?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1,point_type);
					ResultSet rs = ps.executeQuery();
					

					PointDto pdto = rs.next() ? new PointDto(rs) : null;//3항 연산자
					
					con.close();
					
					return pdto;
				}
}