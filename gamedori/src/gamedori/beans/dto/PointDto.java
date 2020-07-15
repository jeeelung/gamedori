	package gamedori.beans.dto;

import java.sql.ResultSet;

public class PointDto {
	private int point_no;
	private String point_type;
	private int point_score;
	private String point_his_date;
	
	
	public PointDto() {
		super();
	}
	
	
	public String getPoint_his_date() {
		return point_his_date;
	}


	public void setPoint_his_date(String point_his_date) {
		this.point_his_date = point_his_date;
	}


	public PointDto(ResultSet rs)throws Exception {
		this.setPoint_no(rs.getInt("point_no"));
		this.setPoint_type(rs.getString("point_type"));
		this.setPoint_score(rs.getInt("point_score"));
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


	public int getPoint_score() {
		return point_score;
	}

	public void setPoint_score(int point_score) {
		this.point_score = point_score;
	}
	
}
