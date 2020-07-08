package gamedori.servlet.eventboard;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(urlPatterns = "/eventfilemanage/upload.do")
public class EventFileUploadServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	File dir= new File("D:/upload");
	DiskFileItemFactory factory= new DiskFileItemFactory();
	factory.setRepository(dir);
	factory.setSizeThreshold(1*1024*1024);
	ServletFileUpload upload= new ServletFileUpload(factory);
	
	
}
}
