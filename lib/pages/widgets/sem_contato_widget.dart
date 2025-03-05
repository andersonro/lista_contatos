import 'package:flutter/material.dart';

class SemContatoWidget extends StatelessWidget {
  const SemContatoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.person_off, size: 100, color: Colors.grey),
        Text(
          'Nenhum contato cadastrado!',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ],
    );
  }
}
