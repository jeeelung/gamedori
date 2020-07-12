package gamedori.beans.dto;

import java.sql.ResultSet;

public class PointDto {
	private int point_no;
	private int member_no;
	private String point_type;
	private int point_score;
	private String point_date;
	private String member_nick;
	
	
	public PointDto() {
		super();
	}
	
	public PointDto(ResultSet rs)throws Exception {
		this.setPoint_no(rs.getInt("point_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setPoint_type(rs.getString("point_type"));
		this.setPoint_score(rs.getInt("point_score"));
		this.setPoint_date(rs.getString("point_date"));
		this.setMember_nick(rs.getString("member_nick"));
	}
	
	
	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}

	public int getPoint_no() {
		return point_no;
	}
	public String getPoint_type() {
		return point_type;
	}

	public void setPoint_no(int point_no) {
		this.point_no = point_no;
	}

	public void setPoint_type(String point_type) {
		this.point_type = point_type;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getPoint_score() {
		return point_score;
	}

	public void setPoint_score(int point_score) {
		this.point_score = point_score;
	}

	public String getPoint_date() {
		return point_date;
	}

	public void setPoint_date(String point_date) {
		this.point_date = point_date;
	}
	
	
	
}
