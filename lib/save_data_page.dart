import 'package:adhiv_medical/mk_reciept_page.dart';
import 'package:adhiv_medical/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'attribute.dart';
import 'db_helper.dart';

class SaveDataPage extends StatefulWidget {
  const SaveDataPage({super.key});

  @override
  _SaveDataPageState createState() => _SaveDataPageState();
}

class _SaveDataPageState extends State<SaveDataPage> {
  // final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final DBHelper databaseHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    databaseHelper.initDatabase();
  }

  void _mkReceipt() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MkReceiptPage(),
        ));
  }

  void _saveData() async {
    // final int id = int.tryParse(idController.text) ?? 0;
    final String name = nameController.text;
    int rate = int.tryParse(rateController.text) ?? 0;
    int stock = int.tryParse(stockController.text) ?? 0;
    DateTime currentDate = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(currentDate);

    final Product product = Product(
      // id: id,
      name: name,
      date: date,
      rate: rate,
      stock: stock,
      currentStock: stock,
      outStock: 0,
    );

    await databaseHelper.insertProduct(product);

    // idController.clear();
    nameController.clear();
    rateController.clear();
    stockController.clear();

    snackBar();
  }

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved to the database')),
    );
  }

  void _navigateToProductListPage() async {
    final List<Product> productList =
        await databaseHelper.getListOfProducts(databaseHelper.myAllDataQuery());
    nav(productList);
  }

  void nav(List<Product> productList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListPage(productList: productList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database Example'), actions: [
        TextButton(
          onPressed: _navigateToProductListPage,
          child: const Text('View Stock'),
        ),
        TextButton(onPressed: _mkReceipt, child: const Text("Make Receipt")),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: idController,
            //   decoration: const InputDecoration(labelText: 'ID'),
            //   keyboardType: TextInputType.number,
            // ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: rateController,
              decoration: const InputDecoration(labelText: 'Rate'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
