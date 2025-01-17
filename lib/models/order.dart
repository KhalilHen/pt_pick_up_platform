 


 import 'package:flutter/material.dart';

class Order {


  final int id;
  final int? userId;
  final int restaurantId;

  final int  totalAmount;
  // final Date orderTime;
  // final Data updateAt;



  Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.totalAmount,
    // required this.orderTime,
    // required this.updateAt,
  });

 

}