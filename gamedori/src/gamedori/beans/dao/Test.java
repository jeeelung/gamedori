package gamedori.beans.dao;

import gamedori.beans.dto.MemberDto;

public class Test {
	public static void main(String[] args) throws Exception {
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.get("hone");
		System.out.println(dto);
		
		MemberDto user = new MemberDto();
		user.setMember_name("홍길동");
		user.setMember_phone("01010101010");
		String id = dao.findId(user);
//		String id = dao.findId(dto);
		System.out.println(id);
	}
}
