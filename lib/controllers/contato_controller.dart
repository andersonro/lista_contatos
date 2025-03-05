import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lista_contatos/config/custom_exception.dart';
import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/repositories/data/db.dart';

class ContatoController extends GetxController {
  late DB db;

  final _state = StateContatos.start.obs;
  Rx<StateContatos> get getState => _state.value.obs;

  final _listaContatos = <ContatoModel>[].obs;
  RxList<ContatoModel> get listaContatos => _listaContatos;

  List<ContatoModel> contatos = [
    ContatoModel(
      nome: 'João Fernando de Oliveira Martins Ferreira',
      telefone: 123456789,
      email: 'joao@email.com',
    ),
    ContatoModel(nome: 'Maria', telefone: 987654321, email: 'maria@email.com'),
    ContatoModel(nome: 'José', telefone: 123456789, email: 'jose@email.com'),
    ContatoModel(nome: 'Pedro', telefone: 987654321, email: 'pedro@email.com'),
    ContatoModel(nome: 'Paulo', telefone: 123456789, email: 'paulo@email.com'),
    ContatoModel(nome: 'Ana', telefone: 987654321, email: 'ana@email.com'),
    ContatoModel(nome: 'Lucas', telefone: 123456789, email: 'lucas@email.com'),
    ContatoModel(
      nome: 'Fernando',
      telefone: 987654321,
      email: 'fernando@email.com',
    ),
    ContatoModel(
      nome: 'Rafael',
      telefone: 123456789,
      email: 'rafael@email.com',
    ),
    ContatoModel(
      nome: 'Gustavo',
      telefone: 987654321,
      email: 'gustavo@email.com',
    ),
    ContatoModel(
      nome: 'Ricardo',
      telefone: 123456789,
      email: 'ricardo@email.com',
    ),
    ContatoModel(
      nome: 'Felipe',
      telefone: 987654321,
      email: 'felipe@email.com',
    ),
    ContatoModel(
      nome: 'Carlos',
      telefone: 123456789,
      email: 'carlos@email.com',
    ),
    ContatoModel(
      nome: 'Marcos',
      telefone: 987654321,
      email: 'marcos@email.com',
    ),
  ];

  Future load() async {
    _state.value = StateContatos.loading;
    try {
      //List<ContatoModel> lista = await db.getContatos();
      //debugPrint(lista.toString());
      Future.delayed(const Duration(seconds: 5), () {
        _listaContatos.addAll(contatos);
        //debugPrint(contatos.toString());
        _listaContatos.refresh();

        _state.value = StateContatos.success;
      });
    } catch (e) {
      _state.value = StateContatos.error;
      throw CustomException(message: e.toString());
    }
  }
}

extension on List<ContatoModel> {
  set value(List<ContatoModel> value) {}
}

enum StateContatos { start, loading, success, error }
