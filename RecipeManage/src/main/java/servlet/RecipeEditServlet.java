package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Recipe;
import model.RecipeDao;

@WebServlet("/RecipeEditServlet")
public class RecipeEditServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idText = request.getParameter("id");

        try {
            int id = Integer.parseInt(idText);

            RecipeDao dao = new RecipeDao();
            Recipe recipe = dao.selectRecipeById(id);

            request.setAttribute("recipe", recipe);

            request.getRequestDispatcher("/RecipeAdd.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/RecipeList.jsp");
        }
    }
}