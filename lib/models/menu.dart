import 'package:flutter/material.dart ';


class MenuItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;


  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}