package gamedori.servlet.FAQ;

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

import gamedori.beans.dao.FAQDao;
import gamedori.beans.dao.FAQFileDao;
import gamedori.beans.dao.FilesDao;
import gamedori.beans.dto.FAQDto;
import gamedori.beans.dto.FAQFileDto;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.MemberDto;

@WebServlet(urlPatterns = "/faq/write.do")
public class FAQWriteWithFileServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			목표 : multipart/form-data 방식으로 전송되는 게시글 + 파일을 해석 및 저장
//			1. 해석을 위한 도구를 생성할 옵션을 설정
			String charset = "UTF-8";//해석할 인코딩 방식
			int limit = 10 * 1024  * 1024;//최대 허용 용량
			File baseDir = new File("D:/upload/kh33/faq");
			baseDir.mkdirs();
			
//			2. 도구 생성을 위한 Factory 객체를 생성
			DiskFileItemFactory factory = new DiskFileItemFactory();//공장
			factory.setDefaultCharset(charset);//생성 옵션으로 charset 지정
			factory.setSizeThreshold(limit);//maximum 용량 설정
			factory.setRepository(baseDir);//기본 저장폴더 설정
			
//			3. 실제 사용할 도구 생성
			ServletFileUpload utility = new ServletFileUpload(factory);
			
//			4. 전송된 데이터들을 해석하도록 지시
			Map<String, List<FileItem>> map = utility.parseParameterMap(req);
			
//			5. 해석한 데이터에서 필요한 정보들을 추출
			FAQDto fdto = new FAQDto();	
			System.out.println(map.get("faq_head"));
			fdto.setFaq_head(map.get("faq_head").get(0).getString());			
			fdto.setFaq_title(map.get("faq_title").get(0).getString());
			fdto.setFaq_content(map.get("faq_content").get(0).getString());
//			6.
//			MemberDto user = (MemberDto) req.getSession().getAttribute("userinfo");
//			fdto.getMember_no(Integer.parseInt(user.getMember_no()));
			MemberDto user =(MemberDto) req.getSession().getAttribute("userinfo");
			//System.out.println(user.getMember_no());
			fdto.setMember_no((user.getMember_no()));

//			7. 작성할 게시글의 번호를 미리 가져온다.
			FAQDao fdao = new FAQDao();
			int faq_no = fdao.getSequence();
			
//			8. 게시글 정보에 7번에서 가져온 번호를 첨부
			fdto.setFaq_no(faq_no);
			
//			9. 게시글 등록
			fdao.write(fdto);
			
//			10. 파일 정보를 불러와서 저장(하드디스크 + 데이터베이스)
//			- 전송되는 이름은 faq_file
//			- (주의) 파일이 없어도 개수가 1개가 나오므로 개수로 처리하는 것은 무리!
//			- 파일이 있는지 없는지는 파일의 크기를 이용해서 확인
			List<FileItem> fileList = map.get("faq_file");
			for(FileItem item : fileList) {
				
				if(item.getSize() > 0) {//파일이 있는 경우
					
					FilesDao filesdao = new FilesDao();
					FilesDto filesdto = new FilesDto();
					//데이터베이스에 저장
					int file_no = filesdao.getSequence();
					filesdto.setFile_no(file_no);
					filesdto.setFile_name(item.getName());
					filesdto.setFile_size(item.getSize());
					filesdto.setFile_type(item.getContentType());
					filesdao.save(filesdto);
					
					FAQFileDto ffdto = new FAQFileDto();
					ffdto.setFaq_no(faq_no);//글번호
					ffdto.setFile_no(file_no);//파일번호
					
					FAQFileDao ffdao = new FAQFileDao();
					ffdao.save(ffdto);
					//하드디스크에 저장
					File target = new File(baseDir, String.valueOf(file_no));
					item.write(target);
				}
			}
			resp.sendRedirect("content.jsp?faq_no="+faq_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}