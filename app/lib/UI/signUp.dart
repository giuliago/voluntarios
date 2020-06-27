import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './calendar.dart';
import 'package:intl/intl.dart'; 
import './navBar.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart';

class SignUp extends StatelessWidget{
    DateTime _selectedDate;
    TextEditingController nomeController = new TextEditingController();
    TextEditingController regiaoController = new TextEditingController();
    TextEditingController nascimentoController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController senhaController = new TextEditingController();
    TextEditingController confirmaSenhaController = new TextEditingController();
    DateTime _selectedDate;

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.all(40.0),
        child: ListView(
            children: <Widget>[
              TextField(
                controller: nascimentoController,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.person),
                )
              ),
              TextField(
                controller: nascimentoController,
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
                controller: nascimentoController,
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
                controller: emailControler;
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  icon: Icon(Icons.email),
                )
              ),
              TextField(
                controller: senhaController;
                obscureText: true,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  icon: Icon(Icons.lock),
                )
              ),
              Container(
                padding: EdgeInsets.only(left: 40.0),
                child: TextField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Confirme a senha',
                )
              ),
              ),            
              Padding(padding: EdgeInsets.only(top: 50.0),
                child: new RaisedButton(
                  onPressed: (){
                  _insert();
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  ))       
            ],
        ),
        ),       
      )
      );
  }
  _insert() async {
    Database db = await DatabaseHelper.instance.database;
  
    //raw insert
    
      //int idusuario = //valor obtido pelo botão
      String name = nomeController.text;
      String regiao = regiaoController.text;
      String nascimento = nascimentoController.text;
      String email = emailController.text;
      String senha = senhaController.text;

      int id = await db.rawInsert(
        'INSERT INTO ${DatabaseHelper.tableUser}'
              '${DatabaseHelper.columnName}, ${DatabaseHelper.columnEmail}, ${DatabaseHelper.columnSenha}, ${DatabaseHelper.columnNascimento}, ${DatabaseHelper.columnRegiao}) '
              'VALUES(?, ?, ?, ?, ?)', [name, email, senha, nascimento, regiao]);
      print(await db.query(DatabaseHelper.tableUser));
  }
}