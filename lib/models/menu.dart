import 'package:flutter/material.dart ';

class MenuItem {
  final int id;
  final String name;
  final String description;
  final int price;
  final String? imageUrl;
  final int sectionId;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.sectionId,
  });

  factory MenuItem.fromMap(Map<String, dynamic> data) {
    return MenuItem(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      imageUrl: data['image_url'],
      sectionId: data['section_id'],
    );
  }
}
