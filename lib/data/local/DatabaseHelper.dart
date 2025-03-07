import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Database? database;
  static const _databaseName = "local_betting.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final winDB = await databaseFactory.openDatabase(
      ("${appDocumentsDir.path}betting_data.db"),
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
    return winDB;
  }

  Future<Database> get getDatabase async {
    if(database!= null) return database!;
    database = await _initDatabase();
    return database!;
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute('CREATE TABLE auth (id INTEGER PRIMARY KEY, token TEXT, usertype TEXT)');
    await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY, token TEXT, role TEXT, userId TEXT)');
  }

  Future<int> insertUser(Map<String, dynamic> raw) async {
    Database db = await instance.getDatabase;
    return await db.insert('users', raw);
  }

  Future<int> saveAuth(Map<String, dynamic> raw) async {
    Database db = await instance.getDatabase;
    return await db.insert('users', raw);
  }

  Future<int> deleteAuth() async {
    Database db = await instance.getDatabase;
    return await db.delete('users');
  }

  Future<List<Map<String, Object?>>> get getUser async {
    Database db = await instance.getDatabase;
    return await db.query('users');
  }
}