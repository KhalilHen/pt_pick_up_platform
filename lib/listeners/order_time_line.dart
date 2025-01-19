import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrderTimeLine extends StatelessWidget {
  final CustomerOrderStatus status;
  final bool isCompleted;
  final bool isActive;

  const OrderTimeLine({
    // Key? key,
    required this.status,
    this.isCompleted = false,
    this.isActive = false,
  });
  // : super(key: key);

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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? Colors.deepOrange : Colors.grey[300],
        border: isActive ? Border.all(color: Colors.deepOrange, width: 3) : null,
      ),
      child: isCompleted ? const Icon(Icons.check, size: 20, color: Colors.white) : null,
    );
  }

  Widget statusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? Colors.deepOrange.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.deepOrange : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getStatusTitle(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.deepOrange : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            getStatusDescription(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String getStatusTitle() {
    switch (status) {
      // case CustomerOrderStatus.Waiting:
      //   return "Order waiting to be confirmed";

      case CustomerOrderStatus.Confirmed:
        return "Your order is Confirmed";

      case CustomerOrderStatus.Preparing:
        return "Preparing your order";

      case CustomerOrderStatus.ReadyForPickUp:
        return "Your order is read for pick-up";

      // case CustomerOrderStatus.:
      //   return "Order Completed";

      default:
        return "Wen't something wrong";
    }
  }

  String getStatusDescription() {
    switch (status) {
      case OrderStatus.Accepted:
        return "Your order is confirmed";

      case OrderStatus.Kitchen:
        return "Your order is being prepared";

      case OrderStatus.ReadForPickUp:
        return "Your order is ready to be picked up";

      default:
        return "Wen't something wrong";
    }
  }
}
