
package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbUtil {

    public static Connection getConnection() throws Exception {

        Class.forName("org.sqlite.JDBC");

        String url = "jdbc:sqlite:C:/pleiades/2026-05/recipe.db";

        return DriverManager.getConnection(url);
    }
}