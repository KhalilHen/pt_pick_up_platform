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
    return getIconData(iconName);
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'fastfood':
        return Icons.fastfood;
      case 'pizza':
        return Icons.local_pizza;
      case 'restaurant':
        return Icons.restaurant;

      case 'vegan':
        return Icons.coffee;
      case 'fish':
        return Icons.set_meal_outlined;
      // case 'burgers':
      case 'icecream':
        return Icons.icecream;

      // return Icons.food
      default:
        return Icons.help_outline; // Default icon if no match is found
    }
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      iconName: map['icon_name'],
    );
  }
}
