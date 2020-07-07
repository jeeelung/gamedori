package gamedori.servlet.eventboard;


	import java.io.IOException;

	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.EventboardDao;
import gamedori.beans.dto.EventDto;
import gamedori.beans.dto.MemberDto;


	@WebServlet(urlPatterns = "/eventboard/write.do")
	public class EventBoardWriteServlet extends HttpServlet{
		@Override
		protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
//				목표 : 게시글 등록 후 상세 페이지로 이동
//				준비 : 말머리, 제목, 내용, 작성자
				
				MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
				String member_id = mdto.getMember_id();//작성자 추출
				
				EventDto edto = new EventDto();
				
				edto.setEvent_title(req.getParameter("event_title"));
				edto.setEvent_content(req.getParameter("event_content"));
				edto.setMember_id(member_id);
			
				// 번호를 알아야 그 번호에 맞춰서 수정 가능
				EventboardDao edao = new EventboardDao();
				int event_no = edao.getSequence();//번호 먼저 추출
				edto.setEvent_no(event_no);
				//번호를 설정한 뒤
				edao.write(edto);//등록
				
				resp.sendRedirect("content.jsp?board_no="+event_no);
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);//--> 미리 등록된 에러 페이지 500번으로 연동
			}
		}
	}




