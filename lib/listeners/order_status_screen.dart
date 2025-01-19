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
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(22),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]),
            child: Column(
              children: [
                //
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
              ],
            ),
          ),
        ],
      )),
    );
  }
}
