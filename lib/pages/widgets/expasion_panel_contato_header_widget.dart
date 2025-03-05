import 'package:flutter/material.dart';
import 'package:lista_contatos/model/contato_model.dart';

class ExpasionPanelRadioContatoHeaderWidget extends StatelessWidget {
  final ContatoModel contato;
  const ExpasionPanelRadioContatoHeaderWidget({
    super.key,
    required this.contato,
  });

  @override
  Widget build(BuildContext context) {
    var imgUrl =
        contato.urlFoto ??
        'https://loremflickr.com/640/480/people?lock=${contato.id}';
    return ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(backgroundColor: Colors.indigo, radius: 25),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 23,
            backgroundImage: NetworkImage(imgUrl),
          ),
        ],
      ),
      title: Text(
        contato.nome!,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
