import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_contatos/controllers/contato_controller.dart';
import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/pages/home_page.dart';

class ContatoPage extends StatefulWidget {
  final ContatoModel? contatoModel;
  const ContatoPage({super.key, this.contatoModel});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  ContatoController contatoController = ContatoController();
  final _formKey = GlobalKey<FormState>();

  _addContato(ContatoModel contatoModel) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ContatoModel contato = ContatoModel(
        nome: contatoModel.nome,
        telefone: contatoModel.telefone,
        email: contatoModel.email,
        urlFoto: contatoModel.urlFoto ?? '',
        isExpended: contatoModel.isExpended ?? 1,
      );
      debugPrint('Contato: ${contato.toJson()}');
      await contatoController.addContato(contato);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

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
                        onSaved: (value) {
                          widget.contatoModel!.nome = value;
                        },
                        onTap: () {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
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
                        onSaved: (value) {
                          if (value != null) {
                            widget.contatoModel!.telefone = int.parse(
                              UtilBrasilFields.obterTelefone(
                                value,
                                mascara: false,
                              ),
                            );
                          }
                        },
                        onTap: () {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
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
                        onSaved: (value) {
                          widget.contatoModel!.email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um e-mail válido';
                          }
                          return null;
                        },
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
                          onPressed: () async {
                            await _addContato(widget.contatoModel!);
                          },
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
