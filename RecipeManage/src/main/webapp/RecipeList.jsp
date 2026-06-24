<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="model.Recipe"%>
<%@ page import="model.RecipeDao"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>

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
	margin: 0;
	padding: 16px;
	color: #333;
}

form {
	margin: 0;
}

.search-form {
	background: white;
	padding: 16px;
	border-radius: 14px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
	margin-bottom: 20px;
}

.search-form input[type="text"] {
	width: 100%;
	box-sizing: border-box;
	padding: 14px;
	font-size: 16px;
	border: 1px solid #ddd;
	border-radius: 10px;
	margin-bottom: 10px;
}

.recipe-card {
	background-color: white;
	border-radius: 16px;
	padding: 18px;
	margin-bottom: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.recipe-card h2 {
	font-size: 22px;
	margin-top: 0;
}

.recipe-card img {
	width: 100%;
	max-width: 100%;
	border-radius: 12px;
	display: block;
	margin: 16px auto;
}

button, .link-button {
	width: 100%;
	padding: 14px;
	margin: 6px 0;
	border-radius: 10px;
	border: none;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
}

button {
	background: #e67e22;
	color: white;
}

a {
	color: #d2691e;
}

.youtube-link {
	display: block;
	text-align: center;
	background: #ff7043;
	color: white;
	text-decoration: none;
	padding: 14px;
	border-radius: 10px;
	font-weight: bold;
	margin: 12px 0;
}

.bottom-links {
	display: flex;
	flex-direction: column;
	gap: 10px;
	margin: 24px 0;
}

.bottom-links a {
	display: block;
	text-align: center;
	background: white;
	padding: 14px;
	border-radius: 10px;
	text-decoration: none;
	font-weight: bold;
}

.recipe-card {
	box-sizing: border-box;
	min-width: 0;
}

.action-buttons {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 8px;
}

.action-buttons form {
	min-width: 0;
}

.action-buttons button {
	width: 100%;
	font-size: 14px;g
	padding: 10px 4px;
	white-space: normal;
}

.recipe-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.tag-label {
	display: inline-block;
	background: #fff3e0;
	color: #d2691e;
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 14px;
	font-weight: bold;
	margin: 4px 0 10px;
	text-decoration: none;
}
.tag-label {
	display: inline-block;
	background: #fff3e0;
	color: #d2691e;
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 14px;
	font-weight: bold;
	margin: 4px 6px 10px 0;
	text-decoration: none;
}
.recipe-card img {
	width: 100%;
	height: 220px;
	object-fit: cover;
	border-radius: 12px;
	display: block;
	margin: 16px auto;
}

@media ( max-width : 900px) {
	.recipe-container {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 600px) {
	.recipe-container {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>

	<form action="RecipeList.jsp" method="get" class="search-form">
		<input type="text" name="keyword"
			value="<%=keyword == null ? "" : keyword%>">

		<button type="submit">検索</button>

		<br> <br> <label> <input type="checkbox"
			name="favoriteOnly" value="1"
			<%="1".equals(favoriteOnly) ? "checked" : ""%>> お気に入りだけ表示
		</label>
	</form>

	<%
	if (recipeList != null && recipeList.size() > 0) {
	%>

	<div class="recipe-container">

		<%
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
			if (recipe.getTag() != null && recipe.getTag().length() > 0) {

				String[] tags = recipe.getTag().split(",");

				for (String oneTag : tags) {

					oneTag = oneTag.trim();

					if (oneTag.length() == 0) {
				continue;
					}
			%>

			<a class="tag-label"
				href="RecipeList.jsp?keyword=<%=URLEncoder.encode(oneTag, "UTF-8")%>">
				#<%=oneTag%>
			</a>

			<%
			}
			}
			%>
			<%
			if (recipe.getTag() != null && recipe.getTag().length() > 0) {
			%>
	
			<%}%>


			<%
			if (recipe.getThumbnailUrl() != null && recipe.getThumbnailUrl().length() > 0) {
			%>
			<img src="<%=recipe.getThumbnailUrl()%>">
			<%}%>

			<p>
				<a href="<%=recipe.getUrl()%>" target="_blank" class="youtube-link">YouTubeで見る</a>
			</p>

			<div class="action-buttons">
				<form action="<%=request.getContextPath()%>/RecipeDetailServlet"
					method="post">
					<input type="hidden" name="id" value="<%=recipe.getId()%>">
					<button type="submit">詳細</button>
				</form>

				<form action="<%=request.getContextPath()%>/RecipeEditServlet"
					method="post">
					<input type="hidden" name="id" value="<%=recipe.getId()%>">
					<button type="submit">編集</button>
				</form>

				<form action="<%=request.getContextPath()%>/RecipeDeleteServlet"
					method="post" onsubmit="return confirm('削除しますか？');">
					<input type="hidden" name="id" value="<%=recipe.getId()%>">
					<button type="submit">削除</button>
				</form>

				<form action="<%=request.getContextPath()%>/FavoriteServlet"
					method="post">
					<input type="hidden" name="id" value="<%=recipe.getId()%>">

					<%
					if (recipe.getFavorite() == 0) {
					%>
					<input type="hidden" name="favorite" value="1">
					<button type="submit">☆ </button>
					<%
					} else {
					%>
					<input type="hidden" name="favorite" value="0">
					<button type="submit">★ </button>
					<%
					}
					%>
				</form>
			</div>
		</div>

		<%
		}
		%>

	</div>

	<%
} else {
%>

	<p>まだ登録された料理はありません。</p>
	<%
}
%>

	<div class="bottom-links">
		<a href="RecipeAdd.jsp">料理を追加する</a> <a href="index.jsp">トップへ戻る</a>
	</div>
</body>
</html>