import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './calendar.dart';
import 'package:intl/intl.dart';
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
  DateTime _selectedDate;
  TextEditingController nomeController = new TextEditingController();
  TextEditingController regiaoController = new TextEditingController();
  TextEditingController nascimentoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  TextEditingController confirmaSenhaController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(40.0),
        child: ListView(
          children: <Widget>[
            TextField(
                controller: nomeController,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.person),
                )),
            Container(
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
            TextField(
                controller: nascimentoController,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                    labelText: (_selectedDate ==
                            null //ternary expression to check if date is null
                        ? 'Data de nascimento'
                        : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                    icon: Icon(Icons.calendar_today),
                    hintText: '13/04/1997')),
            TextField(
                controller: emailController,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  icon: Icon(Icons.email),
                )),
            TextField(
                controller: senhaController,
                obscureText: true,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  icon: Icon(Icons.lock),
                )),
            Container(
              padding: EdgeInsets.only(left: 40.0),
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
                padding: EdgeInsets.only(top: 50.0),
                child: new RaisedButton(
                  onPressed: () {
                    _confirmarEmail();
                    String emailValido = getStringValuesSF();
                    if (senhaController.text == confirmaSenhaController.text) {
                      // Confirma a senha
                      if (emailValido == "sim") {
                        removeValues();
                        _insert();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBar(),
                          ),
                        );
                      } else {
                        // inserir hint de email incorreto
                      }
                    } else {
                      // inserir o hint da senha incorreta
                    }
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
    ));
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
