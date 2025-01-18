import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/models/order_items.dart';

class OrderDetailsSheet extends StatelessWidget {
  final Map<int, OrderItems> cartItems;

  const OrderDetailsSheet({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('${cartItems.length} items'),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems.values.elementAt(index);
                    return ListTile(
                      title: Text(
                        item.menuItem.name ?? 'No title found',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(item.menuItem.description ?? 'No description found'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Price: \$${item.menuItem.price}'),
                          Text('Qty: ${item.quantity}'),
                        ],
                      ),
                    );
                  })),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:'),
                    Text('\$${OrderController().totalAmount}'),
                  ],
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Place Order'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
