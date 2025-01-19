import 'package:flutter/material.dart';
import 'order_listener.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrderStatusScreen extends StatefulWidget {
  final int orderId;

  const OrderStatusScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  late OrderStatusListener statussListener;
  OrderStatus currentStatus = OrderStatus.Pending;

  @override
  void initState() {
    super.initState();
    statussListener = OrderStatusListener(widget.orderId);
    statussListener.startListening((status) {
      setState(() {
        currentStatus = status;
      });
    });
  }

  @override
  void dispose() {
    statussListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order #${widget.orderId}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Order Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildStatusIndicator(),
            const SizedBox(height: 20),
            Text(
              currentStatus.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    final statusIndex = OrderStatus.values.indexOf(currentStatus);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: OrderStatus.values.map((status) {
        final isCompleted = OrderStatus.values.indexOf(status) <= statusIndex;
        return _StatusDot(
          isCompleted: isCompleted,
          isActive: status == currentStatus,
        );
      }).toList(),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;

  const _StatusDot({
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? Colors.green : Colors.grey,
        border: isActive ? Border.all(color: Colors.blue, width: 3) : null,
      ),
    );
  }
}
