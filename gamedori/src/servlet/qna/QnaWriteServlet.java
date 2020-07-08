package servlet.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.QnaDao;
import gamedori.beans.dto.QnaDto;
import gamedori.beans.dto.MemberDto;

//@WebServlet(urlPatterns = "/qna/write.do")

public class QnaWriteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			목표 : 게시글 등록 후 상세 페이지로 이동
//			준비 : 말머리, 제목, 내용, 작성자
			
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
			String member_id = mdto.getMember_id();//작성자 추출
			
			QnaDto qdto = new QnaDto();
			qdto.setMember_no(Integer.parseInt(req.getParameter("member_no")));
			qdto.setQna_head(req.getParameter("qna_head"));
			qdto.setQna_title(req.getParameter("qna_title"));
			qdto.setQna_content(req.getParameter("qna_content"));
			//게시글 번호(board_no)를 있을 때만 받는다 --> super_no에 저장!
			if(req.getParameter("qna_no") != null) {
				qdto.setQna_super_no(Integer.parseInt(req.getParameter("qna_no")));
			}
			
			QnaDao qdao = new QnaDao();
			int qna_no = qdao.getSequence();//들어갈 번호 먼저 추출
			qdto.setQna_no(qna_no);//들어갈 번호를 설정한 뒤
			qdao.write(qdto);//등록
			
			resp.sendRedirect("content.jsp?qna_no="+qna_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);//--> 미리 등록된 에러 페이지 500번으로 연동
		}
	}
}