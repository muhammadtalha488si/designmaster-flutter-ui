
import '../models/product_model.dart';

class ProductData {
  static const List<ProductModel> products = [
    ProductModel(
      id: 'p001',
      name: 'Wireless Headphones',
      category: 'Electronics',
      description:
          'Enjoy clear sound, comfortable ear cushions and wireless connectivity with these modern headphones.',
      imagePath: 'assets/images/products/headphones.jpg',
      price: 4500,
      rating: 4.8,
      isFeatured: true,
    ),

    ProductModel(
      id: 'p002',
      name: 'Smart Watch',
      category: 'Electronics',
      description:
          'A stylish smartwatch with a modern display and useful everyday features.',
      imagePath: 'assets/images/products/smartwatch.jpg',
      price: 6500,
      rating: 4.6,
      isFeatured: true,
    ),

    ProductModel(
      id: 'p003',
      name: 'Running Sneakers',
      category: 'Fashion',
      description:
          'Comfortable sneakers designed for everyday activities and casual wear.',
      imagePath: 'assets/images/products/shoes.jpg',
      price: 5200,
      rating: 4.7,
      isFeatured: true,
    ),

    ProductModel(
      id: 'p004',
      name: 'Travel Backpack',
      category: 'Accessories',
      description:
          'A practical backpack with a spacious design for travel, work and everyday use.',
      imagePath: 'assets/images/products/backpack.jpg',
      price: 3200,
      rating: 4.5,
    ),

    ProductModel(
      id: 'p005',
      name: 'Smartphone',
      category: 'Electronics',
      description:
          'A modern smartphone designed for communication, entertainment and daily productivity.',
      imagePath: 'assets/images/products/smartphone.jpg',
      price: 45000,
      rating: 4.9,
      isFeatured: true,
    ),

    ProductModel(
      id: 'p006',
      name: 'Digital Camera',
      category: 'Electronics',
      description:
          'Capture memorable moments with this digital camera for photography enthusiasts.',
      imagePath: 'assets/images/products/camera.jpg',
      price: 28000,
      rating: 4.7,
    ),
  ];

  static List<ProductModel> get featuredProducts {
    return products.where((product) => product.isFeatured).toList();
  }

  static List<String> get categories {
    return products
        .map((product) => product.category)
        .toSet()
        .toList();
  }

  static List<ProductModel> getProductsByCategory(String category) {
    return products
        .where((product) => product.category == category)
        .toList();
  }

  static ProductModel? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<ProductModel> searchProducts(String query) {
    if (query.trim().isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
