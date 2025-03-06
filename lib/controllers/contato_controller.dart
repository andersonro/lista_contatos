import 'package:get/get.dart';
import 'package:lista_contatos/config/custom_exception.dart';
import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/repositories/contato_repository.dart';

class ContatoController extends GetxController {
  ContatoRepository contatoRepository = ContatoRepository();

  final _state = StateContatos.start.obs;
  Rx<StateContatos> get getState => _state.value.obs;

  final _listaContatos = <ContatoModel>[].obs;
  RxList<ContatoModel> get listaContatos => _listaContatos;

  Future load() async {
    _state.value = StateContatos.loading;
    try {
      List<ContatoModel> contatos = await contatoRepository.getContatos();
      _listaContatos.addAll(contatos);
      _listaContatos.refresh();
      _state.value = StateContatos.success;
    } catch (e) {
      _state.value = StateContatos.error;
      throw CustomException(message: e.toString());
    }
  }

  Future addContato(ContatoModel contato) async {
    _state.value = StateContatos.loading;
    try {
      await contatoRepository.addContato(contato);
      //_listaContatos.add(contato);
      //_listaContatos.refresh();
      await load();
      _state.value = StateContatos.success;
    } catch (e) {
      _state.value = StateContatos.error;
      //throw CustomException(message: e.toString());
      throw Exception(e.toString());
    }
  }
}

enum StateContatos { start, loading, success, error }
