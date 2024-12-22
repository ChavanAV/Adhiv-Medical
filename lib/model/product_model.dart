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

class Product2 {
  // final int id;
  final String productCode;
  final String name;
  final String category;
  final String manufacturer;
  final String hsnCode;
  final String description;
  final double purchaseRate;
  final String mainUnit;
  final String alterUnit;
  final int conversionValue;
  final String saleTaxType;
  final String purchaseTaxType;
  final double discount;
  final int gst;
  final int barCode;

  final int quantity;
  final double mrp;
  final double saleRate;
  final String batchNumber;
  final String currentDate;
  final String manufactureDate;
  final String expiryDate;

  Product2({
    required this.productCode,
    required this.name,
    required this.category,
    required this.manufacturer,
    required this.hsnCode,
    required this.description,
    required this.purchaseRate,
    required this.mainUnit,
    required this.alterUnit,
    required this.conversionValue,
    required this.saleTaxType,
    required this.purchaseTaxType,
    required this.discount,
    required this.gst,
    required this.barCode,
    required this.quantity,
    required this.mrp,
    required this.saleRate,
    required this.batchNumber,
    required this.currentDate,
    required this.manufactureDate,
    required this.expiryDate,
  });
  Map<String, dynamic> toMap() {
    return {
      'productCode': productCode,
      'name': name,
      'category': category,
      'manufacturer': manufacturer,
      'hsnCode': hsnCode,
      'description': description,
      'purchaseRate': purchaseRate,
      'mainUnit': mainUnit,
      'alterUnit': alterUnit,
      'conversionValue': conversionValue,
      'saleTaxType': saleTaxType,
      'purchaseTaxType': purchaseTaxType,
      'discount': discount,
      'gst': gst,
      'barCode': barCode,
      'quantity': quantity,
      'mrp': mrp,
      'saleRate': saleRate,
      'batchNumber': batchNumber,
      'currentDate': currentDate,
      'manufactureDate': manufactureDate,
      'expiryDate': expiryDate,
    };
  }
}
