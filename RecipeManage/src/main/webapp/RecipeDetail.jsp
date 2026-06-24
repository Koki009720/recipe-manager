<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Recipe"%>
<%@ page import="java.net.URLEncoder"%>

<%
Recipe recipe = (Recipe) request.getAttribute("recipe");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>レシピ詳細</title>

<style>
body {
	margin: 0;
	padding: 16px;
	background: #f7f3ea;
	font-family: sans-serif;
	color: #333;
}

.detail-card {
	max-width: 760px;
	margin: 0 auto;
	background: white;
	border-radius: 18px;
	padding: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.15);
}

h1 {
	margin-top: 0;
	font-size: 28px;
}

.recipe-image {
	width: 100%;
	border-radius: 14px;
	margin: 16px 0;
}

.section {
	margin-top: 24px;
}

.section-title {
	font-weight: bold;
	font-size: 20px;
	border-left: 6px solid #e67e22;
	padding-left: 10px;
	margin-bottom: 10px;
}

.youtube-link, .back-link {
	display: block;
	text-align: center;
	padding: 14px;
	border-radius: 10px;
	text-decoration: none;
	font-weight: bold;
	margin-top: 14px;
}

.youtube-link {
	background: #ff7043;
	color: white;
}

.back-link {
	background: white;
	color: #d2691e;
	border: 2px solid #d2691e;
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
</style>
</head>
<body>
	<%
	if (recipe == null) {
	%>
	<p>レシピ情報が見つかりませんでした。</p>
	<a href="RecipeList.jsp">一覧へ戻る</a>
</body>
</html>
<%
return;
}
%>

<div class="detail-card">

	<h1><%=recipe.getRecipeName()%></h1>
	<%
	if (recipe.getTag() != null && recipe.getTag().length() > 0) {
		String[] tags = recipe.getTag().split("[,、]");
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
	if (recipe.getThumbnailUrl() != null && recipe.getThumbnailUrl().length() > 0) {
	%>
	<img src="<%=recipe.getThumbnailUrl()%>" class="recipe-image">
	<%
}
%>

	<div class="section">
		<div class="section-title">メモ</div>
		<p><%=recipe.getMemo()%></p>
	</div>

	<div class="section">
		<div class="section-title">材料</div>
		<p>
			<%=recipe.getMaterials() == null
		? ""
		: "・" + recipe.getMaterials().replace("\n", "<br>・")%>
		</p>
	</div>

	<div class="section">
		<div class="section-title">作り方</div>
		<p>
			<%=recipe.getSteps() == null
		? ""
		: recipe.getSteps().replace("\n", "<br>")%>
		</p>
	</div>

	<a href="<%=recipe.getUrl()%>" class="youtube-link" target="_blank">
		YouTubeで見る </a> <a href="RecipeList.jsp" class="back-link"> 一覧へ戻る </a>

</div>

</body>
</html>