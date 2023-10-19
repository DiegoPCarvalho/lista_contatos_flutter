import 'package:contatos/model/contatos_model.dart';
import 'package:contatos/repository/database.dart';

class ContatosRepository {
  Future<List<ContatosModel>> obterDados() async {
    List<ContatosModel> contatos = [];
    var db = await SQLiteDataBase().getDatabase();
    var results = await db.rawQuery(
        'SELECT id, nomeCompleto, telefone, email, fotoUrl FROM contatos');
    for (var element in results) {
      contatos.add(ContatosModel(
          int.parse(element["id"].toString()),
          element["nomeCompleto"].toString(),
          element["telefone"].toString(),
          element["email"].toString(),
          element["fotoUrl"].toString()));
    }
    return contatos;
  }

  Future<List<ContatosModel>> obterDadosId(int id) async {
    List<ContatosModel> contatos = [];
    var db = await SQLiteDataBase().getDatabase();
    var results = await db.rawQuery(
        'SELECT id, nomeCompleto, telefone, email, fotoUrl FROM contatos WHERE id = ?',
        [id]);
    for (var element in results) {
      contatos.add(ContatosModel(
          int.parse(element["id"].toString()),
          element["nomeCompleto"].toString(),
          element["telefone"].toString(),
          element["email"].toString(),
          element["fotoUrl"].toString()));
    }
    return contatos;
  }

  Future<void> salvar(ContatosModel contatosModel) async {
    var db = await SQLiteDataBase().getDatabase();
    await db.rawInsert(
        'INSERT INTO contatos (nomeCompleto, telefone, email, fotoUrl) values(?,?,?,?)',
        [
          contatosModel.nome,
          contatosModel.telefone,
          contatosModel.email,
          contatosModel.fotoUrl
        ]);
  }

  Future<void> alterar(ContatosModel contatosModel) async {
    var db = await SQLiteDataBase().getDatabase();
    await db.rawUpdate(
        'UPDATE contatos SET nomeCompleto = ?, telefone = ?, email = ?, fotoUrl = ? WHERE id = ?',
        [
          contatosModel.nome,
          contatosModel.telefone,
          contatosModel.email,
          contatosModel.fotoUrl,
          contatosModel.id
        ]);
  }

  Future<void> deletar(int id) async {
    var db = await SQLiteDataBase().getDatabase();
    await db.rawUpdate('DELETE FROM contatos WHERE id = ?', [id]);
  }
}
