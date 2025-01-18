import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class Order {
  final int id;
  final String? userId;
  final int restaurantId;
  final int totalAmount;
  final OrderStatus status;
  // final Date orderTime;
  // final Data updateAt;

  Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.totalAmount,
    required this.status,
    // required this.orderTime,
    // required this.updateAt,
  });

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
      id: data['id'],
      userId: data['user_id'],
      restaurantId: data['restaurant_id'],
      totalAmount: data['total_amount'],
      status: OrderStatus.values[data['status']],
      // orderTime: data['order_time'],
      // updateAt: data['update_at'],
    );
  }
}
