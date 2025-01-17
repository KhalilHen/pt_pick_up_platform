import 'package:flutter/material.dart ';
import 'package:pt_pick_up_platform/models/menu.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';

class MenuSection {

    final int id;
   final  int restaurantId;  
   final String name;
   

  MenuSection({ 

required this.id,
required this.restaurantId,
required this.name,
  });

  factory MenuSection.fromMap(Map<String, dynamic> data) {
    return MenuSection(
      id: data['id']  ,
      restaurantId: data['restaurant_id']  ,
      name: data['title']  ,
    );
  }
}