package com.fintrack.dao;

import com.fintrack.model.Category;
import com.fintrack.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getCategoriesByType(String type) {

        List<Category> categories = new ArrayList<>();

        String sql = "SELECT category_id, category_name, type "
                   + "FROM categories "
                   + "WHERE type = ? "
                   + "ORDER BY category_name";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, type);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                Category category = new Category();

                category.setCategoryId(
                        resultSet.getInt("category_id"));

                category.setCategoryName(
                        resultSet.getString("category_name"));

                category.setType(
                        resultSet.getString("type"));

                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
}