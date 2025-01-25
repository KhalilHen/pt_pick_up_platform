import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/category.dart';
import 'package:pt_pick_up_platform/models/restaurant_category.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';
import '../main.dart';

class CategoryController {
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await supabase.from('category').select();

      if (response == null || response.isEmpty) {
        print(response);
        return [];
      } else {
        print(response);

        final data = response;
        return data.map((e) => Category.fromMap(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Category>> fetchRestaurantCategory({
    required int restaurantId,
  }) async {
    try {
      final response = await supabase.from('restaurant_category').select('id, restaurant_id, category_id').eq('restaurant_id', restaurantId);

      if (response == null || response.isEmpty) {
        print('No restaurant categories found for restaurant $restaurantId');
        return [];
      }

      final restaurantCategories = response.map<RestaurantCategory>((item) => RestaurantCategory.fromJson(item)).toList();

      final categoryIds = restaurantCategories.map((rc) => rc.categoryId).toList();

      final categoryData = await supabase.from('category').select('id, name, icon_name').inFilter('id', categoryIds);

      if (categoryData == null || categoryData.isEmpty) {
        print('No categories found for the provided IDs: $categoryIds');
        return [];
      }

      final categories = categoryData.map<Category>((data) {
        return Category.fromMap(data as Map<String, dynamic>);
      }).toList();

      print('Fetched categories: $categories');
      return categories;
    } catch (e, stackTrace) {
      print("There went something wrong with fetching the restaurant categories: $e");
      print("StackTrace: $stackTrace");
      return [];
    }
  }
}
