import 'dart:io';

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
    return ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(backgroundColor: Colors.indigo, radius: 25),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 23,
            backgroundImage:
                contato.urlFoto != null
                    ? Image.file(File(contato.urlFoto!)).image
                    : Image.network(
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                    ).image,
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
