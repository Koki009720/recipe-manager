<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Recipe"%>
<%@ page import="model.RecipeDao"%>
<%@ page import="java.util.ArrayList"%>

<%
String keyword = request.getParameter("keyword");

RecipeDao dao = new RecipeDao();
ArrayList<Recipe> recipeList;

if (keyword != null && keyword.length() > 0) {
    recipeList = dao.searchRecipes(keyword);
} else {
    recipeList = dao.selectAllRecipes();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>料理一覧</title>
</head>
<body>
<form action="RecipeList.jsp" method="get">
    <input type="text" name="keyword" value="<%= keyword == null ? "" : keyword %>">
    <button type="submit">検索</button>
</form>
	<%
	if (recipeList != null && recipeList.size() > 0) {
		for (int i = 0; i < recipeList.size(); i++) {
			Recipe recipe = recipeList.get(i);
	%>
	<h2><%=recipe.getRecipeName()%></h2>
	
	<% if (recipe.getThumbnailUrl() != null && recipe.getThumbnailUrl().length() > 0) { %>
    <img src="<%= recipe.getThumbnailUrl() %>" width="250">
<% } %>

	<p>
		URL： <a href="<%=recipe.getUrl()%>" target="_blank"> <%=recipe.getUrl()%>
		</a>
	</p>

	<p>
		メモ：
		<%=recipe.getMemo() == null ? "" : recipe.getMemo()%>
	</p>

	<p>
		材料：
		<%=recipe.getMaterials() == null ? "" : recipe.getMaterials()%>
	</p>

	<p>
		作り方：
		<%=recipe.getSteps() == null ? "" : recipe.getSteps()%>
	</p>
	
	<form action="RecipeEditServlet" method="post">
		<input type="hidden" name="id" value="<%=recipe.getId()%>">
		<button type="submit">編集</button>
	</form>
	
	<form action="FavoriteServlet" method="post">

    <input type="hidden"
           name="id"
           value="<%= recipe.getId() %>">

<%
if(recipe.getFavorite() == 0){
%>

    <input type="hidden"
           name="favorite"
           value="1">

    <button type="submit">
        ☆ お気に入り
    </button>

<%
}else{
%>

    <input type="hidden"
           name="favorite"
           value="0">

    <button type="submit">
        ★ お気に入り解除
    </button>

<%
}
%>

</form>


	<form action="RecipeDeleteServlet" method="post">

		<input type="hidden" name="id" value="<%=recipe.getId()%>">

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
	<a href="index.jsp">トップへ戻る</a>
</body>
</html>