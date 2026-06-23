package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.RecipeDao;

@WebServlet("/FavoriteServlet")
public class FavoriteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));
            int favorite =
                    Integer.parseInt(request.getParameter("favorite"));

            RecipeDao dao = new RecipeDao();

            dao.updateFavorite(id, favorite);

            response.sendRedirect(
                    request.getContextPath()
                    + "/RecipeList.jsp");

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}