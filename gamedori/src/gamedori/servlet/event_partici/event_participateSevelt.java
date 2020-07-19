package gamedori.servlet.event_partici;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.PointDao;
import gamedori.beans.dao.PointHistoryDao;
import gamedori.beans.dao.event_participateDao;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.PointDto;
import gamedori.beans.dto.PointHistoryDto;
import gamedori.beans.dto.event_participateDto;


@WebServlet(urlPatterns = "/eventboard/event.do")
public class event_participateSevelt extends HttpServlet {

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
			//세션으로 불러오고
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
			int member_no = mdto.getMember_no();
			//이벤트 파라미터 받고
			int event_no = Integer.parseInt(req.getParameter("event_no"));
			event_participateDao epdao = new event_participateDao();
			event_participateDto epdto = new event_participateDto();
			
			// 회원 참여 여부 확인
			Integer check = epdao.getEventCheck(member_no);
			
			if(check == null) {
				// 회원 번호 없으면
				
				// 회원, 이벤트 번호 dto 넣기
				epdto.setEvent_no(event_no);
				epdto.setMember_no(member_no);

				// 이벤트 응모하기
				epdao.EventInfo(epdto);
				
				
				System.out.println("이벤트 등록 완료");
			
				PointDto pdto = new PointDto();
				PointDao pdao = new PointDao();
				
				pdto = pdao.getByType("이벤트참여");
				
				pdao.add_point(member_no, pdto.getPoint_score());
			
				PointHistoryDto phdto = new PointHistoryDto();
				phdto.setPoint_no(pdto.getPoint_no());
				PointHistoryDao phdao = new PointHistoryDao();
				
				phdao.insert(phdto, member_no);
				
				resp.sendRedirect("Eventresult.jsp");

			} else {
				// 회원 번호 있으면
				
				resp.sendRedirect("Eventresult2.jsp");
				System.out.println("이벤트 등록 실패");
			}
				
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
	}

}
