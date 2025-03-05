import 'dart:math';

class ContatoModel {
  int id = Random().nextInt(100);
  String? nome;
  int? telefone;
  String? email;
  String? urlFoto;
  bool isExpended = false;

  ContatoModel({this.nome, this.telefone, this.email, this.urlFoto});

  ContatoModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    isExpended = isExpended;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['urlFoto'] = urlFoto;
    data['isExpended'] = isExpended;
    return data;
  }
}
