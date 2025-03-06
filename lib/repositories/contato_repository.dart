import 'package:flutter/widgets.dart';
import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/repositories/data/db.dart';
import 'package:sqflite/sqflite.dart';

class ContatoRepository {
  late Database db;

  ContatoRepository() {
    DB.instance.database.then((value) => db = value);
  }

  Future addContato(ContatoModel contato) async {
    final db = await DB.instance.database;

    //await DB.instance.database;
    debugPrint('Contato: ${contato.toJson()}');
    return await db.insert('contatos', contato.toJson());
  }

  Future editContato(ContatoModel contato) async {
    final db = await DB.instance.database;
    return await db.update(
      'contatos',
      contato.toJson(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future deleteContato(int id) async {
    final db = await DB.instance.database;
    return await db.delete('contatos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ContatoModel>> getContatos() async {
    final db = await DB.instance.database;
    List<Map<String, dynamic>> contatos = await db.query('contatos');
    return contatos.map((e) => ContatoModel.fromJson(e)).toList();
  }
}
