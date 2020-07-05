import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:voluntarios/UI/splashScreen.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'navBar.dart';
import 'signUp.dart';

class LoginPage extends StatelessWidget {
  //mudar para stateful e verificar se há login
  TextEditingController emailController = new TextEditingController();
  TextEditingController senhaController = new TextEditingController();
  final dbHelper = database.DatabaseHelper.instance;

  Widget _buttonLogin(BuildContext context) {
    return Container(
      height: 40.0,
      child: RaisedButton(
        onPressed: () async {
          String email = emailController.text;
          String senha = senhaController.text;
          var lista = [email, senha];
          final validacao = await database.verificaLogin(lista) as String;
          print("Valida?????:" + validacao);
          Navigator.push(
            context,
            MaterialPageRoute(
              //validação pra home
              builder: (context) => LoadingScreen(tela: 1),
            ),
          );
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
              "Entrar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formLogin(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
        padding: EdgeInsets.fromLTRB(50.0, deviceHeight - 500, 50, 0),
        child: ListView(children: <Widget>[
          TextField(
              //controller
              controller: emailController,
              style: TextStyle(
                fontSize: 15.0,
              ),
              decoration: InputDecoration(
                  hoverColor: Colors.lightGreen,
                  labelText: 'e-mail',
                  icon: Icon(Icons.email))),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: TextField(
                //controller
                controller: senhaController,
                obscureText: true,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                decoration: InputDecoration(
                    labelText: 'password', icon: Icon(Icons.vpn_key))),
          ),
          _buttonLogin(context),
          //implementar expand e flex
          Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Não possui um cadastro?",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 80,
                    child: FlatButton(
                      highlightColor: Colors.white,
                      color: Colors.white,
                      child: Text(
                        'Criar',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.lightBlue),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        ).then(
                          (novoCadastro) => debugPrint(novoCadastro.toString()),
                        );
                      },
                    ),
                  )
                ],
              ))
        ]));
  }

  Widget _buildLogin(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          width: deviceWidth,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/login.png"), fit: BoxFit.fill)),
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
          height: deviceHeight - 350,
        )),
        Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: deviceHeight - 350),
                child: SizedBox(
                  child: Image.asset("images/icon.png"),
                  height: 70,
                  width: 70,
                ))),
        _formLogin(context),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _buildLogin(context),
    );
  }
}
