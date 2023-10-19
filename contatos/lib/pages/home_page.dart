import 'dart:io';
import 'package:contatos/model/contatos_model.dart';
import 'package:contatos/pages/alterar_contato_page.dart';
import 'package:contatos/pages/salvar_contato_page.dart';
import 'package:contatos/repository/contatos_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContatosRepository contatosRepository = ContatosRepository();
  var _contatos = const <ContatosModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    _contatos = await contatosRepository.obterDados();
    setState(() {});
  }

  openHome() {
    Future.delayed(const Duration(seconds: 1), () {
      carregarDados();
    });
  }

  @override
  Widget build(BuildContext context) {
    openHome();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Contatos",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 83, 35),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SalvarContatoPage()));
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView.builder(
            itemCount: _contatos.length,
            itemBuilder: (_, int index) {
              var contatos = _contatos[index];
              return Container(
                child: Dismissible(
                  onDismissed: (DismissDirection dismissDirection) async {
                    await contatosRepository.deletar(contatos.id);
                    carregarDados();
                    setState(() {});
                  },
                  key: Key(contatos.id.toString()),
                  child: Card(
                      elevation: 8,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      AlteradoContatoPage(id: contatos.id)));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(File(contatos.fotoUrl)),
                        ),
                        title: Text(contatos.nome),
                        trailing: const FaIcon(FontAwesomeIcons.phone),
                      )),
                ),
              );
            },
          )),
    ));
  }
}
