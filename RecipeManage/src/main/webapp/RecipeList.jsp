<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Recipe"%>
<%@ page import="model.RecipeDao"%>
<%@ page import="java.util.ArrayList"%>

<%
String keyword = request.getParameter("keyword");
String favoriteOnly = request.getParameter("favoriteOnly");

RecipeDao dao = new RecipeDao();
ArrayList<Recipe> recipeList;

if ("1".equals(favoriteOnly)) {
	recipeList = dao.selectFavoriteRecipes();
} else if (keyword != null && keyword.length() > 0) {
	recipeList = dao.searchRecipes(keyword);
} else {
	recipeList = dao.selectAllRecipes();
}
%>

<%!public String addStepNumbers(String steps) {
		if (steps == null || steps.length() == 0) {
			return "";
		}

		String[] lines = steps.split("\\r?\\n");
		String result = "";

		for (int i = 0; i < lines.length; i++) {
			result += (i + 1) + ". " + lines[i] + "<br>";
		}

		return result;
	}%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>料理一覧</title>
<style>
body {
	background-color: #f7f3ea;
	font-family: sans-serif;
	margin: 30px;
}

.recipe-card {
	background-color: white;
	border-radius: 12px;
	padding: 20px;
	margin-bottom: 24px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	max-width: 600px;
}

.recipe-card img {
    width: 100%;
    max-width: 360px;
    border-radius: 10px;
    display: block;
    margin: 20px auto;
}

button {
	padding: 8px 14px;
	margin: 4px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
}

a {
	color: #d2691e;
}


</style>
</head>
<body>

	<form action="RecipeList.jsp" method="get">
		<input type="text" name="keyword"
			value="<%=keyword == null ? "" : keyword%>">

		<button type="submit">検索</button>

		<br> <br> <label> <input type="checkbox"
			name="favoriteOnly" value="1"
			<%="1".equals(favoriteOnly) ? "checked" : ""%>> お気に入りだけ表示
		</label>
	</form>

	<hr>

	<%
	if (recipeList != null && recipeList.size() > 0) {
		for (int i = 0; i < recipeList.size(); i++) {
			Recipe recipe = recipeList.get(i);
	%>

	<div class="recipe-card">
		<h2>
			<%=recipe.getRecipeName()%>

			<%if (recipe.getFavorite() == 1) {%>
			⭐
			<%
			}
			%>

		</h2>

		<%
		if (recipe.getThumbnailUrl() != null && recipe.getThumbnailUrl().length() > 0) {
		%>
		<img src="<%=recipe.getThumbnailUrl()%>" width="250">
		<%
}
%>

		<p>
			<a href="<%=recipe.getUrl()%>" target="_blank"> YouTubeで見る </a>
		</p>

		<p>
			メモ：
			<%=recipe.getMemo() == null ? "" : recipe.getMemo()%>
		</p>

		<p>
			材料：
			<%=recipe.getMaterials() == null
		? ""
		: "・" + recipe.getMaterials()
				.replace("\n", "<br>・")%>
		</p>


		<p>
			作り方：<br>
			<%=addStepNumbers(recipe.getSteps())%>
		</p>



		<form action="RecipeEditServlet" method="post">
			<input type="hidden" name="id" value="<%=recipe.getId()%>">
			<button type="submit">編集</button>
		</form>
		
		<form action="RecipeDeleteServlet" method="post">
			<input type="hidden" name="id" value="<%=recipe.getId()%>">
			<button type="submit">削除</button>
		</form>

		<form action="FavoriteServlet" method="post">
			<input type="hidden" name="id" value="<%=recipe.getId()%>">

			<%
			if (recipe.getFavorite() == 0) {
			%>
			<input type="hidden" name="favorite" value="1">
			<button type="submit">☆ お気に入り</button>
			<%
} else {
%>
			<input type="hidden" name="favorite" value="0">
			<button type="submit">★ お気に入り解除</button>
			<%
}
%>
		</form>

		
	</div>

	<hr>

	<%
	}
	} else {
	%>
	<p>まだ登録された料理はありません。</p>
	<%
}
%>

	<a href="RecipeAdd.jsp">料理を追加する</a>
	<a href="index.jsp">トップへ戻る</a>

</body>
</html>