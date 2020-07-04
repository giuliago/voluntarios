import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voluntarios/UI/home.dart';
import 'package:voluntarios/UI/loginPage.dart';
import './calendar.dart';
import 'package:intl/intl.dart';
import 'package:voluntarios/models/cadastro.dart';
import './navBar.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  DateTime _selectedDate;
  String dropdownValue = 'Brasília';
  TextEditingController nomeController = new TextEditingController();
  TextEditingController regiaoController = new TextEditingController();
  TextEditingController nascimentoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  TextEditingController confirmaSenhaController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSignUp(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buttonSignUp(BuildContext context) {
    return Container(
      height: 40.0,
      child: RaisedButton(
        onPressed: () {
          final String name = nomeController.text;
          //precisa fazer o list de localizações
          final String location = regiaoController.text;
          //precisa formatar a string
          //final String birthday = nascimentoController.text;
          final String email = emailController.text;
          final String password = senhaController.text;
          final Cadastro novoCadastro =
              new Cadastro(name, location, email, password);
          Navigator.pop(context, novoCadastro);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightGreen, Colors.lightBlue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Cadastrar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formSignUp(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Padding(
        padding: EdgeInsets.fromLTRB(
            50.0, deviceHeight - 590, 50, mediaQuery.viewInsets.bottom),
        child: ListView(children: <Widget>[
          TextField(
              controller: nomeController,
              style: TextStyle(
                fontSize: 14.0,
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
                        color: Colors.grey[300],
                      ),
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.lightGreen,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Brasília', 'São Paulo', 'Rio de Janeiro']
                          .map<DropdownMenuItem<String>>(
                              (String regiaoController) {
                        return DropdownMenuItem<String>(
                          value: regiaoController,
                          child: Text(regiaoController,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 14.0)),
                        );
                      }).toList(),
                    ),
                  ))
            ]),
          ),
          DatePicker(firstDate: 1950, lastDate: 2010, stateVar: 2, style: 1),
          TextField(
              controller: emailController,
              style: TextStyle(
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                labelText: 'E-mail',
                icon: Icon(Icons.email),
              )),
          TextField(
              controller: senhaController,
              obscureText: true,
              style: TextStyle(
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                labelText: 'Senha',
                icon: Icon(Icons.lock),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: TextField(
                controller: confirmaSenhaController,
                obscureText: true,
                style: TextStyle(
                  fontSize: 14.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Confirme a senha',
                )),
          ),
          _buttonSignUp(context),
        ]));
  }

  Widget _buildSignUp(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          width: deviceWidth,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/signup.png"), fit: BoxFit.fill)),
        ),
        Center(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: deviceWidth - 60,
          height: deviceHeight - 250,
        )),
        Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: deviceHeight - 240),
                child: SizedBox(
                  child: Image.asset("images/icon.png"),
                  height: 70,
                  width: 70,
                ))),
        _formSignUp(context),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: EdgeInsets.fromLTRB(90, 50, 10, 70),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Já possui cadastro?",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      width: 80,
                      child: FlatButton(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.lightBlue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          ).then(
                            (novoCadastro) =>
                                debugPrint(novoCadastro.toString()),
                          );
                        },
                      ),
                    )
                  ],
                )))
      ],
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
