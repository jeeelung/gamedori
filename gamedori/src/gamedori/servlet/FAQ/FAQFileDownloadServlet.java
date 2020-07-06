package gamedori.servlet.FAQ;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import home.beans.dao.BoardFileDao;
import home.beans.dto.BoardFileDto;

@WebServlet(urlPatterns = "/board/download.do")
public class FAQFileDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			목표 : 사용자가 원하는 파일을 다운로드 할 수 있도록 전송
//			1. 사용자 요청정보에서 board_file_no를 불러온다
			int board_file_no = Integer.parseInt(req.getParameter("board_file_no"));
			
//			2. 데이터베이스에서 board_file_no에 해당하는 파일 정보를 불러온다.
			FAOFileDao bfdao = new FAOFileDao();
			FAQFileDto bfdto = bfdao.get(board_file_no);
			
//			3. 만약 대상 파일이 없으면 사용자에게 오류를 송출
			if(bfdto == null) {
				resp.sendError(404);
				return;//중지
			}
			
//			4. 다운로드를 위해 사용자에게 필요한 정보들을 알려주도록 설정(헤더 설정)
//			- Content-Type : 사용자(브라우저)에게 알려주는 이 데이터의 형식
//			- Content-Disposition : 사용자 화면에 표시되는 다운로드 파일 이름
//			- Content-Length : 데이터의 크기(사용자 화면에 다운로드 진행상황 표시가 가능)
			
//			(주의) 한글 이름이나 띄어쓰기가 처리가 되지 않는 이유
//			- 띄어쓰기가 정상적으로 인식되려면 filename="파일명" 형태로 따옴표로 감싸져 있어야 한다.
//			- 한글 등의 유니코드가 정상적으로 처리되려면 다음 명령이 필요하다.
//			- 변환 명령 : URLEncoder.encode(값, "UTF-8");
//			- 위의 명령은 주소에 포함될 수 없는 형태의 글자들(%, ? 등)을 가능한 형태로 변환해준다.
			
			resp.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
//			resp.setHeader("Content-Disposition", "attachment; filename="+bfdto.getBoard_file_name());
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(bfdto.getBoard_file_name(), "UTF-8")+"\"");
			resp.setHeader("Content-Length", String.valueOf(bfdto.getBoard_file_size()));
			
//			5. 실제 데이터를 불러와서 사용자에게 전송한다.
			File target = new File("D:/upload/board", String.valueOf(bfdto.getBoard_file_no()));
			byte[] data = FileUtils.readFileToByteArray(target);//파일 데이터 로드
			resp.getOutputStream().write(data);//사용자에게 전송
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}









