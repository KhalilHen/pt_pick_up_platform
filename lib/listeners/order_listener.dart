import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrderStatusListener  {
  final DatabaseReference orderRef; 
    StreamSubscription<DatabaseEvent>? subscription;

   OrderStatusListener(int orderId)
   : orderRef = FirebaseDatabase.instance.ref('order/$orderId');

  // : orderRef = FirebaseDatabase.instance.ref('order/$orderId');

  void startListening(Function(OrderStatus) onStatusChanged) {
      subscription = orderRef.onValue.listen((event) {

        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if(data != null && data['status'] != null) {
          final status = OrderStatus.values.firstWhere((e) => e.name == data['status'], 
          orElse:  () => OrderStatus.Pending);
          onStatusChanged(status);
        }
      });
  }

  Future<void> dispose() async {

      await subscription?.cancel();

  }
}
