import 'package:adhiv_medical/db_helper.dart';
import 'package:flutter/material.dart';

import 'attribute.dart';

class ProductListPage extends StatefulWidget {
  List<Product> productList;

  ProductListPage({Key? key, required this.productList}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  DBHelper dbHelper = DBHelper();

  Future<void> generatePDF() async {
    await dbHelper.exportToPDFAndCSV('generated_data', widget.productList);
    // print('PDF generated successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          TextButton(
              onPressed: () async {
                widget.productList =
                    await dbHelper.getListOfProducts(dbHelper.myQuery());
                setState(() {});
              },
              child: const Text("Apply Filter")),
          TextButton(
              onPressed: () async {
                widget.productList =
                    await dbHelper.getListOfProducts(dbHelper.myAllDataQuery());
                setState(() {});
              },
              child: const Text("Clear Filter")),
          TextButton(
              onPressed: () {
                generatePDF();
              },
              child: const Text("generate file")),
          TextButton(
              onPressed: () {
                dbHelper.deleteDataBase();
              },
              child: const Text("Delete"))
        ],
      ),
      body: ListView.builder(
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                // 'ID: ${widget.productList[index].id}, '
                'Name: ${widget.productList[index].name}, '
                'Rate: ${widget.productList[index].rate}, '
                'Stock: ${widget.productList[index].stock}, '
                'CurrentStock: ${widget.productList[index].currentStock}, '
                'OutStock: ${widget.productList[index].outStock}, '
                'Date: ${widget.productList[index].date}, '),
          );
        },
      ),
    );
  }
}
