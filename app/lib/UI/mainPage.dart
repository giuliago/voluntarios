import 'package:flutter/material.dart';
import 'package:voluntarios/models/cadastro.dart';
import 'navBar.dart';
import 'signUp.dart';
import 'loginPage.dart';

class MainPage extends StatelessWidget {
  Widget _button(BuildContext context) {
    return Container(
      height: 40.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUp(),
            ),
          );
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
              "Quero me cadastrar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginPage(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
            width: deviceWidth,
            height: deviceHeight - 90,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/mainpage.png"),
                    fit: BoxFit.fill))),
        /*Center(
            heightFactor: 400,
            child: RichText(
              
                text: TextSpan(
                  
                    text: 'Faça parte da nossa',
                    style: TextStyle(color: Colors.black)),
                    
                    TextSpan(
                    text: 'Faça parte da nossa',
                    style: TextStyle(color: Colors.black)))),*/
        Padding(
            padding: EdgeInsets.only(top: deviceHeight - 200),
            child: Column(children: <Widget>[
              Center(child: _button(context)),
              //implementar expand e flex
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: deviceWidth - 300),
                    child: Text(
                      "Já possui um cadastro?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  FlatButton(
                    highlightColor: Colors.white,
                    color: Colors.white,
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ])),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginPage(context),
    );
  }
}
