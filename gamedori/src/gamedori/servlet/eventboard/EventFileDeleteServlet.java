package gamedori.servlet.eventboard;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.EventFileDao;
import gamedori.beans.dao.FilesDao;

@WebServlet(urlPatterns = "/eventboard/filedelete.do")
public class EventFileDeleteServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	try {
	int event_no = Integer.parseInt(req.getParameter("event_no"));
	int file_no = Integer.parseInt(req.getParameter("file_no"));
	FilesDao fdao = new FilesDao();
	fdao.delete(file_no);
	
	// 2	
	File target = new File("D:/eventupload/board", String.valueOf(file_no));
	target.delete();
	
	// 3
	EventFileDao efdao = new EventFileDao();
	efdao.deletefile(file_no);
	
	resp.sendRedirect("EventEdit.jsp?event_no="+event_no);

} 
	catch (Exception e) {
	e.printStackTrace();
	resp.sendError(500);
}
}

}
