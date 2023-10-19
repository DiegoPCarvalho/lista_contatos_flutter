class ContatosModel {
  int _id = 0;
  String _nomeCompleto = "";
  String _telefone = "";
  String _email = "";
  String _fotoUrl = "";

  ContatosModel(
      this._id, this._nomeCompleto, this._telefone, this._email, this._fotoUrl);

  //id get set
  set id(id) => _id = id;
  int get id => _id;

  //nome get set
  set nome(nome) => _nomeCompleto = nome;
  String get nome => _nomeCompleto;

  //telefone get set
  set telefone(telefone) => _telefone = telefone;
  String get telefone => _telefone;

  //email get set
  set email(email) => _email = email;
  String get email => _email;

  //email get set
  set fotoUrl(fotoUrl) => _fotoUrl = fotoUrl;
  String get fotoUrl => _fotoUrl;
}
