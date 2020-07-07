import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import './home.dart';
import 'messages.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  File _image;
  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText;
  String dropdownValue = 'Brasília';
  int maxLines = 8;

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
        width: 269,
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
                        _editTitleTextField('Giulianna Gonçalves')
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
                        _editTitleTextField('giulianna@hotmail.com')
                      ])),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Icon(Icons.lock),
                        ),
                        _editTitleTextField('Password')
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
