import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/models/menu.dart';

class MenuItemBottomSheet extends StatefulWidget {
  final MenuItem menuItem;

  const MenuItemBottomSheet({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  _MenuItemBottomSheetState createState() => _MenuItemBottomSheetState();
}

class _MenuItemBottomSheetState extends State<MenuItemBottomSheet> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    //This listen for the quanity value
    final orderController = Provider.of<OrderController>(context, listen: false);
    if (orderController.cartItems.containsKey(widget.menuItem.id)) {
      quantity = orderController.cartItems[widget.menuItem.id]!.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<OrderController>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView(
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: widget.menuItem.imageUrl != null && widget.menuItem.imageUrl!.isNotEmpty
                                  ? Image.network(
                                      widget.menuItem.imageUrl!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => defaultImage(),
                                    )
                                  : defaultImage(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.menuItem.name,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '€${widget.menuItem.price.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.deepOrange,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.menuItem.description ?? 'No description available',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[700],
                                ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: quantity > 0 ? () => setState(() => quantity--) : null,
                                    ),
                                    Text(
                                      '$quantity',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => setState(() => quantity++),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: quantity > 0
                      ? () {
                          orderController.addToCard(id: widget.menuItem.id, quantity: quantity, item: widget.menuItem);
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //test
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget defaultImage() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image,
        size: 100,
        color: Colors.grey,
      ),
    );
  }
}
