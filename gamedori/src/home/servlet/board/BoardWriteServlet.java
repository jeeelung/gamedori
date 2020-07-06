package home.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import home.beans.dao.BoardDao;
import home.beans.dto.BoardDto;
import home.beans.dto.MemberDto;

//@WebServlet(urlPatterns = "/board/write.do")
public class BoardWriteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			목표 : 게시글 등록 후 상세 페이지로 이동
//			준비 : 말머리, 제목, 내용, 작성자
			
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
			String member_id = mdto.getMember_id();//작성자 추출
			
			BoardDto bdto = new BoardDto();
			bdto.setBoard_head(req.getParameter("board_head"));
			bdto.setBoard_title(req.getParameter("board_title"));
			bdto.setBoard_content(req.getParameter("board_content"));
			bdto.setBoard_writer(member_id);
			//게시글 번호(board_no)를 있을 때만 받는다 --> super_no에 저장!
			if(req.getParameter("board_no") != null) {
				bdto.setSuper_no(Integer.parseInt(req.getParameter("board_no")));
			}
			
			BoardDao bdao = new BoardDao();
			int board_no = bdao.getSequence();//들어갈 번호 먼저 추출
			bdto.setBoard_no(board_no);//들어갈 번호를 설정한 뒤
			bdao.write(bdto);//등록
			
			resp.sendRedirect("content.jsp?board_no="+board_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);//--> 미리 등록된 에러 페이지 500번으로 연동
		}
	}
}









