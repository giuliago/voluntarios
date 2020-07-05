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

  static final tableEvent = 'tb_evento';
  static final eventDate = 'data';
  static final eventName = 'nome';
  static final eventDescription = 'descricao';
  static final eventDisponibility = 'disponibilidade';

  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;
  static Database _databaseEvent;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> get databaseEvent async {
    if (_databaseEvent != null) return _databaseEvent;
    // instancia o db na primeira vez que for acessado
    _databaseEvent = await _initDatabaseEvent();
    return _databaseEvent;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _initDatabaseEvent() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateEvent);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tb_perfilusuario(idusuario INTEGER PRIMARY KEY, nome VARCHAR(60), uk_email VARCHAR(45), senha VARCHAR(45), nascimento DATETIME, regiao VARCHAR(45))");
  }

  Future _onCreateEvent(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tb_event(pk_idevento INTEGER PRIMARY KEY, data DATETIME, nome VARCHAR(60), descricao VARCHAR(60), disponibilidade TINYINT, fk_tb_perfilorganizacao_pk_idorganizacao INT, fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario INTEGER, FOREIGN KEY(fk_tb_perfilorganizacao_pk_idorganizacao) REFERENCES tb_perfilorganizacao(pk_idorganizacao), FOREIGN KEY(fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario) REFERENCES tb_perfilusuario(pk_idusuario))");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    batch.insert(tableUser, row);
    dynamic results = await batch.commit();
    print(results);
    return await db.insert(tableUser, row);
  }

  Future<int> insertEvent(Map<String, dynamic> row) async {
    Database db = await instance.databaseEvent;
    /*Batch batch = db.batch();
    batch.insert(tableEvent, row);
    dynamic results = await batch.commit();
    print(results);*/
    return await db.insert(tableEvent, row);
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
