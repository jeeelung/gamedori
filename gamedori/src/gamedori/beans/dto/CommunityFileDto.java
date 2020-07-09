package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CommunityFileDto {

	private int commu_no;
	private int file_no;
	
	public CommunityFileDto() {
		super();
	}
	
	public CommunityFileDto(ResultSet rs) throws SQLException {
		this.setCommu_no(rs.getInt("commu_no"));
		this.setFile_no(rs.getInt("file_no"));
	}

	public int getCommu_no() {
		return commu_no;
	}

	public void setCommu_no(int commu_no) {
		this.commu_no = commu_no;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	
}
