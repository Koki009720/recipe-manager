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

@WebServlet("/RecipeEditServlet")
public class RecipeEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String indexText = request.getParameter("index");

		HttpSession session = request.getSession();

		ArrayList<Recipe> recipeList =
				(ArrayList<Recipe>) session.getAttribute("recipeList");

		int index = Integer.parseInt(indexText);

		Recipe recipe = recipeList.get(index);

		request.setAttribute("recipe", recipe);
		
		request.setAttribute("editIndex", indexText);


		request.getRequestDispatcher("/RecipeAdd.jsp")
				.forward(request, response);

	}
}