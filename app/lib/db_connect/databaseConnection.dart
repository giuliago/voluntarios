import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static final _databaseName = "db_voluntarios.db";
  static final _databaseVersion = 18;
  //static final newVersion = 2;
  static final tableUser = 'tb_perfilusuario';
  static final columnIdUser = 'pk_idusuario';
  static final columnNome = 'nome';
  static final columnEmail = 'uk_email';
  static final columnSenha = 'senha';
  static final columnNascimento = 'nascimento';
  static final columnRegiao = 'regiao';

  static final tableEvent = 'tb_evento';
  static final eventDate = 'data';
  static final eventName = 'nome';
  static final eventDescription = 'descricao';
  static final eventDisponibility = 'disponibilidade';
  static final eventFK1 = 'fk_tb_perfilorganizacao_pk_idorganizacao';
  static final eventFK2 =
      'fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario';

  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  //await deleteDatabase(path);

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
    //await deleteDatabase(path);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    //Batch batch = db.batch();
    await db.execute(
        "CREATE TABLE tb_perfilusuario(pk_idusuario INTEGER PRIMARY KEY, nome VARCHAR(60), uk_email VARCHAR(45), senha VARCHAR(45), nascimento DATETIME, regiao VARCHAR(45));");
    await db.execute(
        "CREATE TABLE tb_perfilorganizacao(pk_idorganizacao INTEGER PRIMARY KEY, nome VARCHAR(60), descricao VARCHAR(255), fk_tb_perfilusuario_pk_idusuario INTEGER, FOREIGN KEY(fk_tb_perfilusuario_pk_idusuario) REFERENCES tb_perfilusuario(pk_idusuario));");
    await db.execute(
        "CREATE TABLE tb_evento(pk_idevento INTEGER PRIMARY KEY, data DATETIME, nome VARCHAR(60), descricao VARCHAR(255), disponibilidade TINYINT, fk_tb_perfilorganizacao_pk_idorganizacao INTEGER NULL,fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario INTEGER NULL, FOREIGN KEY(fk_tb_perfilorganizacao_pk_idorganizacao) REFERENCES tb_perfilorganizacao(pk_idorganizacao), FOREIGN KEY(fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario) REFERENCES tb_perfilusuario(pk_idusuario));");
    await db.execute(
        "CREATE TABLE tb_competencias(pk_idcompetencias INTEGER PRIMARY KEY, nome VARCHAR(60), descricao VARCHAR(255));");
    await db.execute(
        "CREATE TABLE ta_inscricao(fk_tb_perfilusuario_pk_idusuario INTEGER, fk_tb_evento_pk_idevento INTEGER,FOREIGN KEY(fk_tb_perfilusuario_pk_idusuario) REFERENCES tb_perfilusuario(pk_idusuario), FOREIGN KEY(fk_tb_evento_pk_idevento) REFERENCES tb_evento(pk_idevento));");
    await db.execute(
        "CREATE TABLE ta_perfilusuario_has_tb_competencias(fk_perfilusuario_pk_idusuario INTEGER, fk_competencias_pk_idcompetencias INTEGER, FOREIGN KEY(fk_perfilusuario_pk_idusuario) REFERENCES perfilusuario(pk_idusuario), FOREIGN KEY(fk_competencias_pk_idcompetencias) REFERENCES fk_competencias(pk_idcompetencias));");
    //batch.commit();
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      print("Oldddd:" + oldVersion.toString());
      print("upgradingggggggggg");
      //await db.delete(tableUser, where: null, whereArgs: null);
      //await db.delete(tableEvent, where: null, whereArgs: null);
      await db.execute("DROP TABLE IF EXISTS tb_perfilusuario;");
      await db.execute("DROP TABLE IF EXISTS tb_perfilorganizacao;");
      await db.execute("DROP TABLE IF EXISTS tb_evento;");
      await db.execute("DROP TABLE IF EXISTS tb_competencias;");
      await db.execute("DROP TABLE IF EXISTS ta_inscricao;");
      await db.execute(
          "DROP TABLE IF EXISTS ta_perfilusuario_has_tb_competencias;");
      _onCreate(db, newVersion);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = OFF');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    //Batch batch = db.batch();
    //batch.insert(tableUser, row);
    //dynamic results = await batch.commit();
    //print(results);
    return await db.insert(tableUser, row);
  }

  Future<int> insertEvent(Map<String, dynamic> row) async {
    Database db = await instance.database;
    //Batch batch = db.batch();
    //batch.insert(tableEvent, row);
    //dynamic results = await batch.commit();
    //print(results);
    //results.commit();
    return await db.insert(tableEvent, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableUser);
  }

  Future<List<Map<String, dynamic>>> queryAllEvents() async {
    Database db = await instance.database;
    return await db.query('tb_evento');
  }

  Future<List<Map<String, dynamic>>> queryCookie(List lista) async {
    String email = lista[0];
    Database db = await instance.database;
    String whereString = 'uk_email = ?';
    List<dynamic> whereArguments = [email];
    return await db.query(tableUser,
        where: whereString, whereArgs: whereArguments);
  }

  Future<List<Map<String, dynamic>>> queryEventos() async {
    Database db = await instance.database;
    String whereString = 'disponibilidade = ?';
    List<dynamic> whereArguments = [1];
    return await db.query(tableEvent,
        where: whereString, whereArgs: whereArguments);
  }

  Future<List<Map<String, dynamic>>> queryEventosInscritos() async {
    Database db = await instance.database;
  }

  Future<String> queryLogin(List lista) async {
    String emailLogin = lista[0];
    String senhaLogin = lista[1];
    String validation = "";
    Database db = await instance.database;
    Batch btc = db.batch();
    List<Map> result = await db.query(tableUser);

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
    //return await db.query(tableUser);
  }
}

/*Future<void> verificaLogin(List lista) async {
  String emailLogin = lista[0];
  String senhaLogin = lista[1];
  String validation = "";
  //var listaLogin = Login(emailLogin: lista[0], senhaLogin: lista[1]);

  final Database db = await database;

  print("entrou verifica");

  List<Map> result = await db.query('tb_perfilusuario');
  result.forEach((row) => print(row));
  print("linhas: " + result.length.toString());

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
*/
