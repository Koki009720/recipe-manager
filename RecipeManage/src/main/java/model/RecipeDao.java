package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RecipeDao {

	// レシピを追加
	public void insertRecipe(String recipeName, String url, String memo,
			String materials, String steps, String thumbnailUrl, String tag) throws Exception {

		String sql = "INSERT INTO recipes "
				+ "(recipe_name, url, memo, materials, steps, thumbnail_url, tag) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setString(1, recipeName);
		pstmt.setString(2, url);
		pstmt.setString(3, memo);
		pstmt.setString(4, materials);
		pstmt.setString(5, steps);
		pstmt.setString(6, thumbnailUrl);
		pstmt.setString(7, tag);

		pstmt.executeUpdate();

		pstmt.close();
		con.close();
	}

	// レシピを削除
	public void deleteRecipe(int id) throws Exception {

		String sql = "DELETE FROM recipes WHERE id = ?";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setInt(1, id);
		pstmt.executeUpdate();

		pstmt.close();
		con.close();
	}

	// レシピを更新
	public void updateRecipe(int id, String recipeName, String url, String memo,
			String materials, String steps, String thumbnailUrl, String tag) throws Exception {

		String sql = "UPDATE recipes "
				+ "SET recipe_name = ?, url = ?, memo = ?, materials = ?, steps = ?, thumbnail_url = ?, tag = ? "
				+ "WHERE id = ?";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setString(1, recipeName);
		pstmt.setString(2, url);
		pstmt.setString(3, memo);
		pstmt.setString(4, materials);
		pstmt.setString(5, steps);
		pstmt.setString(6, thumbnailUrl);
		pstmt.setString(7, tag);
		pstmt.setInt(8, id);

		pstmt.executeUpdate();

		pstmt.close();
		con.close();
	}

	// レシピを表示(個別)
	public Recipe selectRecipeById(int id) throws Exception {

		String sql = "SELECT id, recipe_name, url, memo, materials, steps, thumbnail_url, favorite, tag "
				+ "FROM recipes WHERE id = ?";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setInt(1, id);

		ResultSet rs = pstmt.executeQuery();

		Recipe recipe = null;

		if (rs.next()) {
			recipe = new Recipe();
			recipe.setId(rs.getInt("id"));
			recipe.setRecipeName(rs.getString("recipe_name"));
			recipe.setUrl(rs.getString("url"));
			recipe.setMemo(rs.getString("memo"));
			recipe.setMaterials(rs.getString("materials"));
			recipe.setSteps(rs.getString("steps"));
			recipe.setThumbnailUrl(rs.getString("thumbnail_url"));
			recipe.setFavorite(rs.getInt("favorite"));
			recipe.setTag(rs.getString("tag"));
		}

		rs.close();
		pstmt.close();
		con.close();

		return recipe;
	}

	// レシピを表示(個別) 別名
	public Recipe selectById(int id) throws Exception {
		return selectRecipeById(id);
	}

	//検索機能
	public ArrayList<Recipe> searchRecipes(String keyword) throws Exception {
		ArrayList<Recipe> recipeList = new ArrayList<Recipe>();

		String sql = "SELECT id, recipe_name, url, memo, materials, steps, thumbnail_url, favorite, tag "
		        + "FROM recipes "
		        + "WHERE recipe_name LIKE ? "
		        + "OR memo LIKE ? "
		        + "OR materials LIKE ? "
		        + "OR steps LIKE ? "
		        + "OR tag LIKE ? "
		        + "ORDER BY id DESC";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);

		String searchWord = "%" + keyword + "%";
		pstmt.setString(1, searchWord);
		pstmt.setString(2, searchWord);
		pstmt.setString(3, searchWord);
		pstmt.setString(4, searchWord);
		pstmt.setString(5, searchWord);
		
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			Recipe recipe = new Recipe();
			recipe.setId(rs.getInt("id"));
			recipe.setRecipeName(rs.getString("recipe_name"));
			recipe.setUrl(rs.getString("url"));
			recipe.setMemo(rs.getString("memo"));
			recipe.setMaterials(rs.getString("materials"));
			recipe.setSteps(rs.getString("steps"));
			recipe.setThumbnailUrl(rs.getString("thumbnail_url"));
			recipe.setFavorite(rs.getInt("favorite"));
			recipe.setTag(rs.getString("tag"));

			recipeList.add(recipe);
		}

		rs.close();
		pstmt.close();
		con.close();

		return recipeList;
	}

	// お気に入り切り替え
	public void updateFavorite(int id, int favorite) throws Exception {

		String sql = "UPDATE recipes SET favorite = ? WHERE id = ?";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setInt(1, favorite);
		pstmt.setInt(2, id);

		pstmt.executeUpdate();

		pstmt.close();
		con.close();
	}

	// レシピを表示(全体)
	public ArrayList<Recipe> selectAllRecipes() throws Exception {

		ArrayList<Recipe> recipeList = new ArrayList<Recipe>();

		String sql = "SELECT id, recipe_name, url, memo, materials, steps, thumbnail_url, favorite, tag"
		        + " FROM recipes ORDER BY id DESC";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			Recipe recipe = new Recipe();

			recipe.setId(rs.getInt("id"));
			recipe.setRecipeName(rs.getString("recipe_name"));
			recipe.setUrl(rs.getString("url"));
			recipe.setMemo(rs.getString("memo"));
			recipe.setMaterials(rs.getString("materials"));
			recipe.setSteps(rs.getString("steps"));
			recipe.setThumbnailUrl(rs.getString("thumbnail_url"));
			recipe.setFavorite(rs.getInt("favorite"));
			recipe.setTag(rs.getString("tag"));

			recipeList.add(recipe);
		}

		rs.close();
		pstmt.close();
		con.close();

		return recipeList;
	}

	//お気に入り一覧表示
	public ArrayList<Recipe> selectFavoriteRecipes() throws Exception {

		ArrayList<Recipe> recipeList = new ArrayList<Recipe>();

		String sql = "SELECT id, recipe_name, url, memo, materials, steps, thumbnail_url, favorite, tag"
		        + " FROM recipes"
		        + " WHERE favorite = 1"
		        + " ORDER BY id DESC";

		Connection con = DbUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			Recipe recipe = new Recipe();

			recipe.setId(rs.getInt("id"));
			recipe.setRecipeName(rs.getString("recipe_name"));
			recipe.setUrl(rs.getString("url"));
			recipe.setMemo(rs.getString("memo"));
			recipe.setMaterials(rs.getString("materials"));
			recipe.setSteps(rs.getString("steps"));
			recipe.setThumbnailUrl(rs.getString("thumbnail_url"));
			recipe.setFavorite(rs.getInt("favorite"));
			recipe.setTag(rs.getString("tag"));

			recipeList.add(recipe);
		}

		rs.close();
		pstmt.close();
		con.close();

		return recipeList;

	}
}