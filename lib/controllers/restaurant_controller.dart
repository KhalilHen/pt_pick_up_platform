import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/main.dart';

class RestaurantController {
  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await supabase.from('restaurant').select();

      // final response = await supabase.from('restaurant').select('*, restaurant_category(category_id)');
      if (response == null || response.isEmpty) {
        print(response);
        return [];
      } else {
        print(response);
        final data = response;
        return data.map((e) => Restaurant.fromMap(e as Map<String, dynamic>)).toList();

        // print(response);

        // final data = response;
        // return data.map((e) => Restaurant.fromMap(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }


}

    //  return response.map((e) {
    //       final restaurantData = e as Map<String, dynamic>;
    //       final categoryIds = (restaurantData['restaurant_category'] as List<dynamic>?)?.map((category) => category['category_id'] as int).toList();

    //       return Restaurant.fromMap(restaurantData).copyWith(categories: categoryIds ?? []);
    //     }).toList();
