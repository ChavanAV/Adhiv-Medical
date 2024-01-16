import 'package:flutter/material.dart';

import 'attribute.dart';
import 'db_helper.dart';

class MkReceiptPage extends StatefulWidget {
  const MkReceiptPage({
    super.key,
  });

  @override
  State<MkReceiptPage> createState() => _MkReceiptPageState();
}

class _MkReceiptPageState extends State<MkReceiptPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final DBHelper databaseHelper = DBHelper();

  void _update() async {
    String name = nameController.text;
    List<Product> p = await databaseHelper
        .getListOfProducts(databaseHelper.getForReceipt(name));
    int curStk = (p[0].currentStock) - int.parse(quantityController.text);
    int outStk = (p[0].outStock) + int.parse(quantityController.text);
    await databaseHelper.updateForReceipt(name, curStk, outStk);
    nameController.clear();
    quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _update,
              child: const Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
