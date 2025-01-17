

class OrderItems {

  final  int id; 
  final int orderId;
  final int menuItemId;
  final int quantity;
  final int unitPrice;
  final int totalAmount;


  OrderItems({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
  });
  

  

   factory OrderItems.fromMap(Map<String, dynamic> data) {

    return OrderItems(
      id: data['id'],
      orderId: data['order_id'],
      menuItemId: data['menu_item_id'],
      quantity: data['quantity'],
      unitPrice: data['unit_price'],
      totalAmount: data['total_amount'],
    );
   }

}