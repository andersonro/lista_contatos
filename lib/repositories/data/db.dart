import 'package:lista_contatos/model/contato_model.dart';
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

  _onCreate(Database db, int version) async {
    await db.execute(_contatos);
    db.close();
  }

  String get _contatos => '''
      CREATE TABLE contatos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        telefone INTEGER,
        email TEXT,
        urlFoto TEXT
      )
    ''';

  Future addContato(ContatoModel contato) async {
    final db = await instance.database;
    return await db.insert('contatos', contato.toJson());
  }

  Future editContato(ContatoModel contato) async {
    final db = await instance.database;
    return await db.update(
      'contatos',
      contato.toJson(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future deleteContato(int id) async {
    final db = await instance.database;
    return await db.delete('contatos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ContatoModel>> getContatos() async {
    final db = await instance.database;
    List<Map<String, dynamic>> contatos = await db.query('contatos');
    return contatos.map((e) => ContatoModel.fromJson(e)).toList();
  }
}
