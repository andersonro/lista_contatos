import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_contatos/controllers/contato_controller.dart';
import 'package:lista_contatos/model/contato_model.dart';
import 'package:lista_contatos/pages/contato_page.dart';
import 'package:lista_contatos/pages/widgets/expasion_panel_contato_body_widget.dart';
import 'package:lista_contatos/pages/widgets/expasion_panel_contato_header_widget.dart';
import 'package:lista_contatos/pages/widgets/sem_contato_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  ContatoController contatoController = ContatoController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0.0,
    );
    _loadContatos();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  _loadContatos() async {
    await contatoController.load();
  }

  delContato(ContatoModel contatoModel) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.indigo,
              ),
              child: Icon(
                Icons.question_mark_outlined,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
          content: Text(
            'Deseja excluir o contato ${contatoModel.nome!.toUpperCase()}?',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(onPressed: () {}, child: Text('Excluir')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos', style: TextStyle(fontSize: 28)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ContatoPage(contatoModel: ContatoModel()),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.indigo,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,

                    child: Obx(() {
                      Widget w = SizedBox();
                      if (contatoController.getState.value ==
                          StateContatos.loading) {
                        w = Center(child: CircularProgressIndicator());
                      } else {
                        if (contatoController.listaContatos.isEmpty) {
                          w = SemContatoWidget();
                        } else {
                          Widget w = SizedBox();
                          if (contatoController.getState.value ==
                              StateContatos.loading) {
                            w = Center(child: CircularProgressIndicator());
                          } else if (contatoController.getState.value ==
                              StateContatos.error) {
                            w = Center(
                              child: Text('Erro ao carregar os contatos!'),
                            );
                          } else {
                            if (contatoController.listaContatos.isEmpty) {
                              w = Center(
                                child: Text(
                                  'Nenhum contato cadastrado!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            } else {
                              List<ContatoModel> lista =
                                  contatoController.listaContatos;

                              w = SingleChildScrollView(
                                child: ExpansionPanelList.radio(
                                  dividerColor: Colors.grey.shade200,
                                  key: Key(Random().nextInt(10).toString()),
                                  expansionCallback: (panelIndex, isExpanded) {
                                    lista[panelIndex].isExpended = !isExpanded;
                                  },
                                  children:
                                      lista.map<ExpansionPanel>((contato) {
                                        return ExpansionPanelRadio(
                                          value: contato,
                                          headerBuilder: (context, isExpanded) {
                                            return ExpasionPanelRadioContatoHeaderWidget(
                                              contato: contato,
                                            );
                                          },
                                          body:
                                              ExpasionPanelRadioContatoBodyWidget(
                                                contato: contato,
                                                fn: delContato,
                                              ),
                                          canTapOnHeader: true,
                                        );
                                      }).toList(),
                                ),
                              );
                            }
                          }

                          return w;
                        }
                      }

                      return w;
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
