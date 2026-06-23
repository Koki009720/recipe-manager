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
	String id = "";
	String materials = "";
	String steps = "";

	if (recipe != null) {
		recipeName = recipe.getRecipeName();
		url = recipe.getUrl();
		memo = recipe.getMemo();
		id = String.valueOf(recipe.getId());
		materials = recipe.getMaterials();
		steps = recipe.getSteps();
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
		<input type="hidden" name="id" value="<%=id%>">

		<p>料理名</p>
		<input type="text" name="recipe_name" value="<%=recipeName%>">

		<p>URL</p>
		<input type="text" name="url" value="<%=url%>">

		<p>材料</p>
		<textarea name="materials" rows="6" cols="50"><%=materials%></textarea>

		<p>作り方</p>
		<textarea name="steps" rows="10" cols="50"><%=steps%></textarea>


		<p>メモ</p>
		<textarea name="memo"><%=memo%></textarea>

		<br> <br>

		<button type="submit">登録</button>
	</form>

	<a href="index.jsp">トップへ戻る</a>

</body>
</html>