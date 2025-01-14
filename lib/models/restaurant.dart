import 'package:pt_pick_up_platform/models/menu_section.dart';

class Restaurant  {

  final int  id;
  final String name;
  final String description;
  final String address;
  final int phone_number;
  final double rating;
  final int reviewCount;
  final List<String> categories;
  final List<MenuSection> menuSections;
  
    Restaurant({
      required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.phone_number,
      required this.rating,
      required this.reviewCount,
      required this.categories,
      required this.menuSections,
    });
  }
  