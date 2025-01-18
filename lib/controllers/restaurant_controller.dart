import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/main.dart';

class RestaurantController {
  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await supabase.from('restaurant').select();
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
}
