import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/main.dart';

class RestaurantController {
  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await supabase.from('restaurant').select().eq('high_light', false);

      // final response = await supabase.from('restaurant').select('*, restaurant_category(category_id)');
      if (response == null || response.isEmpty) {
        print(response);
        return [];
      } else {
        print(response);
        final data = response;
        return data.map((e) => Restaurant.fromMap(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Restaurant>> retrievePopularRestaurants() async {
    try {
      final response = await supabase.from('restaurant').select().eq('high_light', true);
      if (response == null || response.isEmpty) {
        return [];
      } else {
        print(response);
        final data = response;
        return data.map((e) => Restaurant.fromMap(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Restaurant>> retrieveAllRestaurants() async {
    try {
      final response = await supabase.from('restaurant').select();
      if (response == null || response.isEmpty) {
        return [];
      } else {
        final data = response;

        return data.map((e) => Restaurant.fromMap(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Restaurant>> fetchRestaurantsByCategory(int categoryId) async {
    try {
      final response = await supabase.from("restaurant_category").select('restaurant(*)').eq('category_id', categoryId);

      if (response == null || response.isEmpty) {
        return [];
      } else {
        final restaurants = response.map((e) => Restaurant.fromMap(e['restaurant'] as Map<String, dynamic>)).toList();
        return restaurants;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
