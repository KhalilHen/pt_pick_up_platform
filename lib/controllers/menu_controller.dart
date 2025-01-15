import  'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/menu.dart';

import    'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/main.dart';
class MenuController1 {  

 
  
 Future<List<MenuItem>> fetchMenuItems({required int sectionId}) async {
    final response = await supabase.from('menu_items').select().eq('menu_section', sectionId);

    if(response == null || response.isEmpty ) {
      print( response);
      return [];
    }
    else {
      print(response);

      final data = response;
      return data.map((e) => MenuItem.fromMap(e as Map<String, dynamic>)).toList();
    }
  } 
} 