
class OrderItem {
  final String productId;
  final String productName;
  final String imagePath;
  final String category;
  final double price;
  final int quantity;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}

class OrderModel {
  final String id;
  final String customerName;
  final String phone;
  final String address;
  final DateTime createdAt;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final int statusIndex;

  const OrderModel({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    this.statusIndex = 0,
  });

  static const List<String> statuses = [
    'Order Placed',
    'Confirmed',
    'Packed',
    'Shipped',
    'Delivered',
  ];

  String get status => statuses[statusIndex];

  OrderModel copyWith({int? statusIndex}) {
    return OrderModel(
      id: id,
      customerName: customerName,
      phone: phone,
      address: address,
      createdAt: createdAt,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      statusIndex: statusIndex ?? this.statusIndex,
    );
  }
}
