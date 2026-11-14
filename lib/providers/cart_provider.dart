
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/product_data.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  static final CartProvider _instance = CartProvider._internal();

  factory CartProvider() => _instance;

  CartProvider._internal();

  static const String _cartKey = 'designmaster_cart_items';
  static const String _wishlistKey = 'designmaster_wishlist_items';

  final Map<String, int> _cartItems = {};
  final Set<String> _wishlistItems = {};

  bool _isInitialized = false;

  Future<void>? _initializationFuture;

  bool get isInitialized => _isInitialized;

  Map<String, int> get cartItems => Map.unmodifiable(_cartItems);

  Set<String> get wishlistItems => Set.unmodifiable(_wishlistItems);

  // Initialize and load saved data.
  Future<void> initialize() {
    if (_isInitialized) {
      return Future<void>.value();
    }

    return _initializationFuture ??= _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedCart = prefs.getString(_cartKey);

      if (savedCart != null) {
        final decoded = jsonDecode(savedCart);

        if (decoded is Map<String, dynamic>) {
          for (final entry in decoded.entries) {
            final quantity = entry.value;

            if (quantity is int && quantity > 0) {
              _cartItems[entry.key] = quantity;
            }
          }
        }
      }

      final savedWishlist = prefs.getString(_wishlistKey);

      if (savedWishlist != null) {
        final decoded = jsonDecode(savedWishlist);

        if (decoded is List) {
          _wishlistItems.addAll(decoded.whereType<String>());
        }
      }

      // Keep only products that exist in the catalog.
      final productIds = ProductData.products
          .map((product) => product.id)
          .toSet();

      _cartItems.removeWhere(
        (id, quantity) => !productIds.contains(id),
      );

      _wishlistItems.removeWhere(
        (id) => !productIds.contains(id),
      );

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Cart storage loading error: $e');

      _cartItems.clear();
      _wishlistItems.clear();

      // Prevent repeated initialization failures.
      _isInitialized = true;
    }
  }

  // Save Cart and Wishlist locally.
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        _cartKey,
        jsonEncode(_cartItems),
      );

      await prefs.setString(
        _wishlistKey,
        jsonEncode(_wishlistItems.toList()),
      );
    } catch (e) {
      debugPrint('Cart storage saving error: $e');
    }
  }

  List<ProductModel> get cartProducts {
    return ProductData.products
        .where((product) => _cartItems.containsKey(product.id))
        .toList();
  }

  List<ProductModel> get wishlistProducts {
    return ProductData.products
        .where((product) => _wishlistItems.contains(product.id))
        .toList();
  }

  int quantityFor(String productId) {
    return _cartItems[productId] ?? 0;
  }

  int get totalCartItems {
    return _cartItems.values.fold(
      0,
      (sum, quantity) => sum + quantity,
    );
  }

  double get subtotal {
    double total = 0;

    for (final product in cartProducts) {
      total += product.price * quantityFor(product.id);
    }

    return total;
  }

  double get deliveryFee {
    return _cartItems.isEmpty ? 0 : 200;
  }

  double get totalPrice => subtotal + deliveryFee;

  bool isInWishlist(String productId) {
    return _wishlistItems.contains(productId);
  }

  void addToCart(ProductModel product) {
    _cartItems[product.id] = quantityFor(product.id) + 1;

    notifyListeners();
    unawaited(_saveData());
  }

  void decreaseQuantity(ProductModel product) {
    final quantity = quantityFor(product.id);

    if (quantity <= 1) {
      _cartItems.remove(product.id);
    } else {
      _cartItems[product.id] = quantity - 1;
    }

    notifyListeners();
    unawaited(_saveData());
  }

  void increaseQuantity(ProductModel product) {
    _cartItems[product.id] = quantityFor(product.id) + 1;

    notifyListeners();
    unawaited(_saveData());
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product.id);

    notifyListeners();
    unawaited(_saveData());
  }

  void toggleWishlist(ProductModel product) {
    if (_wishlistItems.contains(product.id)) {
      _wishlistItems.remove(product.id);
    } else {
      _wishlistItems.add(product.id);
    }

    notifyListeners();
    unawaited(_saveData());
  }

  void clearCart() {
    _cartItems.clear();

    notifyListeners();
    unawaited(_saveData());
  }
}
