import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import '../controllers/menu_controller.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';

class customMenuWidgets {
  final menuController = MenuController1();
  final OrderController orderController;

  customMenuWidgets({required this.orderController});

  Widget buildMenuSection(BuildContext context, Map<String, dynamic> section) {
    String title = section['title'];
    int sectionId = section['id'];
    print('Building menu section: title=$title, sectionId=$sectionId');

    return FutureBuilder<List<MenuItem>>(
      future: menuController.fetchMenuItems(sectionId: sectionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading menu items'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No menu items available!'));
        }

        List<MenuItem> items = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,

              style: Theme.of(context).textTheme.headlineLarge,
              //   style:  TextStyle(

              //            fontSize: 20,
              // fontWeight: FontWeight.bold,
              //   ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return MenuItemWidget(item: items[index], orderController: orderController);
              },
            ),
          ],
        );
      },
    );
  }
}

//   Widget buildMenuItem(BuildContext context, MenuItem item) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               image: item.imageUrl != null
//                 ? DecorationImage(
//                   image: NetworkImage(item.imageUrl!),
//                   fit: BoxFit.cover,
//                 )
//                 : null,
//             ),
//             child: item.imageUrl == null
//               ? const Icon(
//                 Icons.image_not_supported,
//                 size: 80,
//                 color: Colors.grey,
//                 )
//               : null,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name,
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   item.description ?? 'No description available',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 14,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 9),
//                 Text(
//                   '\$${item.price}',
//                   style: const TextStyle(
//                     color: Colors.deepOrange,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.add_shopping_cart),
//             color: Colors.deepOrange,

//             onPressed: () {
//               // print('Add to cart: ${item.name}');
//               orderController.addToCard(id: item.id,  quantity:  1);
// //       setState {{

// // }};

//             },
//           ),
//         ],
//       ),
//     );
//   }
//   }

class MenuItemWidget extends StatefulWidget {
  final MenuItem item;
  final OrderController orderController;
// final int  itemCount = 0;
  const MenuItemWidget({
    Key? key,
    required this.item,
    required this.orderController,
  }) : super(key: key);

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  int itemCount = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: widget.item.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(widget.item.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.item.imageUrl == null
                ? const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.item.description ?? 'No description available',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 9),
                Text(
                  '\$${widget.item.price}',
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            color: Colors.deepOrange,
            onPressed: () {
              // print('Add to cart: ${item.name}');

              itemCount++;
              widget.orderController.addToCard(
                id: widget.item.id, quantity: itemCount,

                // restaurantId: widget.restaurantId,
                // price: widget.item.price,
              );
            },
          ),
        ],
      ),
    );
  }
}
