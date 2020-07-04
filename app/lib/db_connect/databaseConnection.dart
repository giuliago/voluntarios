import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

Future<void> insertCadastro(Cadastro cadastro) async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'db/db_voluntarios.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE tb_perfilusuario(idusuario INTEGER PRIMARY KEY, nome VARCHAR(60), uk_email VARCHAR(45), senha VARCHAR(45), nascimento DATETIME, regiao VARCHAR(45)");
    },
    version: 1,
  );
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'tb_perfilusuario',
    cadastro.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> Insere(List lista) async {
  var fido = Cadastro(
    nome: lista[0],
    email: lista[1],
    senha: lista[2],
    regiao: lista[3],
  );
  await insertCadastro(fido);
}

class Cadastro {
  //final int id;
  final String nome;
  final String email;
  final String senha;
  //final String nascimento;
  final String regiao;

  Cadastro(
      {this.nome, this.email, this.senha, /*this.nascimento,*/ this.regiao});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'uk_email': email,
      'senha': senha,
      //'nascimento': nascimento,
      'regiao': regiao,
    };
  }
}
