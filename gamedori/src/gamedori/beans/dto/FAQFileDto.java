package gamedori.beans.dto;

//faq_file_no number primary key,
//faq_file_name varchar2(256) not null,
//faq_file_size number not null check(faq_file_size>0),
//faq_file_type char(10) not null,
//faq_no references faq(faq_no) on delete cascade
public class FAQFileDto {
	private int faq_no;
	private int file_no;
	
	public int getFaq_no() {
		return faq_no;
	}

	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public FAQFileDto() {
		super();
	}

	
}
