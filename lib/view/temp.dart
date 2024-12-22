import 'package:adhiv_medical/util/custom_tf.dart';
import 'package:flutter/material.dart';

import '../util/decoration.dart';
import '../util/drop_down_input_tf.dart';
import '../util/fetch_and_add_product_tf.dart';
import '../util/my_button.dart';

class ProductEntryForm extends StatefulWidget {
  @override
  _ProductEntryFormState createState() => _ProductEntryFormState();
}

class _ProductEntryFormState extends State<ProductEntryForm> {
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _hsnCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _purchaseRateController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _reorderPointController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _mgfDateController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();

  Future<void> _selectDate(TextEditingController dateController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Entry',
          style: TextStyle(color: appBarTextStyle),
        ),
        backgroundColor: accentCanvasColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTextField("Product Code", _productCodeController),
                    const SizedBox(height: tFSpacing),
                    FetchAndAddListTF(
                        labelName: "Product Name",
                        controller: _productNameController),
                    const SizedBox(height: tFSpacing),
                    _buildTextField("HSN Code", _hsnCodeController),
                    const SizedBox(height: tFSpacing),
                    _buildTextField("Purchase Rate", _purchaseRateController),
                    const SizedBox(height: tFSpacing),
                    _buildTextField("Discount %", _discountController),
                    const SizedBox(height: tFSpacing),
                    _buildTextField("Reorder Point", _reorderPointController),
                    const SizedBox(height: tFSpacing),
                    _buildTextField("Description", _descriptionController,
                        maxLines: 5),
                    const SizedBox(height: tFSpacing),
                    FetchAndAddListTF(
                        labelName: "Manufacturer",
                        controller: _expDateController),
                    const SizedBox(height: tFSpacing),
                    Row(
                      children: [
                        Flexible(
                          child: _buildDropdownTextField(
                            "Category",
                            _descriptionController,
                            DropdownTextField(
                              items: const ['General'],
                              controller: _descriptionController,
                              height: 40,
                              width: 150,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                    const SizedBox(height: tFSpacing),
                    Row(
                      children: [
                        Flexible(
                          child: _buildDropdownTextField(
                              "Main Unit",
                              _descriptionController,
                              DropdownTextField(
                                items: const ["Strip", "Box"],
                                controller: _descriptionController,
                                height: 40,
                                width: 150,
                              )),
                        ),
                        const SizedBox(width: 50),
                        Flexible(
                          child: _buildDropdownTextField(
                            "Sale tax type",
                            _descriptionController,
                            DropdownTextField(
                              items: const ["Inclusive", "Exclusive"],
                              controller: _descriptionController,
                              height: 40,
                              width: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: tFSpacing),
                    Row(
                      children: [
                        Flexible(
                          child: _buildDropdownTextField(
                              "Alter Unit",
                              _descriptionController,
                              DropdownTextField(
                                items: const ["Strip", "Box"],
                                controller: _descriptionController,
                                height: 40,
                                width: 150,
                              )),
                        ),
                        const SizedBox(width: 50),
                        Flexible(
                          child: _buildDropdownTextField(
                            "Purchase tax type",
                            _descriptionController,
                            DropdownTextField(
                              items: const ["Inclusive", "Exclusive"],
                              controller: _descriptionController,
                              height: 40,
                              width: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: tFSpacing),
                    Row(
                      children: [
                        Flexible(
                          child: _buildTextField("Barcode", _barcodeController,
                              tfWidth: 150),
                        ),
                        const SizedBox(width: 50),
                        Flexible(
                          child: _buildDropdownTextField(
                              "Schedule of Drugs",
                              _descriptionController,
                              DropdownTextField(
                                items: const ["H1", "OTC"],
                                controller: _descriptionController,
                                height: 40,
                                width: 150,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: tFSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            width: 132,
                            margin: const EdgeInsets.only(right: 10),
                            child: _buildTextField("GST %", _gstController,
                                labelAndTFSpacingLocal: 60, tfWidth: 70),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 132,
                            margin: const EdgeInsets.only(right: 10),
                            child: _buildTextField("CGST %", _gstController,
                                labelAndTFSpacingLocal: 60, tfWidth: 70),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 132,
                            margin: const EdgeInsets.only(right: 10),
                            child: _buildTextField("IGST %", _gstController,
                                labelAndTFSpacingLocal: 60, tfWidth: 70),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 130,
                            child: _buildTextField("SGST %", _gstController,
                                labelAndTFSpacingLocal: 60, tfWidth: 70),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        // width: size.width * 0.5,
                        height: size.height * 0.25,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: _buildTextField(
                                    "Quantity :",
                                    _hsnCodeController,
                                    tfWidth: 150,
                                  ),
                                ),
                                // const SizedBox(height: tFSpacing),
                                Flexible(
                                  child: _buildTextField(
                                    "Batch No : ",
                                    _reorderPointController,
                                    tfWidth: double.maxFinite,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: tFSpacing),
                            Row(
                              children: [
                                Flexible(
                                  child: _buildTextField(
                                    "MRP : ",
                                    _purchaseRateController,
                                    tfWidth: 150,
                                  ),
                                ),
                                Flexible(
                                  child: _buildTextField(
                                    "Mfg Date : ",
                                    _mgfDateController,
                                    suffixIconBtn: IconButton(
                                        onPressed: () =>
                                            _selectDate(_mgfDateController),
                                        icon: const Icon(Icons.calendar_month)),
                                    tfWidth: double.maxFinite,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: tFSpacing),
                            Row(
                              children: [
                                Flexible(
                                  child: _buildTextField(
                                    "Sale Rate : ",
                                    _discountController,
                                    tfWidth: 150,
                                  ),
                                ),
                                const SizedBox(height: tFSpacing),
                                Flexible(
                                  child: _buildTextField(
                                    "Expiry Date : ",
                                    _expDateController,
                                    suffixIconBtn: IconButton(
                                        onPressed: () =>
                                            _selectDate(_expDateController),
                                        icon: const Icon(Icons.calendar_month)),
                                    tfWidth: double.maxFinite,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyButton(
                                  buttonName: "Remove",
                                  onPress: () {},
                                ),
                                const SizedBox(width: tFSpacing * 5),
                                MyButton(
                                  buttonName: "Add",
                                  onPress: () {},
                                ),
                                const SizedBox(width: tFSpacing * 2.8),
                              ],
                            ),
                            // const SizedBox(height: tFSpacing),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      margin: const EdgeInsets.only(top: 30, left: 10),
                      height: size.height * 0.6,
                      width: size.width,
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {}, child: const Text("New")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("Update")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("Delete")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("Get Data")),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: DataTable(
                              headingRowColor: MaterialStateProperty.all(
                                  Colors.blue.shade900),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              // dividerThickness: 1,
                              headingRowHeight: 40,
                              columnSpacing: 40,
                              columns: const [
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('MRP')),
                                DataColumn(label: Text('Sale Rate')),
                                DataColumn(label: Text('Batch No.')),
                                DataColumn(label: Text('Mfg Date')),
                                DataColumn(label: Text('Expiry Date')),
                              ],
                              rows: const [
                                DataRow(cells: [
                                  DataCell(Icon(Icons.play_arrow,
                                      color: Colors.blue)),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  // DataCell(Text('0')),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownTextField(String labelText,
      TextEditingController controller, DropdownTextField dropdownTextField,
      {double labelAndTFSpacingLocal = labelAndTFSpacing,
      double tfWidth = 300}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelAndTFSpacingLocal,
          child: Text(
            labelText,
            style: labelTS,
          ),
        ),
        Flexible(
          child: SizedBox(
            height: 30,
            child: dropdownTextField,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      {int maxLines = 1,
      double labelAndTFSpacingLocal = labelAndTFSpacing,
      double tfWidth = 300,
      IconButton? suffixIconBtn,
      void Function()? onTap}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelAndTFSpacingLocal,
          child: Text(
            labelText,
            style: labelTS,
          ),
        ),
        Flexible(
          child: SizedBox(
            height: 30,
            width: tfWidth,
            child: CustomTextField(
              controller: controller,
              suffixIcon: suffixIconBtn,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
