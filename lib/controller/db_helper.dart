import 'dart:io' as io;
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../model/product_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    sqfliteFfiInit();
    final dbFactory = databaseFactoryFfi;

    // Get the path to the Documents directory
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentsDirectory.path, 'adhiv_medical.db');

    // Open the database at the specified path
    final db = await dbFactory.openDatabase(dbPath);

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Product(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      date TEXT,
      rate INTEGER,
      stock INTEGER,
      currentStock INTEGER,
      outStock INTEGER
    )
  ''');
    return db;
  }

  // Insert product into the database
  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert('Product', product.toMap());
  }

  // Fetch all products from the database
  Future<List<Product>> getListOfProducts(myAllDataQuery) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await myAllDataQuery;
    return List.generate(maps.length, (index) {
      return Product(
        name: maps[index]['name'],
        date: maps[index]['date'],
        rate: maps[index]['rate'],
        stock: maps[index]['stock'],
        currentStock: maps[index]['currentStock'],
        outStock: maps[index]['outStock'],
      );
    });
  }

  Future<void> updateForReceipt(String name, int curStk, int outStk) async {
    final db = await database;
    await db.update('Product', {'currentStock': curStk, 'outStock': outStk},
        where: "name = '$name'");
  }

  Future<List<Map<String, dynamic>>> getForReceipt(String name) async {
    final db = await database;
    return await db.query('Product', where: "name = '$name'");
  }

  Future<List<Map<String, dynamic>>> myQuery() async {
    final db = await database;
    return await db.query('Product', where: "name = 'Dolo'");
  }

  Product mapToProduct(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      date: map['date'],
      rate: map['rate'],
      stock: map['stock'],
      currentStock: map['currentStock'],
      outStock: map['outStock'],
    );
  }

  Future<List<Product>> fetchAllProduct() async {
    final db = await database;
    final List<Map<String, dynamic>> listOfMaps = await db.query('Product');
    return List<Product>.from(listOfMaps.map((map) => mapToProduct(map)));
  }

  Future<List<Map<String, dynamic>>> fetchAllData() async {
    final db = await database;
    return await db.query('Product');
  }

  Future<List<String>> fetchName() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT name FROM product');
    return result.map((map) => map['name'] as String).toList();
  }

  Future<void> deleteDataBase() async {
    final db = await database;
    await db.delete('Product');
  }
  ////////////////////////////////////////////////////////////////////////

  /// below is old code not used further

  Future<void> initDatabase() async {
    late Database empDb;
    // var databaseFactory = databaseFactoryFfi;
    late io.Directory appDocumentsDir;

    if (io.Platform.isWindows) {
      appDocumentsDir = io.Directory.current;
    } else {
      appDocumentsDir = await io.Directory.systemTemp;
    }

    String dbPath = path.join(appDocumentsDir.path, "databases", "empDb.db");
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
    // return empDb;
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
      [/*'ID',*/ 'Name', 'rate', 'stock', 'currentStock', 'outStock', 'Date'],
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
