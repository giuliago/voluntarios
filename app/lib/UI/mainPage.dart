import 'package:flutter/material.dart';
import 'package:voluntarios/models/cadastro.dart';
import 'navBar.dart';
import 'signUp.dart';
import 'loginPage.dart';

class MainPage extends StatelessWidget {
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
              Center(
                  child: SizedBox(
                width: deviceWidth - 80,
                child: FlatButton(
                    highlightColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    color: Colors.lightGreen,
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
                    child: Text(
                      'Quero me cadastrar',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    )),
              )),
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

  /*Widget loginPage(BuildContext context) {
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
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                            decoration: InputDecoration(
                                labelText: 'e-mail', icon: Icon(Icons.email))),
                      ),
                      TextField(
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavBar(),
                                ),
                              );
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
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginPage(context),
    );
  }
}
