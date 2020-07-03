import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voluntarios/UI/home.dart';
import './calendar.dart';
import 'package:intl/intl.dart';
import 'package:voluntarios/models/cadastro.dart';
import './navBar.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  String dropdownValue = 'Brasília';
  TextEditingController nomeController = new TextEditingController();
  TextEditingController regiaoController = new TextEditingController();
  TextEditingController nascimentoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  TextEditingController confirmaSenhaController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          /*margin: EdgeInsets.all(40.0),*/
          children: <Widget>[
            Image(
              image: NetworkImage('https://placeimg.com/640/480/any'),
              height: 250.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
              child: TextField(
                  controller: nomeController,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    icon: Icon(Icons.person),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.grey[700],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(17.0, 10.0, 0.0, 0.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: Colors.grey[350],
                        ),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'Brasília',
                          'São Paulo',
                          'Rio de Janeiro'
                        ].map<DropdownMenuItem<String>>(
                            (String regiaoController) {
                          return DropdownMenuItem<String>(
                            value: regiaoController,
                            child: Text(regiaoController,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 18.0)),
                          );
                        }).toList(),
                      ),
                    ))
              ]),
            ),
            DatePicker(firstDate: 2020, lastDate: 2050, stateVar: 2),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: TextField(
                  controller: emailController,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    icon: Icon(Icons.email),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: TextField(
                  controller: senhaController,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.lock),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: TextField(
                  controller: confirmaSenhaController,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Confirme a senha',
                  )),
            ),
            Padding(
                padding: EdgeInsets.all(37.0),
                child: new RaisedButton(
                  onPressed: () {
                    final String name = nomeController.text;
                    final String location = regiaoController.text;
                    //final String birthday = nascimentoController.text;
                    final String email = emailController.text;
                    final String password = senhaController.text;
                    //final Cadastro novoCadastro =
                    // new Cadastro(name, location, email, password);
                    cadastro(Cadastro(name, email, password, 'Brasília'))
                        .then((id) {
                      findAll().then(
                          (cadastros) => debugPrint(cadastros.toString()));
                    });

                    //Navigator.pop(context, novoCadastro);
                  },
                  child: Text('Sign Up', style: TextStyle(fontSize: 15)),
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                ))
          ],
        ),
      ),
    );
  }

  _insert() async {
    Database db = await DatabaseHelper.instance.database;

    //raw insert

    String name = nomeController.text;
    String regiao = regiaoController.text;
    String nascimento = nascimentoController.text;
    String email = emailController.text;
    String senha = senhaController.text;

    int id = await db.rawInsert(
        'INSERT INTO ${DatabaseHelper.tableUser}'
        '${DatabaseHelper.columnName}, ${DatabaseHelper.columnEmail}, ${DatabaseHelper.columnSenha}, ${DatabaseHelper.columnNascimento}, ${DatabaseHelper.columnRegiao}) '
        'VALUES(?, ?, ?, ?, ?)',
        [name, email, senha, nascimento, regiao]);
    print(await db.query(DatabaseHelper.tableUser));
  }

  Future<String> _confirmarEmail() async {
    Database db = await DatabaseHelper.instance.database;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = emailController.text;

    List<Map> result =
        await db.rawQuery('SELECT * FROM tb_perfilusuario GROUP BY uk_email');

    if (result.contains(email)) {
      prefs.setString('stringValue', "nao");
    } else {
      prefs.setString('stringValue', "sim");
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("stringValue");
    //Remove bool
    prefs.remove("boolValue");
    //Remove int
    prefs.remove("intValue");
    //Remove double
    prefs.remove("doubleValue");
  }
}
