import 'package:flutter/material.dart';
import './calendar.dart';
import 'package:intl/intl.dart'; 
import './navBar.dart';

class SignUp extends StatelessWidget{
    DateTime _selectedDate;

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
            children: <Widget>[
              TextField(
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.person),
                )
              ),
              TextField(
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Localização',
                  hintText: 'Brasília',
                  icon: Icon(Icons.location_on),
                )
              ),
              TextField(
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: (_selectedDate == null //ternary expression to check if date is null
                  ? 'Data de nascimento'
                  : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                  icon: Icon(Icons.calendar_today),
                  hintText: '13/04/1997'
                )
              ),
              TextField(
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  icon: Icon(Icons.email),
                )
              ),
              TextField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  icon: Icon(Icons.lock),
                )
              ),
              Padding(padding: EdgeInsets.only(top: 50.0),
                child: new RaisedButton(
                  onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(),
                    ),
                  );
                },
                  child: Text('Sign Up'),
                  color: Colors.deepOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  ))       
            ],
        )
      )
      );
  }
}