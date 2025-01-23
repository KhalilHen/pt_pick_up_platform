import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({Key? key}) : super(key: key);

  final orders = [
    {
      'id': 1,
      'status': 'ready',
      'date': '20-1-2025',
      'restaurantName': 'Restaurant A',
      'items': 5,
      'total': 20.0,
      'image': 'https://via.placeholder.com/50',
    },
    {
      'id': 2,
      'status': 'Pending',
      'date': '23-1-2025',
      'restaurantName': 'Restaurant B',
      'items': 10,
      'total': 30.0,
      'image': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    //TODO Improve the structure
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'My orders',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: orders.isEmpty
            ? Center(
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
                      "No orders yet",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Your order history will appear here",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha((0.1 * 255).round()),
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
                            // color: Colors.
                            // ,
                            // color: getStatusColor(order.status).withAlpha((0.1 * 255).round()),
                            color: getStatusColor(order['status'] as String).withAlpha((0.1 * 255).round()),

                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.done_all,
                                color: Colors.green,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        // Order date
                        Text(
                          '20-1-2025',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'image',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'restaurant name',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '5  items   • \€20',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Order# 51',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200]!))),
                            child: const Center(
                              child: Text(
                                'View order details',
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
                },
              ),
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
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Orders"),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;

      case 'preparing':
        return Colors.blue;

      case 'ready':
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

      case 'preparing':
        return Icons.restaurant;

      case 'ready':
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
        return 'Pending';

      case 'preparing':
        return 'Preparing';

      case 'ready':
        return 'Ready for pick-up';

      case 'completed':
        return 'Completed';

      case 'cancelled':
        return 'Cancelled';

      default:
        return 'Unknown';
    }
  }
}

//* Worked on retrieving orders from the user but not worked yet  ↓  ↓  ↓  ↓ 

/*




import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/order.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart'; // Import your controller
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> _ordersFuture;
  final orderController = OrderController(); //

  @override
  void initState() {
    super.initState();
    _ordersFuture = orderController.fetchUserOrders(); // Fetch orders on page load
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
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load orders: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "No orders yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your order history will appear here",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          final orders = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderCard(order);
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
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Orders"),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).round()),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getStatusColor(order.status).withAlpha((0.1 * 255).round()),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(getStatusIcon(order.status), color: getStatusColor(order.status), size: 24),
                const SizedBox(width: 8),
                Text(
                  getStatusText(order.status),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Order Date
          Text(
            'Order Date: ${order.restaurant?.name ?? 'Unknown'}',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Restaurant Image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: order.restaurant?.imgUrl != null ? Image.network(order.restaurant!.imgUrl!, fit: BoxFit.cover) : const Icon(Icons.restaurant, size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                // Restaurant Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.restaurant?.name ?? 'Unknown Restaurant',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${order.orderItems.length} items • €${(order.totalAmount / 100).toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
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
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200]!))),
              child: const Center(
                child: Text(
                  'View order details',
                  style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return Colors.orange;
      case OrderStatus.ReadForPickUp:
        return Colors.blue;
      case OrderStatus.Completed:
        return Colors.green;
      case OrderStatus.Cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return Icons.schedule;
      case OrderStatus.ReadForPickUp:
        return Icons.delivery_dining;
      case OrderStatus.Completed:
        return Icons.done_all;
      case OrderStatus.Cancelled:
        return Icons.cancel;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  String getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return 'Pending';
      case OrderStatus.ReadForPickUp:
        return 'Ready for pick-up';
      case OrderStatus.Completed:
        return 'Completed';
      case OrderStatus.Cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
  
*/


