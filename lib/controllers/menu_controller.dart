import  'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import 'package:pt_pick_up_platform/models/menu_section.dart';

import    'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/main.dart';
class MenuController1 {  

   Future<List<MenuSection>> fetchMenuSections({required int restaurantId}) async {
    final response = await supabase
        .from('menu_section')
        .select()
        .eq('restaurant_id', restaurantId);

    if (response == null || response.isEmpty) {
      return [];
    }
  return (response as List<dynamic>)
      .map((data) => MenuSection.fromMap(data as Map<String, dynamic>))
      .toList();

   }
  
 Future<List<MenuItem>> fetchMenuItems({required int sectionId}) async {
    final response = await supabase.from('menu_items').select().eq('menu_section', sectionId);

    if(response == null || response.isEmpty ) {
      print( response);
      return [];
    }
    else {
      print(response);

  return (response as List<dynamic>)
      .map((data) => MenuItem.fromMap(data as Map<String, dynamic>))
      .toList();
    }
  } 
} 