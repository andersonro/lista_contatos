import 'package:sqflite/sqflite.dart';

class DB {
  // Constrrutor privado
  DB._();

  // Criar instancia do banco de dados
  static final DB instance = DB._();

  //Instancia do SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    return await openDatabase('db_contatos', version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(_contatos);
    db.close();
  }

  String get _contatos => '''
      CREATE TABLE contatos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        telefone INTEGER,
        email TEXT,
        urlFoto TEXT,
        isExpended INTEGER
      )
    ''';
}
