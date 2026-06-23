
package model;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;

public class DbUtil {

    public static Connection getConnection() throws Exception {

        Class.forName("org.sqlite.JDBC");

        String dbPath = "C:/pleiades/2026-05/RecipeManager/recipe.db";

        File dbFile = new File(dbPath);
        System.out.println("DB接続先：" + dbFile.getAbsolutePath());

        String url = "jdbc:sqlite:" + dbFile.getAbsolutePath();

        return DriverManager.getConnection(url);
    }
}