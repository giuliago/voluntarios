import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static final _databaseName = "db_voluntarios.db";
  static final _databaseVersion = 1;
  static final tableUser = 'tb_perfilusuario';
  static final columnIdUser = 'idusuario';
  static final columnNome = 'nome';
  static final columnEmail = 'email';
  static final columnSenha = 'senha';
  static final columnNascimento = 'nascimento';
  static final columnRegiao = 'regiao';
  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tb_perfilusuario(idusuario INTEGER PRIMARY KEY, nome VARCHAR(60), uk_email VARCHAR(45), senha VARCHAR(45), nascimento DATETIME, regiao VARCHAR(45))");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    batch.insert(tableUser, row);
    dynamic results = await batch.commit();
    print(results);
    return await db.insert(tableUser, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableUser);
  }

  Future<String> queryLogin(List lista) async {
    String emailLogin = lista[0];
    String senhaLogin = lista[1];
    String validation = "";
    Database db = await instance.database;
    Batch btc = db.batch();
    List<Map> result = await db.query(tableUser);
    if (result.length == 0) {
      print("result == 0");
    } else {
      if (result.contains(emailLogin) && result.contains(senhaLogin)) {
        print("contains email and password");
        return validation = "true";
      } else {
        return validation = "false";
      }
    }
    //return await db.query(tableUser);
  }
}

/*Future<void> insertCadastro(Cadastro cadastro) async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'db/db_voluntarios.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE tb_perfilusuario(idusuario INTEGER PRIMARY KEY, nome VARCHAR(60), uk_email VARCHAR(45), senha VARCHAR(45), nascimento DATETIME, regiao VARCHAR(45));");
    },
    version: 1,
  );
  // Get a reference to the database.
  final Database db = await database;

  await db.insert(
    'tb_perfilusuario',
    cadastro.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  db.close();
  //print("something");
}

Future<void> insere(List lista) async {
  var listaInsert = Cadastro(
    nome: lista[0],
    email: lista[1],
    senha: lista[2],
    regiao: lista[3],
  );
  await insertCadastro(listaInsert);
  //db.close();
}
*/
Future<void> verificaLogin(List lista) async {
  String emailLogin = lista[0];
  String senhaLogin = lista[1];
  String validation = "";
  //var listaLogin = Login(emailLogin: lista[0], senhaLogin: lista[1]);
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'db/db_voluntarios.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE tb_perfilusuario(idusuario INTEGER PRIMARY KEY, nome VARCHAR(60), uk_email VARCHAR(45), senha VARCHAR(45), nascimento DATETIME, regiao VARCHAR(45));");
    },
    version: 1,
  );
  final Database db = await database;

  print("entrou verifica");

  List<Map> result = await db.query('tb_perfilusuario');
  if (result.length > 0) {
    print("result > 0");
    for (var map in result) {
      print("map v:");
      print(map);
      if (map.containsValue(emailLogin) && map.containsValue(senhaLogin)) {
        print("contains email and password");
        return validation = "true";
      } else {
        print("login incorrect");
        //return validation = "false";
      }
    }
  } else {
    print("result == 0");
  }

  //final List<Map<String, dynamic>> maps = await db.query('tb_perfilusuario');
}
/*
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

class Login {
  //final int id;
  final String emailLogin;
  final String senhaLogin;
  //final String nascimento;

  Login({this.emailLogin, this.senhaLogin});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'uk_email': emailLogin,
      'senha': senhaLogin,
      //'nascimento': nascimento,
    };
  } */
