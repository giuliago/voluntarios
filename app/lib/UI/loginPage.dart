import 'package:flutter/material.dart';
import './navBar.dart';
import './signUp.dart';

class LoginPage extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
        children: <Widget>[
        Container(
          color: Colors.grey[100],
          child: Column(
          children: <Widget>[
            const Image(
              image: NetworkImage('https://placeimg.com/640/480/any'),
              height: 250.0,
            ),
            new Row(
              children: <Widget>[
                new FlatButton(
                  padding: EdgeInsets.only(left: 100.0),
                  color: Colors.grey[100],
                  onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                  child: Text('Sign In', style: TextStyle(fontSize: 18.0),)
                ),
                new FlatButton(
                  color: Colors.grey[100],
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
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  style: TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'e-mail',
                      icon: Icon(Icons.email)
                    )
                ),
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
            child: new FlatButton(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              textColor: Colors.deepOrange,
              onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(),
                    ),
                  );
                },
              child: Text('Sign In', style: TextStyle(fontSize: 15)), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: Colors.deepOrange)),
              )
              )       
            ],
          )
        )
        ]
        )
      )
    );
  }
}