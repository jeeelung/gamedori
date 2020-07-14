package gamedori.beans.dto;

import java.sql.ResultSet;

public class PointHistoryDto {
	private int point_his_no;
	private int member_no;
	private int point_no;
	private String point_his_date;
	public PointHistoryDto() {
		super();
	}
	public PointHistoryDto(ResultSet rs) throws Exception{
		this.setPoint_his_no(rs.getInt("point_his_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setPoint_no(rs.getInt("point_no"));
		this.setPoint_his_date(rs.getString("point_his_date"));
	}
	
	public int getPoint_his_no() {
		return point_his_no;
	}
	public void setPoint_his_no(int point_his_no) {
		this.point_his_no = point_his_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getPoint_no() {
		return point_no;
	}
	public void setPoint_no(int point_no) {
		this.point_no = point_no;
	}
	public String getPoint_his_date() {
		return point_his_date;
	}
	public void setPoint_his_date(String point_his_date) {
		this.point_his_date = point_his_date;
	}
	
}
