import 'dart:io' as io;

import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PdfDBHelper {
  late Database pdfDb;
  Future<void> initializePdfDb() async {
    var databaseFactory = databaseFactoryFfi;
    late io.Directory appDocumentDir;
    if (io.Platform.isWindows) {
      appDocumentDir = io.Directory.current;
    } else {
      appDocumentDir = await io.Directory.systemTemp;
    }
    String dbPath = path.join(appDocumentDir.path, "databases", "pdfDb.db");
    pdfDb = await databaseFactory.openDatabase(dbPath);

    try {
      var table = await pdfDb.query("sqlite_master",
          where: "type = 'table' AND name = 'pdf'");
      if (table.isEmpty) {
        await pdfDb.execute('''
          CREATE TABLE pdf(
          path TEXT
          )
        ''');
      }
    } catch (e) {}
  }

  Future<void> insertPdf(String filePath) async {
    await pdfDb.insert('pdf', {'path': filePath});
  }
}
