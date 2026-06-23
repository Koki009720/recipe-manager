package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.RecipeDao;

@WebServlet("/RecipeServlet")
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
		String thumbnailUrl = createThumbnailUrl(url);

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
				dao.updateRecipe(id, recipeName, url, memo, materials, steps, thumbnailUrl);
			} else {
				dao.insertRecipe(recipeName, url, memo, materials, steps, thumbnailUrl);
			}

			response.sendRedirect(request.getContextPath() + "/RecipeList.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "登録に失敗しました。");
			request.getRequestDispatcher("/RecipeAdd.jsp")
					.forward(request, response);
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