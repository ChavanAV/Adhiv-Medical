class Product {
  // final int id;
  final String name;
  final String date;
  final int rate;
  final int stock;
  final int currentStock;
  final int outStock;

  Product(
      {
      // required this.id,
      required this.name,
      required this.date,
      required this.rate,
      required this.stock,
      required this.currentStock,
      required this.outStock});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'date': date,
      'rate': rate,
      'stock': stock,
      'currentStock': currentStock,
      'outStock': outStock
    };
  }
}
