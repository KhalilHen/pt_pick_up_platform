import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/custom/order_details.dart';
import 'package:pt_pick_up_platform/listeners/order_status_screen.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import 'package:pt_pick_up_platform/models/order.dart';
import 'package:pt_pick_up_platform/models/order_items.dart';
import '../main.dart';
import 'package:pt_pick_up_platform/auth/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderController extends ChangeNotifier {
  Map<int, OrderItems> cartItems = {};
  int? currentRestaurantId;
  final cartNotifier = ValueNotifier<bool>(false);
  final authController = AuthService();
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

      //  print('Debug - MenuItem data: ${menuitem.toString()}');
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

      cartNotifier.value = hasItems;
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

  void removeItem(int id) {
    if (cartItems.containsKey(id)) {
      final existingItem = cartItems[id]!;
      if (existingItem.quantity > 1) {
        addToCard(id: id, quantity: existingItem.quantity - 1, item: existingItem.menuItem);
      } else {
        cartItems.remove(id);
        cartNotifier.value = hasItems;

        notifyListeners();
      }
    }
  }

  void addItem(MenuItem item) {
    if (cartItems.containsKey(item.id)) {
      final existingItem = cartItems[item.id]!;
      addToCard(id: item.id, quantity: existingItem.quantity + 1, item: item);
    } else {
      addToCard(id: item.id, quantity: 1, item: item);
    }
  }

  Future<Order> createOrder(BuildContext context) async {
    if (cartItems.isEmpty) {
      throw Exception('No items in cart');
    }

    final userResponse = await authController.getLoggedInUser();
    if (userResponse == null || userResponse.isEmpty) {
      // throw Exception('User not found');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not found')),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).pushReplacementNamed('/login');
    }

    try {
      print('User: $userResponse');

      final orderResponse = await supabase
          .from('order')
          .insert({
            'user_id': userResponse,
            'restaurant_id': currentRestaurantId,
            'total_amount': totalAmount,
          })
          .select()
          .single();

      print('Order insert information:  $orderResponse');

      final orderId = orderResponse['id'];
//  TODO Change this later into  a seperate function
      await supabase.from('order_items').insert(
            cartItems.values
                .map((item) => {
                      'order_id': orderId,
                      'menu_item_id': item.menuItemId,
                      'quantity': item.quantity,
                      'unit_price': item.unitPrice,
                      'sub_total': item.totalAmount,
                    })
                .toList(),
          );
      await initializeFirebaseOrderStatus(orderResponse);

      final order = Order(
        id: orderId,
        userId: userResponse,
        restaurantId: currentRestaurantId!,
        totalAmount: totalAmount,
        status: OrderStatus.Pending,
      );
      clearCart();

      print('Order created: $order');

      // Navigator.pushNamed(context, OrderStatusScreen );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OrderStatusScreen(
      //       orderId: order.id,
      //     ),
      //   ),
      // );
      return order;
    } catch (e) {
      throw Exception('Error: $e');
    }
    throw Exception('Order creation failed');
  }

  Future<void> initializeFirebaseOrderStatus(Map<String, dynamic> orderResponse) async {
    final reference = FirebaseDatabase.instance.ref("order/${orderResponse['id']}");

    await reference.set({
      'order_id': orderResponse['id'],
      'status': OrderStatus.Pending.name,
      'total_amount': orderResponse['total_amount'],
      'user_id': orderResponse['user_id'],
      'restaurant_id': orderResponse['restaurant_id'],
    });
  }

  void clearCart() {
    cartItems.clear();
    currentRestaurantId = null;
    notifyListeners();
  }
}
