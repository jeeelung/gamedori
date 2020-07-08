package gamedori.servlet.eventboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.EventboardDao;
import gamedori.beans.dto.EventboardDto;



@WebServlet(urlPatterns = "/eventboard/EventEdit.do")
public class EventEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : board_head, board_title, board_content, board_no -> BoardDto
			EventboardDto edto = new EventboardDto();
			edto.setEvent_no(Integer.parseInt(req.getParameter("event_no")));
		
			edto.setEvent_title(req.getParameter("Event_title"));
			edto.setEvent_content(req.getParameter("Event_content"));
			
//			처리 : 
			EventboardDao edao = new EventboardDao();
			edao.edit(edto);
			
//			출력 : 
			resp.sendRedirect("content.jsp?Event_no="+edto.getEvent_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}

