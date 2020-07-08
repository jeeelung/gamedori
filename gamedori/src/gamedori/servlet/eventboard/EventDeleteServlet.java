package gamedori.servlet.eventboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.EventboardDao;




@WebServlet(urlPatterns = "/eventboard/delete.do")
public class EventDeleteServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			//입력 : board_no
			int event_no=Integer.parseInt(req.getParameter("event_no"));
			
			//처리 : 삭제
			
			EventboardDao edao = new EventboardDao();
			edao.delete(event_no); // 삭제
			
			
			//출력 : list.jsp redirect
			
			resp.sendRedirect("event_list.jsp");
			
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
		
	}

}
