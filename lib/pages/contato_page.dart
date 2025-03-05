import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lista_contatos/model/contato_model.dart';

class ContatoPage extends StatefulWidget {
  final ContatoModel? contatoModel;
  const ContatoPage({super.key, this.contatoModel});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.contatoModel!.nome ?? 'Novo Contato'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.indigo,
                  child: CircleAvatar(
                    radius: 95,
                    backgroundImage: NetworkImage(
                      widget.contatoModel!.urlFoto ??
                          'https://loremflickr.com/640/480/people?lock=${widget.contatoModel!.id}',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: widget.contatoModel!.nome ?? '',
                        //controller: _dtCriadoIniController,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          fillColor: Colors.indigoAccent,
                          border: OutlineInputBorder(),
                          labelText: "Nome",
                          labelStyle: TextStyle(color: Colors.indigo),
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (value) {},
                        onTap: () {},
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue:
                            widget.contatoModel!.email != null
                                ? UtilBrasilFields.obterTelefone(
                                  widget.contatoModel!.telefone
                                      .toString()
                                      .padLeft(11, '0'),
                                )
                                : '',
                        //controller: _dtCriadoIniController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          fillColor: Colors.indigoAccent,
                          border: OutlineInputBorder(),
                          labelText: "Telefone",
                          labelStyle: TextStyle(color: Colors.indigo),
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (value) {},
                        onTap: () {},
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue: widget.contatoModel!.email ?? '',
                        //controller: _dtCriadoIniController,
                        style: const TextStyle(),

                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          fillColor: Colors.indigoAccent,
                          border: OutlineInputBorder(),
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.indigo),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {},
                        onTap: () {},
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.indigo,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.save, size: 22),
                          label: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Salvar"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
