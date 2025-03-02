import 'package:flutter/material.dart';
import 'package:lista_contatos/model/contato_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContatoModel> contatos = [
    ContatoModel(nome: 'João', telefone: 123456789, email: 'joao@email.com'),
    ContatoModel(nome: 'Maria', telefone: 987654321, email: 'maria@email.com'),
    ContatoModel(nome: 'José', telefone: 123456789, email: 'jose@email.com'),
    ContatoModel(nome: 'Pedro', telefone: 987654321, email: 'pedro@email.com'),
    ContatoModel(nome: 'Paulo', telefone: 123456789, email: 'paulo@email.com'),
    ContatoModel(nome: 'Ana', telefone: 987654321, email: 'ana@email.com'),
    ContatoModel(nome: 'Lucas', telefone: 123456789, email: 'lucas@email.com'),
    ContatoModel(
      nome: 'Fernando',
      telefone: 987654321,
      email: 'fernando@email.com',
    ),
    ContatoModel(
      nome: 'Rafael',
      telefone: 123456789,
      email: 'rafael@email.com',
    ),
    ContatoModel(
      nome: 'Gustavo',
      telefone: 987654321,
      email: 'gustavo@email.com',
    ),
    ContatoModel(
      nome: 'Ricardo',
      telefone: 123456789,
      email: 'ricardo@email.com',
    ),
    ContatoModel(
      nome: 'Felipe',
      telefone: 987654321,
      email: 'felipe@email.com',
    ),
    ContatoModel(
      nome: 'Carlos',
      telefone: 123456789,
      email: 'carlos@email.com',
    ),
    ContatoModel(
      nome: 'Marcos',
      telefone: 987654321,
      email: 'marcos@email.com',
    ),
  ];

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos', style: TextStyle(fontSize: 28)),
        centerTitle: true,
        elevation: 0,
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
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 4, top: 16, right: 4),
                      child: ExpansionPanelList.radio(
                        dividerColor: Colors.grey.shade200,
                        elevation: 4,
                        expansionCallback: (int panelIndex, bool isExpanded) {
                          setState(() {
                            contatos[panelIndex].isExpended =
                                !contatos[panelIndex].isExpended;
                          });
                        },
                        children:
                            contatos.map<ExpansionPanel>((
                              ContatoModel contato,
                            ) {
                              return ExpansionPanelRadio(
                                value: contato,
                                canTapOnHeader: true,
                                headerBuilder: (
                                  BuildContext context,
                                  bool isExpanded,
                                ) {
                                  var imgUrl =
                                      contato.urlFoto ??
                                      'https://loremflickr.com/640/480/people?lock=${contato.id}';
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: ListTile(
                                      leading: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.indigo,
                                            radius: 25,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 23,
                                            backgroundImage: NetworkImage(
                                              imgUrl,
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        contato.nome ?? '',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  );
                                },
                                body: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.phone),
                                          Expanded(
                                            child: Text(
                                              contato.telefone.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.email),
                                          Expanded(
                                            child: Text(
                                              contato.email ?? '',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
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
