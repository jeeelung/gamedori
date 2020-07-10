package gamedori.beans.dto;

import java.sql.ResultSet;

public class FilesDto {
	private int file_no;
	private String file_name;
	private long file_size;
	private String file_type;
	
	public FilesDto() {
		super();
	}
	
	public FilesDto(ResultSet rs) throws Exception{
		this.setFile_no(rs.getInt("file_no"));
		this.setFile_name(rs.getString("file_name"));
		this.setFile_size(rs.getLong("file_size"));
		this.setFile_type(rs.getString("file_type"));
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getFile_type() {
		return file_type;
	}

	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	
<<<<<<< HEAD
}
=======
}
>>>>>>> refs/remotes/origin/master
