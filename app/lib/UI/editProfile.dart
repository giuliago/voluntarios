import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
import 'messages.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  File _image;
  bool _isEditingText = false;
  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _senhaController;
  String initialText;
  String dropdownValue = 'Brasília';
  int maxLines = 8;
  TextEditingController nomeController = new TextEditingController();
  TextEditingController regiaoController = new TextEditingController();
  TextEditingController descricaoController = new TextEditingController();
  String nomeCookie = "";
  String emailCookie = "";

  void initState() {
    super.initState();
    _emailController = TextEditingController(text: initialText);
    _nameController = TextEditingController(text: initialText);
    _senhaController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _senhaController.dispose();
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
    setNomeCookie();
    setEmailCookie();
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
                          onPressed: () => debugPrint('Salvar perfil'),
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
}
