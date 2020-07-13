package gamedori.servlet.event_partici;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
			String go = req.getParameter("io"); 
			
			event_participateDto epdto = new event_participateDto();
			event_participateDao epdao= new event_participateDao();
			
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
			mdto.setMember_no(Integer.parseInt("member_no"));
			 
			EventboardDto edto= new EventboardDto();
			edto.setEvent_no(Integer.parseInt("event_no"));
			
			epdao.joinEvent(epdto);
			
			resp.sendRedirect("Eventresult.jsp");
		
					
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
		
	}

}
