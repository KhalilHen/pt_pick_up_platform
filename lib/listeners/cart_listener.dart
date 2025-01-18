import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pt_pick_up_platform/controllers/order_controller.dart';

class CartListeners extends StatelessWidget {
  const CartListeners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(builder: (context, orderController, child) {
      print('Rebuilding CartListeners: hasItems=${orderController.hasItems}');

      if (!orderController.hasItems) {
        return const SizedBox.shrink();
      }


      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Start Order',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    });
  }
}
