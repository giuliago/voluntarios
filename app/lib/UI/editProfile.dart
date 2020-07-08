import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import './home.dart';
import 'messages.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  File _image;
  bool _isEditingText = false;
  final dbHelper = database.DatabaseHelper.instance;
  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _senhaController;
  TextEditingController nomeController;
  TextEditingController regiaoController;
  TextEditingController descricaoController;
  String initialText;
  String dropdownValue = 'Brasília';
  int maxLines = 8;
  String nomeCookie = "";
  String emailCookie = "";
  int idusuarioCookie;

  void initState() {
    super.initState();
    _emailController = TextEditingController(text: initialText);
    _nameController = TextEditingController(text: initialText);
    _senhaController = TextEditingController(text: initialText);
    nomeController = new TextEditingController();
    regiaoController = new TextEditingController();
    descricaoController = new TextEditingController();
    setNomeCookie();
    setEmailCookie();
    setidusuarioCookie();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _senhaController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  setNomeCookie() async {
    getNomeCookie().then((val) => setState(() {
          nomeCookie = val;
        }));
  }

  getNomeCookie() async {
    final prefs = await SharedPreferences.getInstance();
    final nomeCookie = prefs.getString('nomeCookie') ?? 0;
    return nomeCookie;
  }

  setEmailCookie() async {
    getEmailCookie().then((val3) => setState(() {
          emailCookie = val3;
        }));
  }

  getEmailCookie() async {
    final prefs = await SharedPreferences.getInstance();
    final emailCookie = prefs.getString('emailCookie') ?? 0;
    return emailCookie;
  }

  setidusuarioCookie() async {
    getidusuarioCookie().then((valID) => setState(() {
          idusuarioCookie = valID;
        }));
  }

  getidusuarioCookie() async {
    final prefs = await SharedPreferences.getInstance();
    idusuarioCookie = prefs.getInt('idusuarioCookie') ?? 0;
    print(idusuarioCookie);
    return idusuarioCookie;
  }

  Widget _editTitleTextField(
      String initialText, TextEditingController _controller) {
    if (_isEditingText)
      return SizedBox(
        width: 269,
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _controller,
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

  Widget _buildForm(BuildContext context) {
    return Builder(
        builder: (context) => Center(
              child: Container(
                width: 300,
                child: ListView(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 70,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 140.0,
                          height: 180.0,
                          child: (_image != null)
                              ? Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  "images/person.jpg",
                                  fit: BoxFit.fill,
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
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.lightGreen),
                    ),
                    color: Colors.white,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Icon(Icons.person),
                        ),
                        _editTitleTextField('$nomeCookie', _nameController)
                      ])),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 60,
                        width: 200,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          isExpanded: true,
                          underline: Container(
                            height: 2,
                            color: Colors.grey[300],
                          ),
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.lightGreen,
                          ),
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
                                      color: Colors.black, fontSize: 16.0)),
                            );
                          }).toList(),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                          height: maxLines * 10.0,
                          padding: EdgeInsets.only(top: 12.0),
                          child: TextField(
                              controller: descricaoController,
                              maxLines: maxLines,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                fillColor: Colors.white,
                                filled: true,
                              )))),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Account settings',
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 16.0))),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Icon(Icons.email),
                        ),
                        _editTitleTextField('$emailCookie', _emailController)
                      ])),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Icon(Icons.lock),
                        ),
                        _editTitleTextField('Password', _senhaController)
                      ])),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: FlatButton(
                          color: Colors.lightGreen[600],
                          onPressed: () {
                            final String nome = nomeController.text;
                            final String descricao = descricaoController.text;
                            final String regiao = dropdownValue;
                            final String email = _emailController.text;
                            final String senha = _senhaController.text;
                            var lista = [nome, descricao, regiao, email, senha];
                            print("idusuario");
                            print(idusuarioCookie);
                            _update(lista, idusuarioCookie);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Salvar Perfil',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ))),
                ]),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildForm(context),
        appBar: AppBar(
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Messages()));
                    },
                    child: Icon(
                      Icons.message,
                      color: Colors.white70,
                    )))
          ],
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white70,
              )),
          backgroundColor: Colors.cyan[700],
          title: Text(
            'Voluntários',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  void _update(List lista, int idusuarioCookie) async {
    //[nome, regiao, email, senha, nascimento];
    String nome = lista[0];
    String descricao = lista[1];
    String regiao = lista[2];
    String email = lista[3];
    String senha = lista[4];
    //print("Nascimento????: " + nascimento);
    // linha para incluir
    Map<String, dynamic> row = {
      database.DatabaseHelper.columnNome: nome,
      database.DatabaseHelper.columnDescricao: descricao,
      database.DatabaseHelper.columnRegiao: regiao,
      database.DatabaseHelper.columnEmail: email,
      database.DatabaseHelper.columnSenha: senha
    };
    final id = await dbHelper.update(row, idusuarioCookie);
    print('linha inserida id: $id');
  }
}
