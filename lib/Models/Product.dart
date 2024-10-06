class Product {
  final int id;
  final String title;
  final String description;
  final double originalPrice;
  final double discountPercentage;
  final String thumbnail;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.originalPrice,
      required this.discountPercentage,
      required this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        originalPrice: (json['price'] as num).toDouble(),
        discountPercentage: (json['discountPercentage'] as num).toDouble());
  }
  double get discountedPrice =>
      originalPrice - (originalPrice * (discountPercentage / 100));
}
