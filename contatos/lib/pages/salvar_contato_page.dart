// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:contatos/model/contatos_model.dart';
import 'package:contatos/repository/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class SalvarContatoPage extends StatefulWidget {
  const SalvarContatoPage({super.key});

  @override
  State<SalvarContatoPage> createState() => _SalvarContatoPageState();
}

class _SalvarContatoPageState extends State<SalvarContatoPage> {
  ContatosRepository contatosRepository = ContatosRepository();
  var nomeControl = TextEditingController(text: "");
  var telefoneControl = TextEditingController(text: "");
  var emailControl = TextEditingController(text: "");

  var espaco = const SizedBox(height: 20);
  var estilo = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  XFile? photo;

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color.fromARGB(255, 12, 83, 35),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);

      photo = XFile(croppedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Center(
              child: Text(
                "Salvar Contato",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 12, 83, 35),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(children: [
              Center(
                  child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Wrap(
                          children: [
                            ListTile(
                                onTap: () async {
                                  Navigator.pop(context);
                                  final ImagePicker picker = ImagePicker();
                                  photo = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (photo != null) {
                                    print(photo!.path);
                                    // await GallerySaver.saveImage(photo!.path);
                                    cropImage(photo!);
                                    setState(() {});
                                  }
                                },
                                leading:
                                    const FaIcon(FontAwesomeIcons.cameraRetro),
                                title: const Text(
                                  "Camera",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            ListTile(
                                onTap: () async {
                                  Navigator.pop(context);
                                  final ImagePicker picker = ImagePicker();
                                  photo = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                  cropImage(photo!);
                                },
                                leading: const FaIcon(FontAwesomeIcons.images),
                                title: const Text("Galeria",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                        );
                      });
                  //
                },
                child: photo != null
                    ? Image.file(
                        File(photo!.path),
                        height: 150,
                        width: 150,
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 30),
                        color: const Color.fromARGB(96, 190, 190, 144),
                        child: const FaIcon(
                          FontAwesomeIcons.image,
                          size: 50,
                        )),
              )),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Nome Completo:",
                style: estilo,
              ),
              TextField(
                controller: nomeControl,
              ),
              espaco,
              Text(
                "Telefone:",
                style: estilo,
              ),
              TextFormField(
                controller: telefoneControl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
              ),
              espaco,
              Text(
                "E-mail:",
                style: estilo,
              ),
              TextField(
                controller: emailControl,
              ),
              espaco,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.redAccent)),
                      onPressed: () {
                        nomeControl.text = "";
                        telefoneControl.text = "";
                        emailControl.text = "";
                        setState(() {});
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 23, 93, 151))),
                      onPressed: () async {
                        await contatosRepository.salvar(ContatosModel(
                            0,
                            nomeControl.text,
                            telefoneControl.text,
                            emailControl.text,
                            photo!.path.toString()));
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Salvar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ]),
          )),
    );
  }
}
