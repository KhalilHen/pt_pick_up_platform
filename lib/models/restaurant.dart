import 'package:pt_pick_up_platform/models/menu_section.dart';

class Restaurant  {

  final int  id;
  final String name;
  final String description;
  final String? address;
  final double rating;
  final int reviewCount;
  final String?  imgUrl;
  
    Restaurant({
      required this.id,
      required this.name,
      required this.description,
      required this.address,
      // required this.phone_number,
      required this.rating,
      required this.reviewCount,
      // required this.categories,
      // required this.menuSections,
       required  this.imgUrl

    });


    factory Restaurant.fromMap(Map<String, dynamic> data) {

      return Restaurant(


        id: data['id'],
        name: data['name'],
        description: data['description'],
        address: data['address'],
        imgUrl: data['img_url'],
        // phone_number: data['phone_number'], //Maby later
        rating: data['rating'],
        reviewCount: data['review_count']
      );
    }
    
  }
  