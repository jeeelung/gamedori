package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class NoticeFilesDto {
	private int notice_no;
	private int file_no;
	

	public NoticeFilesDto() {
		super();
	}
	
	public NoticeFilesDto(ResultSet rs) throws SQLException {
		this.setNotice_no(rs.getInt("notice_no"));
		this.setFile_no(rs.getInt("file_no"));
	}
	
	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	
}
