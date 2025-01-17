import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import 'package:pt_pick_up_platform/models/menu_section.dart';
import 'package:pt_pick_up_platform/main.dart';

class MenuController1 {
  Future<List<MenuSection>> fetchMenuSections({required int restaurantId}) async {

    
    final response = await supabase
        .from('menu_section')
        .select()
        .eq('restaurant_id', restaurantId);


      print( 'menuSections response: $response'); //This is filled correctly
    if (response == null || response.isEmpty) {
      print('No menu sections found for restaurant $response');

      return [];
    }
    return (response as List<dynamic>)
        .map((data) => MenuSection.fromMap(data as Map<String, dynamic>))
        .toList();

  }

  Future<List<MenuItem>> fetchMenuItems({required int sectionId}) async {
    // print('Fetching menu items for section ID: $sectionId');

    try {
      final response = await supabase
          .from('menu_items')
          .select()
          .eq('section_id', sectionId);

      // print('Raw response from menu_items query: $response');

      if (response == null || response.isEmpty) {
        print('No menu items found for section $sectionId');
        return [];
      }

      final items = (response as List<dynamic>).map((data) {
        // print('Processing item data: $data');
        return MenuItem.fromMap(data as Map<String, dynamic>);
      }).toList();

      // print('Successfully parsed ${items.length} menu items');
      return items;
    } catch (e, stackTrace) {
      print('Error fetching menu items: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}