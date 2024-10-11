// import 'package:adhiv_medical/controller/db_helper.dart';
// import 'package:adhiv_medical/model/product_model.dart';
// import 'package:adhiv_medical/util/decoration.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
// class ShowTableData extends StatefulWidget {
//   const ShowTableData({super.key});
//
//   @override
//   State<ShowTableData> createState() => _ShowTableDataState();
// }
//
// class _ShowTableDataState extends State<ShowTableData> {
//   DBHelper dbHelper = DBHelper();
//   late Database empDb;
//   late Future<List<Map<String, dynamic>>> productListQuery;
//
//   @override
//   void initState() {
//     productListQuery = dbHelper.fetchAllData();
//     super.initState();
//   }
//
//   Future<void> generatePDF() async {
//     List<Product> p = await dbHelper.getListOfProducts(productListQuery);
//     await dbHelper.exportToPDFAndCSV('generated_data', p);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Product List',
//             style: TextStyle(color: appBarTextStyle),
//           ),
//           backgroundColor: accentCanvasColor,
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   setState(() {
//                     productListQuery = dbHelper.myQuery();
//                   });
//                 },
//                 child: Text(
//                   "Apply Filter",
//                   style: TextStyle(color: appBarTextStyle),
//                 )),
//             TextButton(
//                 onPressed: () {
//                   setState(() {
//                     productListQuery = dbHelper.fetchAllData();
//                   });
//                 },
//                 child: Text(
//                   "Clear Filter",
//                   style: TextStyle(color: appBarTextStyle),
//                 )),
//             TextButton(
//                 onPressed: () {
//                   generatePDF();
//                 },
//                 child: Text(
//                   "generate file",
//                   style: TextStyle(color: appBarTextStyle),
//                 )),
//             TextButton(
//                 onPressed: () {
//                   setState(() {
//                     dbHelper.deleteDataBase();
//                     productListQuery = dbHelper.fetchAllData();
//                   });
//                 },
//                 child: Text(
//                   "Delete",
//                   style: TextStyle(color: appBarTextStyle),
//                 ))
//           ],
//         ),
//         body: Align(
//           alignment: Alignment.topCenter,
//           child: FutureBuilder<List<Product>>(
//               future: dbHelper.fetchAllProduct(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.data!.isEmpty) {
//                   return const Center(child: Text('No products found.'));
//                 } else if (snapshot.hasError) {
//                   return const Center(child: Text('Something went wrong!!!'));
//                 } else {
//                   final List<Product> products = snapshot.data!;
//                   return SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: DataTable(
//                       showBottomBorder: true,
//                       showCheckboxColumn: true,
//                       clipBehavior: Clip.antiAlias,
//                       sortAscending: true,
//                       columns: const [
//                         DataColumn(label: Text('Name')),
//                         DataColumn(label: Text('Date')),
//                         DataColumn(label: Text('Rate')),
//                         DataColumn(label: Text('Stock')),
//                         DataColumn(label: Text('Current Stock')),
//                         DataColumn(label: Text('Out Stock')),
//                       ],
//                       rows: products.map((product) {
//                         return DataRow(cells: [
//                           DataCell(Text(product.name)),
//                           DataCell(Text(product.date)),
//                           DataCell(Text('${product.rate}')),
//                           DataCell(Text('${product.stock}')),
//                           DataCell(Text('${product.currentStock}')),
//                           DataCell(Text('${product.outStock}')),
//                         ]);
//                       }).toList(),
//                     ),
//                   );
//                 }
//               }),
//         )
//         // body: Align(
//         //   alignment: Alignment.topCenter,
//         //   child: FutureBuilder<List<Map<String, dynamic>>>(
//         //     future: dbHelper.fetchAllData(),
//         //     builder: (context, snapshot) {
//         //       if (snapshot.connectionState == ConnectionState.waiting) {
//         //         return const CircularProgressIndicator();
//         //       } else if (snapshot.hasError) {
//         //         return Text('Error: ${snapshot.error}');
//         //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         //         return const Text('No data available.');
//         //       } else {
//         //         List<Map<String, dynamic>> data = snapshot.data!;
//         //         return SingleChildScrollView(
//         //           child: DataTable(
//         //             columns: data[0].keys.map<DataColumn>((String key) {
//         //               return DataColumn(
//         //                   label: Text(
//         //                 key,
//         //                 style: dataTextStyle,
//         //               ));
//         //             }).toList(),
//         //             rows: data.map<DataRow>((Map<String, dynamic> row) {
//         //               return DataRow(
//         //                 cells: row.keys.map<DataCell>((String key) {
//         //                   return DataCell(Text(
//         //                     '${row[key]}',
//         //                     style: dataTextStyle,
//         //                   ));
//         //                 }).toList(),
//         //               );
//         //             }).toList(),
//         //           ),
//         //         );
//         //       }
//         //     },
//         //   ),
//         // ),
//         );
//   }
// }

import 'package:adhiv_medical/controller/db_helper.dart';
import 'package:adhiv_medical/model/product_model.dart';
import 'package:adhiv_medical/util/decoration.dart';
import 'package:flutter/material.dart';

class ShowTableData extends StatefulWidget {
  const ShowTableData({super.key});

  @override
  State<ShowTableData> createState() => _ShowTableDataState();
}

class _ShowTableDataState extends State<ShowTableData> {
  DBHelper dbHelper = DBHelper();
  late Future<List<Product>> productListFuture;

  @override
  void initState() {
    super.initState();
    productListFuture = dbHelper.fetchAllProduct(); // Load products initially
  }

  Future<void> generatePDF() async {
    List<Product> products = await dbHelper.fetchAllProduct();
    await dbHelper.exportToPDFAndCSV('generated_data', products);
  }

  void refreshData() {
    setState(() {
      productListFuture = dbHelper.fetchAllProduct(); // Refresh data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: TextStyle(color: appBarTextStyle),
        ),
        backgroundColor: accentCanvasColor,
        actions: [
          TextButton(
              onPressed: () {
                // Apply filter logic here
                refreshData();
              },
              child: Text("Apply Filter",
                  style: TextStyle(color: appBarTextStyle))),
          TextButton(
              onPressed: () {
                refreshData();
              },
              child: Text("Clear Filter",
                  style: TextStyle(color: appBarTextStyle))),
          TextButton(
              onPressed: () {
                generatePDF();
              },
              child: Text("Generate File",
                  style: TextStyle(color: appBarTextStyle))),
          TextButton(
              onPressed: () {
                dbHelper.deleteDataBase();
                refreshData();
              },
              child: Text("Delete", style: TextStyle(color: appBarTextStyle))),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: productListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            final List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle:
                      Text('Date: ${product.date}\nRate: ${product.rate}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Stock: ${product.stock}'),
                      Text('Current Stock: ${product.currentStock}'),
                      Text('Out Stock: ${product.outStock}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
