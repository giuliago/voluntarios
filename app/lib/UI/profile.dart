import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import './calendar.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  File _image;
  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText;

  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  Widget _editTitleTextField(String initialText) {
    if (_isEditingText)
      return SizedBox(
        width: 260,
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Text(
        initialText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: ListView(children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: new SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image != null)
                          ? Image.file(
                              _image,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () => debugPrint('teste'),
              /*{
                     uploadPic(context);
                    }*/
              child: Text(
                'Editar foto',
                style: TextStyle(fontSize: 16.0, color: Colors.deepOrange),
              ),
              color: Colors.grey[50],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 7),
                    child: Icon(Icons.person),
                  ),
                  _editTitleTextField('Giulianna Gonçalves')
                ])),
            Padding(
                padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 7),
                    child: Icon(Icons.location_on),
                  ),
                  _editTitleTextField('Brasília')
                ])),
            Padding(
                padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                child: Text('Account settings',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16.0))),
            Padding(
                padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 7),
                    child: Icon(Icons.email),
                  ),
                  _editTitleTextField('giulianna@hotmail.com')
                ])),
            Padding(
                padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 7),
                    child: Icon(Icons.lock),
                  ),
                  _editTitleTextField('Password')
                ])),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: FlatButton(
                    color: Colors.orange[700],
                    onPressed: () => debugPrint('Salvar perfil'),
                    child: Text(
                      'Salvar Perfil',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 00),
                child: FlatButton(
                    onPressed: () => debugPrint('log out'),
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ))),
          ]),
        ),
      ),
    );
  }
}

/* place code inside a class

  _query() async {

    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // raw query
    List<Map> result = await db.rawQuery('SELECT * FROM tb_perfilusuario');

    // print the results
    result.forEach((row) =>  {
      element = {
        'nome' : row.ColumnName,
        'email' : row.ColumnEmail,
        'regiao' : row.ColumnRegiao}
    });
    // .then((_) => element); (?)
  }
*/
