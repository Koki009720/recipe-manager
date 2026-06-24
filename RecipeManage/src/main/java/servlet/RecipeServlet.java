package servlet;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.RecipeDao;

@WebServlet("/RecipeServlet")
@MultipartConfig
public class RecipeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		
		//入力されたデータを取得
		String recipeName = request.getParameter("recipe_name");
		String url = request.getParameter("url");
		String memo = request.getParameter("memo");
		String materials = request.getParameter("materials");
		String steps = request.getParameter("steps");
		String tag = request.getParameter("tag");
		if (tag != null) {
			tag = tag.replace("、", ",");
		}

		String oldThumbnailUrl = request.getParameter("old_thumbnail_url");

		String thumbnailUrl = oldThumbnailUrl;

		if (thumbnailUrl == null || thumbnailUrl.isEmpty()) {
		    thumbnailUrl = createThumbnailUrl(url);
		}

		Part imagePart = request.getPart("image");

		if (imagePart != null && imagePart.getSize() > 0) {
			String uploadPath = request.getServletContext().getRealPath("/upload");

			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			String submittedFileName = imagePart.getSubmittedFileName();
			String extension = "";

			if (submittedFileName != null && submittedFileName.lastIndexOf(".") != -1) {
				extension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
			}

			String saveFileName = UUID.randomUUID().toString() + extension;
			String savePath = uploadPath + File.separator + saveFileName;

			imagePart.write(savePath);

			thumbnailUrl = request.getContextPath() + "/upload/" + saveFileName;
		}

		if (recipeName == null || recipeName.isEmpty()) {
			request.setAttribute("errorMessage", "料理名を入力してください。");
			request.getRequestDispatcher("/RecipeAdd.jsp")
					.forward(request, response);
			return;
		}

		try {
			RecipeDao dao = new RecipeDao();
			String idText = request.getParameter("id");

			if (idText != null && !idText.isEmpty()) {
				int id = Integer.parseInt(idText);
				dao.updateRecipe(id, recipeName, url, memo, materials, steps, thumbnailUrl, tag);
			} else {
				dao.insertRecipe(recipeName, url, memo, materials, steps, thumbnailUrl, tag);
			}

			response.sendRedirect(request.getContextPath() + "/RecipeList.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "登録に失敗しました。");
			request.getRequestDispatcher("/RecipeAdd.jsp")
					.forward(request, response);
			return;
		}
	}
	private String createThumbnailUrl(String url) {
	    if (url == null || url.length() == 0) {
	        return "";
	    }

	    String videoId = "";

	    if (url.contains("watch?v=")) {
	        videoId = url.substring(url.indexOf("watch?v=") + 8);

	        if (videoId.contains("&")) {
	            videoId = videoId.substring(0, videoId.indexOf("&"));
	        }
	    } else if (url.contains("youtu.be/")) {
	        videoId = url.substring(url.indexOf("youtu.be/") + 9);

	        if (videoId.contains("?")) {
	            videoId = videoId.substring(0, videoId.indexOf("?"));
	        }
	    }
	    else if (url.contains("/shorts/")) {

	        videoId = url.substring(url.indexOf("/shorts/") + 8);

	        if (videoId.contains("?")) {
	            videoId = videoId.substring(0, videoId.indexOf("?"));
	        }

	        if (videoId.contains("/")) {
	            videoId = videoId.substring(0, videoId.indexOf("/"));
	        }
	    }

	    if (videoId.length() > 0) {
	        return "https://img.youtube.com/vi/" + videoId + "/hqdefault.jpg";
	    }

	    return "";
	}
}