import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/models/order.dart';
import 'package:pt_pick_up_platform/models/order_items.dart';

class OrderDetailSheet extends StatelessWidget {
  final Map<int, OrderItems> cartItems;

  const OrderDetailSheet({required this.cartItems, super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Cart',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<OrderController>(
                    builder: (context, orderController, child) {
                      final items = orderController.cartItems.values.toList();
                      return ListView.separated(
                        controller: controller,
                        itemCount: orderController.cartItems.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          // final item = orderController.cartItems[index]!;
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: item.menuItem.imageUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(item.menuItem.imageUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    color: item.menuItem.imageUrl == null ? Colors.grey : null,
                                  ),
                                  child: item.menuItem.imageUrl == null ? const Icon(Icons.fastfood) : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.menuItem.name,
                                        style: Theme.of(context).textTheme.headlineMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '€${item.menuItem.price}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.deepOrange,
                                      ),
                                      onPressed: () {
                                        orderController.removeItem(item.menuItem.id);
                                      },
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          orderController.addItem(item.menuItem);
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.deepOrange,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ]),
                  child: Column(
                    children: [
                      Consumer<OrderController>(
                        builder: (context, controller, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total :',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${controller.totalAmount}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Provider.of<OrderController>(context, listen: false).createOrder(context);
                          },
                          label: const Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
