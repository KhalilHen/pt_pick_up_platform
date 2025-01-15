import 'package:/flutter/material.dart';
// import 'package:/';
import '../main.dart';

import 'package:pt_pick_up_platform/models/menu.dart';

class MenuController {

  Future<List<MenuItem>> fetchMenuItems() async {
    final response = await supabase.from('menu_section').select();

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