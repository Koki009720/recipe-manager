<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<style>
body {
	background-color: #f7f3ea;
	font-family: sans-serif;
	margin: 0;
	padding: 20px;
	color: #333;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.top-card {
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 2px 12px rgba(0,0,0,0.15);
	text-align: center;
	width: 100%;
	max-width: 500px;
}

h1 {
	margin-top: 0;
	font-size: 36px;
}

.subtitle {
	color: #666;
	margin-bottom: 30px;
	font-size: 18px;
}

.menu-button {
	display: block;
	width: 100%;
	box-sizing: border-box;
	padding: 16px;
	margin: 12px 0;
	background: #e67e22;
	color: white;
	text-decoration: none;
	border-radius: 12px;
	font-size: 18px;
	font-weight: bold;
	transition: 0.2s;
}

.menu-button:hover {
	background: #d2691e;
	transform: translateY(-2px);
}
</style>
<meta charset="UTF-8">
<title>Recipe Manager</title>
</head>

<body>

	<div class="top-card">

		<h1>🍳 Recipe Manager</h1>

		<p class="subtitle">
			あなたのためのレシピ帳
		</p>

		<a href="RecipeAdd.jsp" class="menu-button">
			料理を登録する
		</a>

		<a href="RecipeList.jsp" class="menu-button">
			料理一覧を見る
		</a>

	</div>

</body>