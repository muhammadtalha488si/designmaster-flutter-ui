
import 'package:flutter/material.dart';

import '../models/order_model.dart';
import 'cart_provider.dart';

class OrderProvider extends ChangeNotifier {
  static final OrderProvider _instance = OrderProvider._internal();

  factory OrderProvider() => _instance;

  OrderProvider._internal();

  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => List.unmodifiable(_orders);

  OrderModel? getOrder(String orderId) {
    for (final order in _orders) {
      if (order.id == orderId) {
        return order;
      }
    }

    return null;
  }

  OrderModel? placeOrder({
    required String customerName,
    required String phone,
    required String address,
  }) {
    final cart = CartProvider();

    if (cart.cartProducts.isEmpty) {
      return null;
    }

    final items = cart.cartProducts.map((product) {
      return OrderItem(
        productId: product.id,
        productName: product.name,
        imagePath: product.imagePath,
        category: product.category,
        price: product.price,
        quantity: cart.quantityFor(product.id),
      );
    }).toList();

    final order = OrderModel(
      id: 'DM${DateTime.now().millisecondsSinceEpoch}',
      customerName: customerName,
      phone: phone,
      address: address,
      createdAt: DateTime.now(),
      items: items,
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee,
      total: cart.totalPrice,
    );

    _orders.insert(0, order);

    cart.clearCart();
    notifyListeners();

    return order;
  }

  void advanceDemoStatus(String orderId) {
    final index = _orders.indexWhere((order) => order.id == orderId);

    if (index == -1) return;

    final order = _orders[index];

    if (order.statusIndex >= OrderModel.statuses.length - 1) {
      return;
    }

    _orders[index] = order.copyWith(
      statusIndex: order.statusIndex + 1,
    );

    notifyListeners();
  }
}
