package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.RecipeDao;

@WebServlet("/RecipeDeleteServlet")
public class RecipeDeleteServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idText =
                request.getParameter("id");

        try {

            int id =
                    Integer.parseInt(idText);

            RecipeDao dao =
                    new RecipeDao();

            dao.deleteRecipe(id);

        } catch (Exception e) {

            e.printStackTrace();

        }

        response.sendRedirect(
                request.getContextPath()
                + "/RecipeList.jsp");

    }
}
