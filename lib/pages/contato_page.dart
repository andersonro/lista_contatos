import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';

import 'package:get/state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
      await contatoController.saveContato(contatoModel);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contato ${contatoModel.nome} salvo com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  _camera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _cropImage(image);
    }
  }

  _galeria() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _cropImage(image);
    }
  }

  Future<void> _cropImage(XFile pickedFile) async {
    CroppedFile? croppedFile;
    croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.indigo,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(width: 520, height: 520),
        ),
      ],
    );
    if (croppedFile != null) {
      await Gal.putImage(croppedFile.path);
      setState(() {
        widget.contatoModel!.urlFoto = croppedFile!.path;
      });
    }
  }

  _imagePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Câmera'),
                onTap: () {
                  Navigator.pop(context);
                  _camera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  _galeria();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.contatoModel!.nome ?? 'Novo Contato'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        _imagePicker();
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.indigo,
                            child: CircleAvatar(
                              radius: 95,
                              backgroundImage:
                                  widget.contatoModel!.urlFoto != null
                                      ? Image.file(
                                        File(
                                          widget.contatoModel!.urlFoto ?? '',
                                        ),
                                      ).image
                                      : Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                      ).image,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.indigo,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.indigo,
                                size: 36,
                              ),
                            ),
                          ),
                        ],
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
                                borderSide: BorderSide(
                                  color: Colors.indigoAccent,
                                ),
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
                                borderSide: BorderSide(
                                  color: Colors.indigoAccent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.indigo),
                              ),
                              fillColor: Colors.indigoAccent,
                              border: OutlineInputBorder(),
                              labelText: "Telefone",
                              labelStyle: TextStyle(color: Colors.indigo),
                            ),
                            keyboardType: TextInputType.number,
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
                                borderSide: BorderSide(
                                  color: Colors.indigoAccent,
                                ),
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
            Obx(
              () =>
                  contatoController.getState.value == StateContatos.loading
                      ? SizedBox(
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.black.withValues(alpha: 0.8),
                              height: MediaQuery.of(context).size.height,
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      )
                      : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
