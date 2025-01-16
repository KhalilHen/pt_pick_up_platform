import 'package:pt_pick_up_platform/models/menu_section.dart';

class Restaurant  {

  final int  id;
  final String name;
  final String description;
  // final String? address;
  final double rating;
  final int reviewCount;
  final String?  imgUrl;
  // final List<MenuSection>? menuSections;
  
    Restaurant({
      required this.id,
      required this.name, 
      required this.description,
      // required this.address,
      // required this.phone_number,
      required this.rating,
      required this.reviewCount,
      // required this.categories,
      // required this.menuSections,
       required  this.imgUrl,
      //  required this.menuSections

    });


    factory Restaurant.fromMap(Map<String, dynamic> data) {

      return Restaurant(


        id: data['id'],
        name: data['name'],
        description: data['description'],
        // address: data['address'],
        imgUrl: data['image_url'],
        // phone_number: data['phone_number'], //Maby later
        rating: data['rating'],
        reviewCount: data['review_count'],
          //  menuSections: (data['menu_sections'] as List)
          // .map((e) => MenuSection.fromMap(e as Map<String, dynamic>))
          // .toList(),
      );
    }
    
  }
  

  