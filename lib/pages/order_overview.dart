import 'package:flutter/material.dart ';

import 'package:provider/provider.dart  ';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import 'package:pt_pick_up_platform/models/order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final orderController = Provider.of<OrderController>(context, listen: false);
    await orderController.fetchUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'My Orders',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Consumer<OrderController>(
        builder: (context, orderController, child) {
          return FutureBuilder<List<Order>>(
            future: orderController.fetchUserOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('An error occurred'));
              }
              final orders = snapshot.data ?? [];

              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'No Orders yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Your order history will appear here',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return buildOrderCard(context, order);
                  });
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
        ],
      ),
    );
  }

  Widget buildOrderCard(BuildContext context, Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getStatusColor(order.status.name).withAlpha(25),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      getStatusIcon(order.status.name),
                      color: getStatusColor(order.status.name),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getStatusText(order.status.name),
                      style: TextStyle(
                        color: getStatusColor(order.status.name),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  // order.createdAt,
                  '12-5-2',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: order.restaurant!.imgUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                order.restaurant!.imgUrl ?? '',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(Icons.restaurant, color: Colors.grey[400]),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.restaurant!.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' \$${order.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Navigate to order details
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: const Center(
                child: Text(
                  'View Details',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'kitchen':
        return Colors.blue;
      case 'ready_to_pick_up':
        return Colors.green;
      case 'completed':
        return Colors.deepOrange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'kitchen':
        return Icons.restaurant;
      case 'ready_to_pick_up':
        return Icons.check_circle;
      case 'completed':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Your order is pending';
      case 'kitchen':
        return 'Your oder is being prepared';
      case 'ready_to_pick_up':
        return 'Your order is ready for pick-up';
      case 'completed':
        return 'This order is Completed';
      case 'cancelled':
        return 'Your order is cancelled';
      default:
        return 'Unknown';
    }
  }
}
