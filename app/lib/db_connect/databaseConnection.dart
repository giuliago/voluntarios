import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:voluntarios/models/cadastro.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static final _databaseName = "db_voluntarios.db";
  static final _databaseVersion = 1;

  static final tableUser = 'tb_perfilusuario';

  static final columnIdUser = 'pk_idusuario';
  static final columnName = 'nome';
  static final columnEmail = 'uk_email';
  static final columnSenha = 'senha';
  static final columnNascimento = 'nascimento';
  static final columnRegiao = 'regiao';

  static final tableEvent =
      'tb_evento'; // uses fk_tb_perfilorganizacao_pk_idorganizacao and fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario

  static final columnIdEvent = 'pk_idevento';
  static final columnDate = 'data';
  static final columnDescript = 'descricao';
  static final columnDisponib = 'disponibilidade';
  static final columnFkEvent1 = 'fk_tb_perfilorganizacao_pk_idorganizacao';
  static final columnFkEvent2 =
      'fk_tb_perfilorganizacao_tb_perfilusuario_pk_idusuario';

  static final tableOrganiz =
      'tb_perfilorganizacao'; //uses columnName and columnDescript, fk_tb_perfilusuario_pk_idusuario

  static final columnIdOrganiz = 'pk_idorganizacao';

  static final tableCompetencia =
      'td_competencia'; // fk_tb_perfilusuario_pk_idusuario

  static final columnIdCompet =
      'pk_competencia'; //uses columnName and columnDescript

  static final table =
      'ta_inscricao'; //uses fk_tb_perfilusuario_pk_idusuario and fk_tb_evento_pk_idevento

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // Iniciar ou abrir banco de dados(ou criar se não existir)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL para criar tabela do banco de dados
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUser (
            $columnIdUser INTEGER PRIMARY KEY,
            $columnName VARCHAR(60),
            $columnEmail VARCHAR(45) UNIQUE,
            $columnSenha VARCHAR(45),
            $columnNascimento DATETIME,
            $columnRegiao VARCHAR(45)
          )
          ''');
  }
}

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'db_voluntarios.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE tb_perfilusuario ('
          'idusuario INTEGER PRIMARY KEY, '
          'nome VARCHAR(60), '
          'email VARCHAR(45) UNIQUE,'
          'senha VARCHAR(45),'
          'nascimento DATETIME,'
          'regiao VARCHAR(45))');
    }, version: 1);
  });
}

Future<int> save(Cadastro cadastro) {
  return createDatabase().then((db) {
    final Map<String, dynamic> cadastroMap = Map();
    cadastroMap['nome'] = cadastro.name;
    cadastroMap['email'] = cadastro.email;
    cadastroMap['senha'] = cadastro.password;
    cadastroMap['regiao'] = cadastro.location;
    return db.insert('tb_perfilusuario', cadastroMap);
  });
}

Future<List<Cadastro>> findAll() {
  return createDatabase().then((db) {
    return db.query('tb_perfilusuario').then((maps) {
      final List<Cadastro> cadastros = List();
      for (Map<String, dynamic> map in maps) {
        final Cadastro cadastro = Cadastro(
          map['idusuario'],
          map['nome'],
          map['email'],
          map['senha'],
          map['regiao'],
        );
        cadastros.add(cadastro);
      }
      return cadastros;
    });
  });
}
