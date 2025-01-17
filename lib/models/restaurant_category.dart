


class RestaurantCategory {

  final int id;
  final int restaurantId;
  final int categoryId;

  RestaurantCategory({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
  });

factory RestaurantCategory.fromJson(Map<String, dynamic> json) {

  return RestaurantCategory(id: json['id'], restaurantId: json['restaurant_id'], categoryId: json['category_id']);
}
  
}