package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Recipe;

@WebServlet("/RecipeServlet")
public class RecipeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String recipeName = request.getParameter("recipe_name");
		String url = request.getParameter("url");
		String memo = request.getParameter("memo");
		//nullの対処
		if (recipeName == null || recipeName.isEmpty()) {
			request.setAttribute("errorMessage", "料理名を入力してください。");
			request.getRequestDispatcher("/RecipeAdd.jsp")
					.forward(request, response);
			return;
		}
		
		Recipe recipe = new Recipe();
		
		recipe.setRecipeName(recipeName);
		recipe.setUrl(url);
		recipe.setMemo(memo);
		
		HttpSession session = request.getSession();

		ArrayList<Recipe> recipeList =
			(ArrayList<Recipe>) session.getAttribute("recipeList");

		if (recipeList == null) {
			recipeList = new ArrayList<Recipe>();
		}

		recipeList.add(recipe);

		session.setAttribute("recipeList", recipeList);

		request.getRequestDispatcher("/RecipeList.jsp")
				.forward(request, response);
	}
}