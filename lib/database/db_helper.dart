import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_connect_db/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper db = DBHelper._();
  static Database _db;

  initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "backup.db");

    final exist = await databaseExists(path);

    if (exist) {
      // database already exists
      // open database
      print("db already exists at path: $dbPath");
    } else {
      // db does not exist create a new one
      print("creating a copy from assets");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
      await rootBundle.load(join("assets/database", "backup.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      print("db copied at path: $dbPath");
    }
    // open the database
    _db = await openDatabase(path, readOnly: true);
  }


  Future<List<Products>> getAllProducts() async {
    await initDb();
    var response = await _db.query("Products");
    List<Products> list = response.map((c) => Products.fromMap(c)).toList();
    return list;
  }
}
