import 'package:flutter/material.dart';
import './navBar.dart';
import './signUp.dart';

class LoginPage extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
        children: <Widget>[
        Card(
          color: Colors.grey,
        child: Column(
          children: <Widget>[
            const Image(
              image: NetworkImage('https://placeimg.com/640/480/any'),
              height: 250.0,
            ),
            new Row(
              children: <Widget>[
                new RaisedButton(
                  padding: EdgeInsets.only(left: 100.0),
                  color: Colors.grey,
                  child: Text('Sign In', style: TextStyle(fontSize: 18.0),),
                  onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(),
                    ),
                  );
                },
                ),
                new RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.fromLTRB(100.0, 0.0, 80.0, 0.0),
                  child: Text('Sign Up', style: TextStyle(fontSize: 18.0),),
                  onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                )
              ]
            ),
          ],
        )
        ),
        Container(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              TextField(
              style: TextStyle(
                  fontSize: 15.0,
                ),
                decoration: InputDecoration(
                  labelText: 'e-mail',
                  icon: Icon(Icons.email)
                )
            ),
            TextField(
              style: TextStyle(
                  fontSize: 15.0,
                ),
                decoration: InputDecoration(
                  labelText: 'password',
                  icon: Icon(Icons.vpn_key)
                )
            ),
            Padding(padding: EdgeInsets.only(top: 50.0),
            child: new RaisedButton(
              padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              onPressed: null,
              child: Text('Sign In'),
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ))       
            ],
          )
        )
        ]
        )
      )
    );
  }
}