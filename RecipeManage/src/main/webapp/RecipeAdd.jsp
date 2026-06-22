<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Recipe"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>料理登録</title>
</head>
<body>
<%
Recipe recipe = (Recipe) request.getAttribute("recipe");

String recipeName = "";
String url = "";
String memo = "";
String editIndex = "";

if (recipe != null) {
	recipeName = recipe.getRecipeName();
	url = recipe.getUrl();
	memo = recipe.getMemo();
	editIndex = (String) request.getAttribute("editIndex");
}
%>

	<h1>料理を登録する</h1>

	<%
	String errorMessage = (String) request.getAttribute("errorMessage");
	if (errorMessage != null) {
	%>
	<p style="color: red;"><%=errorMessage%></p>
	<%
}
%>

	<form action="RecipeServlet" method="post">
	<input type="hidden" name="editIndex" value="<%= editIndex %>">
		<p>料理名</p>
		<input type="text" name="recipe_name" value="<%= recipeName %>">

		<p>URL</p>
		<input type="text" name="url" value="<%= url %>">

		<p>メモ</p>
		<textarea name="memo"><%= memo %></textarea>

		<br> <br>

		<button type="submit">登録</button>
	</form>

	<a href="index.jsp">トップへ戻る</a>

</body>
</html>