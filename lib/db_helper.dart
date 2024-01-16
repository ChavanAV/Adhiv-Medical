import 'dart:io' as io;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'attribute.dart';

class DBHelper {
  Future<List<Map<String, dynamic>>> myFun() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    late io.Directory appDocumentsDir;

    if (io.Platform.isWindows) {
      appDocumentsDir = io.Directory.current;
    } else {
      appDocumentsDir = await io.Directory.systemTemp;
    }

    String dbPath = p.join(appDocumentsDir.path, "databases", "myDb.db");
    var db = await databaseFactory.openDatabase(dbPath);

    try {
      var tables = await db.query("sqlite_master",
          where: "type = 'table' AND name = 'Product'");
      if (tables.isEmpty) {
        await db.execute('''
      CREATE TABLE Product (
        id INTEGER PRIMARY KEY,
        title TEXT
      )
    ''');
      }

      await db.insert('Product', <String, Object?>{'title': 'A 1'});
      await db.insert('Product', <String, Object?>{'title': 'B 2'});

      var result = await db.query('Product');
      return result;
    } catch (e) {
      print("Error:==> $e");
      throw e; // Re-throwing the error to indicate a failure
    } finally {
      await db.close();
    }
  }

  late Database empDb;

  Future<void> initDatabase() async {
    var databaseFactory = databaseFactoryFfi;
    late io.Directory appDocumentsDir;

    if (io.Platform.isWindows) {
      appDocumentsDir = io.Directory.current;
    } else {
      appDocumentsDir = await io.Directory.systemTemp;
    }

    String dbPath = p.join(appDocumentsDir.path, "databases", "empDb.db");
    empDb = await databaseFactory.openDatabase(dbPath);

    // await empDb.execute('DROP TABLE IF EXISTS emp');

    var tables = await empDb.query("sqlite_master",
        where: "type = 'table' AND name = 'emp'");
    if (tables.isEmpty) {
      await empDb.execute('''
        CREATE TABLE emp (
          // id INTEGER PRIMARY KEY,
          name TEXT,
          date TEXT,
          rate INTEGER,
          stock INTEGER,
          currentStock INTEGER,
          outStock INTEGER
        )
      ''');
    }
  }

  Future<void> insertProduct(Product product) async {
    await empDb.insert('emp', product.toMap());
    // await empDb.insert('emp', <String, Object?>{
    //       'id': product.id,
    //       'name': product.name,
    //       'date': product.date
    //     });
  }

  Future<void> updateForReceipt(String name, int curStk, int outStk) async {
    await initDatabase();
    await empDb.update('emp', {'currentStock': curStk, 'outStock': outStk},
        where: "name = '$name'");
  }

  Future<List<Map<String, dynamic>>> getForReceipt(String name) async {
    await initDatabase();
    return await empDb.query('emp', where: "name = '$name'");
  }

  Future<List<Map<String, dynamic>>> myQuery() async {
    await initDatabase();
    return await empDb.query('emp', where: "name = 'C'");
  }

  Future<List<Map<String, dynamic>>> myAllDataQuery() async {
    await initDatabase();
    return await empDb.query('emp');
  }

  Future<List<Product>> getListOfProducts(
      Future<List<Map<String, dynamic>>> myQuery1) async {
    final List<Map<String, dynamic>> maps = await myQuery1;
    return List.generate(maps.length, (index) {
      return Product(
        // id: maps[index]['id'],
        name: maps[index]['name'],
        date: maps[index]['date'],
        rate: maps[index]['rate'],
        stock: maps[index]['stock'],
        currentStock: maps[index]['currentStock'],
        outStock: maps[index]['outStock'],
      );
    });
  }

  Future<void> deleteDataBase() async {
    await initDatabase();
    await empDb.delete('emp');
  }

  Future<void> exportToPDFAndCSV(String filePath, product) async {
    // Retrieve data from the 'emp' table (replace with your actual table)
    await initDatabase();
    List<Product> data = await product;
    // await empDb.query('emp', where: "'id' = 10");

    // Load a Google Font
    // final ttfFont = await GoogleFonts.nunitoSans();

    // Export to PDF
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        // theme: pw.ThemeData.withFont(bold: pw.Font()),
        build: (context) {
          DateTime a;
          String s;
          return pw.TableHelper.fromTextArray(
            context: context,
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey600,
            ),
            cellHeight: 30,
            headerHeight: 40,
            data: [
              [
                // 'ID',
                'Name',
                'rate',
                'stock',
                'currentStock',
                'outStock',
                'Date',
              ],
              for (var row in data)
                [
                  // row.id.toString(),
                  row.name.toString(),
                  row.rate.toString(),
                  row.stock.toString(),
                  row.currentStock.toString(),
                  row.outStock.toString(),
                  row.date.toString(),
                  //row['id'].toString(),
                  //row['name'].toString(),
                  //row['date'].toString()
                ],
            ],
          );
        },
      ),
    );

    final pdfFile = File('$filePath.pdf');
    await pdfFile.writeAsBytes(await pdf.save());

    // Export to CSV
    final csvFile = File('$filePath.csv');
    String csvData = const ListToCsvConverter().convert([
      [/*'ID',*/ 'Name', 'rate', 'stock', 'currentStock', 'outStock' 'Date'],
      for (var row in data)
        [
          // row.id.toString(),
          row.name.toString(),
          row.rate.toString(),
          row.stock.toString(),
          row.currentStock.toString(),
          row.outStock.toString(),
          row.date.toString(),
        ],
    ]);
    await csvFile.writeAsString(csvData);
  }
}
