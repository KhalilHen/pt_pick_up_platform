import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String iconName;

  Category({
    required this.id,
    required this.name,
    required this.iconName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      iconName: json['icon_name'],
    );
  }

  IconData get icon {
    return _getIconData(iconName);
  }

  IconData _getIconData(String iconName) {
    return IconData(
      iconName.hashCode,
      fontFamily: 'MaterialIcons',
    );
  }

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }



}
