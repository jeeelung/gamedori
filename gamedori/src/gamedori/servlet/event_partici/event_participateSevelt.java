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




@WebServlet(urlPatterns = "/eventboard/partici.do")
public class event_participateSevelt extends HttpServlet {

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
		
			
		}
		
		catch (Exception e ) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
		
	}

}
