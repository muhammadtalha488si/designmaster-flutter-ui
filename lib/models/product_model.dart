
class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imagePath;
  final double price;
  final double rating;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.rating,
    this.isFeatured = false,
  });
}
