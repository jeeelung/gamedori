package gamedori.servlet.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.NoticeDao;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.NoticeDto;

@WebServlet(urlPatterns = "/gamedori/write.do")
public class NoticeWriteServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 목표 : 게시글 등록 후 상세 페이지로 이동
			// 준비 : 제목, 내용, 작성자

			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
			int member_no = mdto.getMember_no(); // 작성자 추출

			NoticeDto ndto = new NoticeDto();
			ndto.setNotice_title(req.getParameter("notice_title"));
			ndto.setNotice_content(req.getParameter("notice_content"));
			ndto.setMember_no(Integer.parseInt("member_no"));

			NoticeDao ndao = new NoticeDao();
			int notice_no = ndao.getSequence(); // 번호 먼저 추출
			ndto.setNotice_no(notice_no); // 번호를 설정한 뒤
			ndao.write(ndto); // 등록

			resp.sendRedirect("content.jsp?notice_no=" + notice_no);
     		} 
			catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
