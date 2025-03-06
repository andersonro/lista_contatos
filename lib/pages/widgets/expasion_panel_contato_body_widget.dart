import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/pages/contato_page.dart';

class ExpasionPanelRadioContatoBodyWidget extends StatelessWidget {
  final ContatoModel contato;
  final Function fn;
  const ExpasionPanelRadioContatoBodyWidget({
    super.key,
    required this.contato,
    required this.fn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 28),
                    SizedBox(width: 8),
                    Text(
                      UtilBrasilFields.obterTelefone(
                        contato.telefone.toString().padLeft(10, '0'),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                if (contato.email != null)
                  Row(
                    children: [
                      Icon(Icons.email, size: 28),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${contato.email}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                fn(contato);
              },
              icon: Icon(
                Icons.delete_forever,
                size: 30,
                color: Colors.red.shade900,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContatoPage(contatoModel: contato),
                  ),
                );
              },
              icon: Icon(Icons.edit_square, size: 28),
            ),
          ],
        ),
      ],
    );
  }
}
