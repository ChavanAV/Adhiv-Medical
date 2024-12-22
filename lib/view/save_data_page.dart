import 'package:adhiv_medical/controller/save_data.dart';
import 'package:adhiv_medical/util/custom_tf.dart';
import 'package:adhiv_medical/util/date_selector.dart';
import 'package:adhiv_medical/util/drop_down_input_tf.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
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
      // () => saveData.save1000Product(),
      () => _saveProduct(),
      () => Navigator.pop(context),
    );
  }

  Future<void> _saveProduct() async {
    final int res = await saveData.addProduct(
      _nameController,
      _rateController,
      _stockController,
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
      body: Container(
        // width: 600,
        // height: 400,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _rateController,
                  labelText: 'Product Code',
                  height: 40,
                  width: 200,
                ),
                // const SizedBox(height: 30),
                Flexible(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: FetchAndAddListTF(
                        labelName: "Product Name", controller: _nameController),
                  ),
                ),
                // const SizedBox(height: 30),
                DropdownTextField(
                  items: const ['Generale'],
                  labelText: "Category",
                  controller: _rateController,
                  height: 40,
                  width: 150,
                ),

                CustomTextField(
                  controller: _rateController,
                  labelText: 'HSN Code',
                  height: 40,
                  width: 200,
                ),
                CustomTextField(
                  controller: _rateController,
                  labelText: 'Purchase Rate',
                  height: 40,
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownTextField(
                  items: const ['Tab', 'Strip', 'PCS'],
                  labelText: "Main Unit",
                  controller: _rateController,
                  height: 40,
                  width: 150,
                ),
                DropdownTextField(
                  items: const ['Tab', 'Strip', 'PCS'],
                  labelText: "Alter Unit",
                  controller: _rateController,
                  height: 40,
                  width: 150,
                ),
                // const SizedBox(height: 30),
                CustomTextField(
                  controller: _stockController,
                  labelText: 'Conversion Value',
                  height: 40,
                  width: 100,
                ),
                CustomTextField(
                  controller: _stockController,
                  labelText: 'Stock',
                  height: 40,
                  width: 100,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _batchController,
                  labelText: 'Batch No.',
                  height: 40,
                  width: 200,
                ),
              ],
            ),
            const SizedBox(height: 30),
            DateSelector(dateController: _dateController),
            const SizedBox(height: 30),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }
  //
  // Widget _buildCustomTextField({required TextEditingController controller,
  //     required String labelText, double? height, double? width}) {
  //   return CustomTextField(
  //     controller: controller,
  //     labelText: labelText,
  //     height: height,
  //     width: width,
  //   );
  // }

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
