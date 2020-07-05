import 'package:flutter/material.dart';
import './navBar.dart';
import './signUp.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'package:voluntarios/models/cadastro.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  final dbHelper = database.DatabaseHelper.instance;

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: <Widget>[
                      const Image(
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        height: 250.0,
                      ),
                      new Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: FlatButton(
                              highlightColor: Colors.grey[100],
                              padding: EdgeInsets.only(left: 50.0),
                              color: Colors.grey[100],
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(fontSize: 18.0),
                              )),
                        ),
                        Expanded(
                            flex: 2,
                            child: FlatButton(
                              highlightColor: Colors.grey[100],
                              padding: EdgeInsets.only(right: 50.0),
                              color: Colors.grey[100],
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ),
                                ).then(
                                  (novoCadastro) =>
                                      debugPrint(novoCadastro.toString()),
                                );
                              },
                            )),
                      ]),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: TextField(
                            controller: emailController,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                            decoration: InputDecoration(
                                labelText: 'e-mail', icon: Icon(Icons.email))),
                      ),
                      TextField(
                          controller: senhaController,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'password',
                              icon: Icon(Icons.vpn_key))),
                      Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: new FlatButton(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                            textColor: Colors.deepOrange,
                            onPressed: () async {
                              String email = emailController.text;
                              String senha = senhaController.text;
                              var lista = [email, senha];
                              //String validacao;
                              final validacao =
                                  await database.verificaLogin(lista) as String;
                              print("Valida?????:" + validacao);
                              if (validacao.contains('true')) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavBar(),
                                  ),
                                );
                              } else {
                                debugPrint('nao deu');
                                // login wrong
                              }
                            },
                            child:
                                Text('Sign In', style: TextStyle(fontSize: 15)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.deepOrange)),
                          ))
                    ],
                  ))
            ])));
  }
}
