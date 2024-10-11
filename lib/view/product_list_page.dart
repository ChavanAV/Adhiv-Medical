import 'package:adhiv_medical/controller/db_helper.dart';
import 'package:flutter/material.dart';

import '../controller/controller.dart';
import '../model/product_model.dart';
import '../util/decoration.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  DBHelper databaseHelper = DBHelper();
  final Controller con = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Data Page',
          style: TextStyle(color: appBarTextStyle),
        ),
        backgroundColor: accentCanvasColor,
      ),
      body: FutureBuilder<List<Product>>(
        future: con.fetchProductList(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<Product> productList = snapshot.data!;
            // return ProductListPage(productList: productList);
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      style: dataTextStyle,
                      // 'ID: ${widget.productList[index].id}, '
                      'Name: ${productList[index].name}, '
                      'Rate: ${productList[index].rate}, '
                      'Stock: ${productList[index].stock}, '
                      'CurrentStock: ${productList[index].currentStock}, '
                      'OutStock: ${productList[index].outStock}, '
                      'Date: ${productList[index].date}, '),
                );
              },
            );
          } else {
            return const Center(child: Text('No products found.'));
          }
        },
      ),
    );
  }
}

// Future<void> generatePDF() async {
//   await databaseHelper.exportToPDFAndCSV(
//       'generated_data', productList);
//   // print('PDF generated successfully.');
// }

// appBar: AppBar(
//   title: const Text('Product List'),
//   actions: [
//     TextButton(
//         onPressed: () async {
//           widget.productList = await databaseHelper
//               .getListOfProducts(databaseHelper.myQuery());
//           setState(() {});
//         },
//         child: const Text("Apply Filter")),
//     TextButton(
//         onPressed: () async {
//           widget.productList = await databaseHelper
//               .getListOfProducts(databaseHelper.myAllDataQuery());
//           setState(() {});
//         },
//         child: const Text("Clear Filter")),
//     TextButton(
//         onPressed: () {
//           generatePDF();
//         },
//         child: const Text("generate file")),
//     TextButton(
//         onPressed: () {
//           databaseHelper.deleteDataBase();
//         },
//         child: const Text("Delete"))
//   ],
// ),
