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

@WebServlet("/RecipeDeleteServlet")
public class RecipeDeleteServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String indexText = request.getParameter("index");

		HttpSession session = request.getSession();

		ArrayList<Recipe> recipeList = (ArrayList<Recipe>) session.getAttribute("recipeList");

		if (recipeList != null && indexText != null) {

			int index = Integer.parseInt(indexText);

			if (index >= 0 && index < recipeList.size()) {

				recipeList.remove(index);

			}

			session.setAttribute("recipeList", recipeList);

		}

		response.sendRedirect("RecipeList.jsp");

	}

}
