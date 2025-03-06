class ContatoModel {
  int? id;
  String? nome;
  int? telefone;
  String? email;
  String? urlFoto;
  int? isExpended = 0;

  ContatoModel({
    this.nome,
    this.telefone,
    this.email,
    this.urlFoto,
    this.isExpended,
  });

  ContatoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    isExpended = json['isExpended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['urlFoto'] = urlFoto;
    data['isExpended'] = isExpended;
    return data;
  }
}
