package gamedori.servlet.event_partici;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oracle.jrockit.jfr.EventInfo;

import gamedori.beans.dao.EventFileDao;
import gamedori.beans.dao.EventboardDao;
import gamedori.beans.dao.FilesDao;
import gamedori.beans.dao.event_participateDao;
import gamedori.beans.dto.EventboardDto;
import gamedori.beans.dto.MemberDto;
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
			
			//두 정보를 dto에 삽입
			
			event_participateDto epdto = new event_participateDto();
			//회원, 이벤트 번호 dto 넣기
			epdto.setEvent_no(event_no); 
			epdto.setMember_no(member_no);
			
			//이벤트 응모하기
			event_participateDao epdao = new event_participateDao();
			epdao.EventInfo(epdto);
			
			// 위의 두 정보를 DTO에 삽입 후 이벤트 응모하기
			//event_participateDto epdto = new event_participateDto();
			
			//epdto.setMember_no(member_no); // 회원 번호 dto 에 넣기
			//epdto.setEvent_no(event_no); // 이벤트 번호 dto 에 넣기
			
			// 본격적으로 이벤트 응모하기 > 이벤트 응모 메소드 호출
			//event_participateDao epdao = new event_participateDao();
			//epdao.EventInfo(epdto);
			
			resp.sendRedirect("Eventresult.jsp?=event_no="+event_no);
			
			
//			String io = req.getParameter("io"); 
//			
//			event_participateDto epdto = new event_participateDto();
//			event_participateDao epdao= new event_participateDao();
//			
//			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
//			mdto.setMember_no(Integer.parseInt("member_no"));
//			 
//			EventboardDto edto= new EventboardDto();
//			epdto.setEvent_no(Integer.parseInt(req.getParameter("event_no")));
//			epdao.EventInfo(epdto);
//			
//			resp.sendRedirect("Eventresult.jsp");
		
					
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
		
	}

}
