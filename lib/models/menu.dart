import 'package:flutter/material.dart ';


class MenuItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;


  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
     this.imageUrl,
  });
  

    factory MenuItem.fromMap(Map<String, dynamic> data) {
    return MenuItem(
        id: data['id'],
        name: data['name'], 
        description: data['description'],
        price: data['price'],
        imageUrl: data['image_url'],

     
        );
  }
}