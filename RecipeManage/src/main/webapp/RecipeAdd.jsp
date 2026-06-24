<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Recipe"%>
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>料理登録</title>
<style>
body {
	background-color: #f7f3ea;
	font-family: sans-serif;
	margin: 0;
	padding: 16px;
	color: #333;
}

.form-card {
	max-width: 720px;
	margin: 0 auto;
	background: white;
	padding: 24px;
	border-radius: 18px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.15);
}

h1 {
	text-align: center;
	margin-top: 0;
	color: #333;
}

p {
	margin-bottom: 6px;
	font-weight: bold;
}

input[type="text"], textarea, select {
	width: 100%;
	box-sizing: border-box;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 10px;
	font-size: 16px;
	margin-bottom: 14px;
}

textarea {
	resize: vertical;
}

button {
	width: 100%;
	padding: 14px;
	background: #e67e22;
	color: white;
	border: none;
	border-radius: 10px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 10px;
}

button:hover {
	background: #d2691e;
}

.back-link {
	display: block;
	text-align: center;
	margin-top: 16px;
	padding: 12px;
	background: white;
	color: #d2691e;
	border: 2px solid #d2691e;
	border-radius: 10px;
	text-decoration: none;
	font-weight: bold;
}

.error {
	color: red;
	text-align: center;
	font-weight: bold;
}
</style>
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
	String tag = "";
	String title = "料理を登録する";
	String buttonText = "登録";

	if (recipe != null) {
		recipeName = recipe.getRecipeName();
		url = recipe.getUrl();
		memo = recipe.getMemo();
		id = String.valueOf(recipe.getId());
		materials = recipe.getMaterials();
		steps = recipe.getSteps();
		tag = recipe.getTag();
		title = "料理を編集する";
		buttonText = "更新";
	}
	%>


	<div class="form-card">
		<h1><%=title%></h1>

		<%
		String errorMessage = (String) request.getAttribute("errorMessage");
		if (errorMessage != null) {
		%>
		<p class="error"><%=errorMessage%></p>
		<%
}
%>

		<form action="RecipeServlet" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="id" value="<%=id%>"> <input
				type="hidden" name="old_thumbnail_url"
				value="<%=recipe == null ? "" : recipe.getThumbnailUrl()%>">

			<p>料理名</p>
			<input type="text" name="recipe_name" value="<%=recipeName%>">

			<p>料理画像</p>
			<input type="file" name="image" accept="image/*">

			<p>URL</p>
			<input type="text" name="url" value="<%=url%>">

			<p>材料</p>
			<textarea name="materials" rows="6" cols="50"><%=materials%></textarea>

			<p>作り方</p>
			<textarea name="steps" rows="10" cols="50"><%=steps%></textarea>


			<p>メモ</p>
			<textarea name="memo"><%=memo%></textarea>

			<p>タグ</p>
			<input type="text" name="tag" value="<%=tag == null ? "" : tag%>"
				placeholder="例：作り置き,弁当,節約">

			<button type="submit"><%=buttonText%></button>
		</form>

		<a href="RecipeList.jsp" class="back-link">一覧へ戻る</a>
	</div>
</body>
</html>