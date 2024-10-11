import '../model/product_model.dart'; // Assuming Product class is here
import 'db_helper.dart'; // DBHelper should contain the necessary methods

class Controller {
  final DBHelper databaseHelper = DBHelper();

  Future<List<Product>> fetchProductList() async {
    return await databaseHelper
        .getListOfProducts(databaseHelper.fetchAllData());
  }
}
