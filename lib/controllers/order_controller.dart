import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/controllers/menu_controller.dart';
import 'package:pt_pick_up_platform/custom/order_details.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import 'package:pt_pick_up_platform/models/order_items.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class OrderController extends ChangeNotifier {
  Map<int, OrderItems> cartItems = {};
  int? currentRestaurantId;

  // final menuController = MenuController1();

  List<OrderItems> get _cartItems => cartItems.values.toList();

  bool get hasItems => _cartItems.isNotEmpty;
  int get totalAmount {
    return cartItems.values.fold(0, (sum, item) => sum + item.totalAmount);
  }

  void addToCard({required int id, required int quantity, required item}) async {
    if (quantity <= 0) {
      throw Exception('Quanity must be greater then 0');
    }
    try {
      // final menuItem = await menuController.fetchMenuItem(itemId: id);
      print("itemId: $id");
      final menuItemResponse = await supabase.from('menu_items').select('*, menu_section!inner(restaurant_id)').eq('id', id).single();

      if (menuItemResponse == null || menuItemResponse.isEmpty) {
        throw Exception('Menu item not found');
      }
      final menuitem = menuItemResponse;
      final restaurantId = menuitem['menu_section']['restaurant_id']; //TODO If i use UUID add 'as int'
      final price = menuitem['price'];

      print('Restaurant ID: $restaurantId');
      // print('menuitem: $menuitem');
      final menuItem = MenuItem.fromMap(menuitem);

      if (cartItems.isEmpty) {
        currentRestaurantId = restaurantId;
      } else if (currentRestaurantId != restaurantId) {
        throw Exception('You can only order from one restaurant at a time');
      }

      final totalAmount = price * quantity;

      print('Debug - MenuItem data: ${menuitem.toString()}');
      if (cartItems.containsKey(id)) {
        final existingItem = cartItems[id]!;
        cartItems[id] = OrderItems(
          id: existingItem.id,
          orderId: existingItem.orderId,
          menuItemId: id,
          menuItem: menuItem,
          quantity: quantity,
          unitPrice: price,
          totalAmount: totalAmount,
        );
        print("total amount:  €$totalAmount"); //Testing whether it works
      } else {
        cartItems[id] = OrderItems(
            id: DateTime.now().millisecondsSinceEpoch,
            orderId: 0, //Temporary value, will be updated when order is placed
            menuItemId: id,
            menuItem: menuItem,
            quantity: quantity,
            unitPrice: price,
            totalAmount: totalAmount);

        print("total amount:  €$totalAmount");
      }
      notifyListeners();
    } catch (e) {}
    print('Adding item $id to cart with quantity $quantity');
  }

  void showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailSheet(cartItems: cartItems),
    );
  }
}
