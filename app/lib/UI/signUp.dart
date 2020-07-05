import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voluntarios/UI/home.dart';
import './calendar.dart';
import 'package:intl/intl.dart';
//import 'package:voluntarios/models/cadastro.dart';
import './navBar.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final dbHelper = DatabaseHelper.instance;
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
                    final String nome = nomeController.text;
                    final String regiao = regiaoController.text;
                    //final String birthday = nascimentoController.text;
                    final String email = emailController.text;
                    final String senha = senhaController.text;
                    var lista = [nome, regiao, email, senha];
                    _inserir(lista);
                    _consultar();
                    //insere(lista);
                    //final Cadastro novoCadastro = new Cadastro(nome, email, senha, regiao);
                    // Navigator.pop(context, novoCadastro);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(),
                      ),
                    );
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

  void _inserir(List lista) async {
    String email = lista[2];
    String senha = lista[3];
    // linha para incluir
    Map<String, dynamic> row = {
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnSenha: senha
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }
}
