import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrderTimeLine extends StatelessWidget {


  const OrderTimeLine({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          statusDot(),
          const SizedBox(
            width: 16,
          ),
          // Expanded(child: null),
          Expanded(child: statusCard())
        ],
      ),
    );
  }

  Widget statusDot() {
    return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.deepOrange, border: Border.all(color: Colors.deepOrange, width: 3)),
        child: const Icon(Icons.check, size: 20, color: Colors.white));
  }

  Widget statusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Status title
          Text(
            'Order Confirmed',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),

          const SizedBox(
            height: 8,
          ),
          Text(
            'description',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          )
        ],
      ),
    );
  }
}
