ALTER TABLE recipes ADD COLUMN materials TEXT;
ALTER TABLE recipes ADD COLUMN steps TEXT;
ALTER TABLE recipes ADD COLUMN thumbnail_url TEXT;
SELECT recipe_name, thumbnail_url FROM recipes;
ALTER TABLE recipes ADD COLUMN favorite INTEGER DEFAULT 0;
ALTER TABLE recipes ADD COLUMN tag TEXT;
PRAGMA table_info(recipes);