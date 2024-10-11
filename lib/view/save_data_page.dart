import 'package:adhiv_medical/controller/save_data.dart';
import 'package:adhiv_medical/util/custom_tf.dart';
import 'package:flutter/material.dart';

import '../controller/db_helper.dart';
import '../util/confirmation_dialog.dart';
import '../util/decoration.dart';
import '../util/fetch_and_add_product_tf.dart';

class SaveDataPage extends StatefulWidget {
  const SaveDataPage({super.key});

  @override
  _SaveDataPageState createState() => _SaveDataPageState();
}

class _SaveDataPageState extends State<SaveDataPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final DBHelper databaseHelper = DBHelper();
  final SaveData saveData = SaveData();

  @override
  void initState() {
    super.initState();
    databaseHelper.initDb();
  }

  Future<void> _showConfirmationDialog() async {
    showAlertDialog(
      context,
      () => _saveProduct(),
      () => Navigator.pop(context),
    );
  }

  Future<void> _saveProduct() async {
    final int res = await saveData.addProduct(
      nameController,
      rateController,
      stockController,
      databaseHelper,
      context,
    );
    if (mounted) {
      final message = res != 0
          ? 'Data saved to the database'
          : 'Data not saved to the database';
      _showSnackBar(message);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void _showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receipt Page',
          style: TextStyle(color: appBarTextStyle),
        ),
        backgroundColor: accentCanvasColor,
      ),
      body: Center(
        child: Container(
          width: 600,
          height: 400,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FetchAndAddProductNameTF(controller: nameController),
              const SizedBox(height: 30),
              _buildCustomTextField(rateController, "Rate"),
              const SizedBox(height: 30),
              _buildCustomTextField(stockController, "Stock"),
              const SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(
      TextEditingController controller, String labelText) {
    return CustomTextField(
      controller: controller,
      labelText: labelText,
      hintText: labelText,
    );
  }

  Widget _buildSaveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: _showConfirmationDialog,
          borderRadius: BorderRadius.circular(10.0),
          splashColor: Colors.blueAccent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                colors: [primaryColor, primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
