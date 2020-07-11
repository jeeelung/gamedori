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




@WebServlet(urlPatterns = "/eventboard/partici.do")
public class event_participateSevelt extends HttpServlet {

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
			event_participateDto epdto = new event_participateDto();
			
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("no");
			EventboardDto edto= (EventboardDto) req.getSession().getAttribute("event");
			
			edto.setEvent_no(edto.getEvent_no());
			mdto.setMember_no(mdto.getMember_no());
			
			event_participateDao epdao= new event_participateDao();
			int event_partici_no = epdao.getSequence();
			epdto.setEvent_partici_no(event_partici_no);
			
			epdao.joinEvent(epdto);
			
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
		
	}

}
