package www.api.com.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import www.com.util.FileUploadUtil;
import www.com.util.FileDownloadUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URLEncoder;

@Controller
@RequestMapping("/api/common/file")
public class FileController {

    /** Toast UI 업로드: 문자열(URL) 직접 쓰기 → 컨버터 미사용 */
	@PostMapping("/upload")
	public void upload(@RequestParam("file") MultipartFile file,
	                   HttpServletRequest req,
	                   HttpServletResponse resp) {
	    resp.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/plain;charset=UTF-8");
	    try {
	        // 1) 저장하고 "상대 파일경로"만 받는다. (예: editor/2025/09/04/uuid.png)
	        String relPath = FileUploadUtil.saveImageReturnRelPath(file);
 
	        // 2) 절대 URL로 조립 (컨텍스트 경로 포함)
	        String ctx = req.getContextPath();                 // 예: "" 또는 "/myapp"
	        String url = ctx + "/api/common/file/image?path=" +
	                     URLEncoder.encode(relPath, "UTF-8");  // 최종: "/myapp/api/common/file/image?path=..."

	        // (원하면 완전 절대 URL) 
	        // String base = req.getScheme() + "://" + req.getServerName() +
	        //               (req.getServerPort()==80||req.getServerPort()==443? "" : ":"+req.getServerPort()) + ctx;
	        // String url = base + "/api/common/file/image?path=" + URLEncoder.encode(relPath, "UTF-8");

	        resp.getWriter().write(url);
	    } catch (Exception e) {
	        try {
	            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            resp.getWriter().write("error");
	        } catch (Exception ignore) {}
	    }
	}

    /** 이미지 인라인 표시 (에디터 <img src=...>) */
    @GetMapping("/image")
    public void image(@RequestParam("path") String path, HttpServletResponse resp) {
        try {
            File f = FileUploadUtil.resolveFile(path);
            String name = path.substring(path.lastIndexOf('/') + 1);
            FileDownloadUtil.write(resp, f, name, true);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /** 일반 다운로드 */
    @GetMapping("/download")
    public void download(@RequestParam("path") String path, HttpServletResponse resp) {
        try {
            File f = FileUploadUtil.resolveFile(path);
            String name = path.substring(path.lastIndexOf('/') + 1);
            FileDownloadUtil.write(resp, f, name, false);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}