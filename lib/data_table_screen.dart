import 'package:adhiv_medical/attribute.dart';
import 'package:adhiv_medical/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  DBHelper dbHelper = DBHelper();
  late Database empDb;
  late Future<List<Map<String, dynamic>>> productListQuery;

  @override
  void initState() {
    productListQuery = dbHelper.myAllDataQuery();
    super.initState();
  }

  Future<void> generatePDF() async {
    List<Product> p = await dbHelper.getListOfProducts(productListQuery);
    await dbHelper.exportToPDFAndCSV('generated_data', p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  productListQuery = dbHelper.myQuery();
                });
              },
              child: const Text("Apply Filter")),
          TextButton(
              onPressed: () {
                setState(() {
                  productListQuery = dbHelper.myAllDataQuery();
                });
              },
              child: const Text("Clear Filter")),
          TextButton(
              onPressed: () {
                generatePDF();
              },
              child: const Text("generate file")),
          TextButton(
              onPressed: () {
                setState(() {
                  dbHelper.deleteDataBase();
                  productListQuery = dbHelper.myAllDataQuery();
                });
              },
              child: const Text("Delete"))
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: productListQuery,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available.');
            } else {
              List<Map<String, dynamic>> data = snapshot.data!;
              return SingleChildScrollView(
                child: DataTable(
                  columns: data[0].keys.map<DataColumn>((String key) {
                    return DataColumn(label: Text(key));
                  }).toList(),
                  rows: data.map<DataRow>((Map<String, dynamic> row) {
                    return DataRow(
                      cells: row.keys.map<DataCell>((String key) {
                        return DataCell(Text('${row[key]}'));
                      }).toList(),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
