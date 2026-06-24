package model;

public class Recipe {
	

	//項目
	private String recipeName;
	private String url;
	private String memo;
	private String materials;
	private String steps;
	private String thumbnailUrl;
	private int favorite;

	public String getRecipeName() {
		return recipeName;
	}

	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	private int id;

	public int getId() {
	    return id;
	}

	public void setId(int id) {
	    this.id = id;
	}
	public String getMaterials() {
	    return materials;
	}

	public void setMaterials(String materials) {
	    this.materials = materials;
	}

	public String getSteps() {
	    return steps;
	}

	public void setSteps(String steps) {
	    this.steps = steps;
	}
	public String getThumbnailUrl() {
	    return thumbnailUrl;
	}

	public void setThumbnailUrl(String thumbnailUrl) {
	    this.thumbnailUrl = thumbnailUrl;
	}


	public int getFavorite() {
	    return favorite;
	}

	public void setFavorite(int favorite) {
	    this.favorite = favorite;
	}
	private String tag;

	public String getTag() {
	    return tag;
	}

	public void setTag(String tag) {
	    this.tag = tag;
	}
}
