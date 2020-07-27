package gamedori.servlet.eventboard;

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



@WebServlet(urlPatterns = "/eventboard/delete.do")
public class EventDeleteServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			//입력 : board_no
			EventFileDao efdao = new EventFileDao();
			
			int event_no=Integer.parseInt(req.getParameter("event_no"));
			List<Integer> list = efdao.getfileNo(event_no);
			System.out.println(list.size());
			//처리 : 삭제
			
			EventboardDao edao = new EventboardDao();
			edao.delete(event_no); // 삭제
			
			
			//출력 : list.jsp redirect
			
			FilesDao fdao = new FilesDao();
			int file_no;
			for(int i=0; i<list.size(); i++) {
				
				file_no = list.get(i);
				fdao.delete(file_no); // 3		
				
				File target = new File("D:/upload/kh33/eventupload/board", String.valueOf(file_no));
				target.delete(); // 4
			}
			
			// 4
			efdao.delete(event_no);
			resp.sendRedirect("event_list.jsp");
			
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
		
	}

}
