import 'package:pt_pick_up_platform/models/menu_section.dart';

class Restaurant {
  final int id;
  final String name;
  final String description;
  final double rating;
  final int reviewCount;
  final String? imgUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviewCount,
    this.imgUrl,
  });

  factory Restaurant.fromMap(Map<String, dynamic> data) {
    return Restaurant(
      id: _parseId(data['id']),
      name: _parseName(data['name']),
      description: _parseDescription(data['description']),
      imgUrl: data['image_url']?.toString(),
      rating: _parseRating(data['rating']),
      reviewCount: _parseReviewCount(data['review_count']),
    );
  }

  static int _parseId(dynamic value) {
    if (value == null) return 0;
    return value is int ? value : int.tryParse(value.toString()) ?? 0;
  }

  static String _parseName(dynamic value) {
    if (value == null) return 'Unknown Restaurant';
    return value.toString().trim().isEmpty ? 'Unknown Restaurant' : value.toString();
  }

  static String _parseDescription(dynamic value) {
    if (value == null) return 'No description available';
    return value.toString().trim().isEmpty ? 'No description available' : value.toString();
  }

  static double _parseRating(dynamic value) {
    if (value == null) return 0.0;
    return value is double ? value : double.tryParse(value.toString()) ?? 0.0;
  }

  static int _parseReviewCount(dynamic value) {
    if (value == null) return 0;
    return value is int ? value : int.tryParse(value.toString()) ?? 0;
  }
}
