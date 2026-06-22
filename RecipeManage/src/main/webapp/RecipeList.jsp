<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Recipe"%>
<%@ page import="java.util.ArrayList"%>

<%
ArrayList<Recipe> recipeList =
	(ArrayList<Recipe>) session.getAttribute("recipeList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>料理一覧</title>
</head>
<body>
	<%
if (recipeList != null && recipeList.size() > 0) {
	for (int i = 0; i < recipeList.size(); i++) {
		Recipe recipe = recipeList.get(i);
%>
	<h2><%= recipe.getRecipeName() %></h2>

	<p>
		URL： <a href="<%= recipe.getUrl() %>" target="_blank"> <%= recipe.getUrl() %>
		</a>
	</p>

	<p>
		メモ：
		<%= recipe.getMemo() %>
	</p>
	<form action="RecipeEditServlet" method="post">

	<input type="hidden" name="index" value="<%= i %>">
	
	<button type="submit">編集</button>

</form>

	<form action="RecipeDeleteServlet" method="post">
	
		<input type="hidden" name="index" value="<%= i %>">
		
		<button type="submit">削除</button>
	</form>

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
	<br>
	<a href="index.jsp">トップへ戻る</a>

</body>
</html>