package gamedori.servlet.qna;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import gamedori.beans.dao.FilesDao;
import gamedori.beans.dao.MemberDao;
import gamedori.beans.dao.QnaDao;
import gamedori.beans.dao.QnaFileDao;
import gamedori.beans.dto.QnaDto;
import gamedori.beans.dto.QnaFileDto;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.MemberDto;
@WebServlet(urlPatterns="/qna/write.do")
public class QnaWriteWithFileServlet extends HttpServlet{
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		
		String charset = "UTF-8"; // 해석할 인코딩 방식
		int limit = 10 * 1024 * 1024; // 최대 허용 용량
		File baseDir = new File("D:/upload/qna");
		baseDir.mkdirs();
		
		
		DiskFileItemFactory factory = new DiskFileItemFactory(limit, baseDir);
		factory.setDefaultCharset(charset);
		
		ServletFileUpload utility = new ServletFileUpload(factory);
		MemberDto user =(MemberDto) req.getSession().getAttribute("userinfo");
		
		Map<String, List<FileItem>> map = utility.parseParameterMap(req);
	
		QnaDto qdto = new QnaDto();
		qdto.setMember_no(Integer.parseInt(map.get("member_no").get(0).getString()));
		qdto.setQna_head(map.get("qna_head").get(0).getString());
		qdto.setQna_title(map.get("qna_title").get(0).getString());
		qdto.setQna_content(map.get("qna_content").get(0).getString());
		qdto.setQna_email(map.get("qna_email").get(0).getString());
		
		if(map.containsKey("qna_super_no")) {
			qdto.setQna_super_no(Integer.parseInt(map.get("qna_super_no").get(0).getString()));
		}
		
		
		QnaDao qdao = new QnaDao();
		int qna_no = qdao.getSequence();
		qdto.setQna_no(qna_no);
		
		qdao.write(qdto);
		
		List<FileItem> fileList = map.get("qna_file");
		
		
		for(FileItem item : fileList) {
			
			if(item.getSize() > 0) { // 파일이 있는 경우
				
				FilesDao fdao = new FilesDao();
				FilesDto fdto = new FilesDto();
				
				int file_no = fdao.getSequence();
				fdto.setFile_no(file_no);
				fdto.setFile_name(item.getName());
				fdto.setFile_size(item.getSize());
				fdto.setFile_type(item.getContentType());
				fdao.save(fdto);
				
				QnaFileDto qfdto = new QnaFileDto();
				qfdto.setQna_no(qna_no);
				qfdto.setFile_no(file_no);
				
				
				QnaFileDao qfdao = new QnaFileDao();
				qfdao.save(qfdto);
				
				File target = new File(baseDir, String.valueOf(file_no));
				item.write(target);
			}
		}
		
		resp.sendRedirect("qna_content.jsp?qna_no="+qna_no);
		
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		resp.sendError(500);
	}
}
}

