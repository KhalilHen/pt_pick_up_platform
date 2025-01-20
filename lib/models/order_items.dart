import 'package:pt_pick_up_platform/models/menu.dart';
import 'menu.dart';

class OrderItems {
  final int id;
  final int orderId;
  final int menuItemId;
  final int quantity;
  final int unitPrice;
  final int totalAmount;
  final MenuItem menuItem; //Used to get the menu item fields

  OrderItems({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.menuItem,
  });

  factory OrderItems.fromMap(Map<String, dynamic> data) {
    return OrderItems(
      id: data['id'],
      orderId: data['order_id'],
      menuItemId: data['menu_item_id'],
      quantity: data['quantity'],
      unitPrice: data['unit_price'],
      totalAmount: data['sub_total'],
      menuItem: MenuItem.fromMap(data['menu_item']),
    );
  }
}
