import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    await _insertInitialUser(); // Insertar usuario inicial al crear la base de datos
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'postwave.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Crear la tabla de usuarios
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<void> _insertInitialUser() async {
    final Database db = await database;
    await db.insert(
      'users',
      {'username': 'ejemplo', 'password': 'contraseña123'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Métodos adicionales para manejar operaciones CRUD...
}
