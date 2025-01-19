import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'order_listener.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrderStatusScreen extends StatefulWidget {
  // final int orderId;

  const OrderStatusScreen({
    Key? key,
    //  required this.orderId
  }) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Order #10}',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          //Status Header
          StatusHeader(),

          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timeEstimate(),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}

Widget StatusHeader() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(color: Colors.grey.withAlpha((0.1 * 255).round()), spreadRadius: 1, blurRadius: 10),
    ]),
    child: Column(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 48,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Order Confirmed',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Your order has been confirmed and is being prepared',
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget timeEstimate() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Row(
      children: [
        const Icon(Icons.access_time, color: Colors.deepOrange),
        const SizedBox(width: 16),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated Time',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              '15-20 minutes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ))
      ],
    ),
  );
}
