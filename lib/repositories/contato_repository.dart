import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/repositories/data/db.dart';
import 'package:sqflite/sqflite.dart';

class ContatoRepository {
  late Database db;

  Future addContato(ContatoModel contato) async {
    db = await DB.instance.database;
    var save = await db.insert('contatos', contato.toJson());
    return save;
  }

  Future editContato(ContatoModel contato) async {
    db = await DB.instance.database;
    var save = await db.update(
      'contatos',
      contato.toJson(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
    return save;
  }

  Future deleteContato(int id) async {
    db = await DB.instance.database;
    var delete = await db.delete('contatos', where: 'id = ?', whereArgs: [id]);
    return delete;
  }

  Future<List<ContatoModel>> getContatos() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> contatos = await db.query('contatos');
    return contatos.map((e) => ContatoModel.fromJson(e)).toList();
  }
}
