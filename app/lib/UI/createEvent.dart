import 'package:flutter/material.dart';
import 'package:voluntarios/UI/eventDetails.dart';
import 'package:voluntarios/UI/imageUploader.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'calendar.dart';
//import 'package:sqflite/sqflite.dart'

class CreateEvent extends StatelessWidget {
  final maxLines = 8;
  final dbHelper = database.DatabaseHelper.instance;
  TextEditingController nomeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  DateTime data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                TextField(
                    controller: nomeController,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nome do evento',
                    )),
                Container(
                    height: maxLines * 24.0,
                    padding: EdgeInsets.only(top: 12.0),
                    child: TextField(
                        controller: descriptionController,
                        maxLines: maxLines,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Descrição do evento',
                          fillColor: Colors.white,
                          filled: true,
                        ))),
                DatePicker(
                    firstDate: 1920, lastDate: 2010, stateVar: 2, style: 1),
                Container(
                    padding: EdgeInsets.only(top: 12.0),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Localização',
                        icon: Icon(Icons.location_on),
                      ),
                    )),
                UploadImage(),
                RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  color: Colors.orange[700],
                  textColor: Colors.white,
                  onPressed: () {
                    data = DatePicker(
                        firstDate: 1920,
                        lastDate: 2010,
                        stateVar: 2,
                        style: 1) as DateTime;
                    String nome = nomeController.text;
                    String descricao = descriptionController.text;
                    var lista = [nome, descricao, data, 'Brasilia'];
                    print(data);
                    _inserir(lista);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetails(),
                      ),
                    );
                  },
                  child: Text('Criar Evento'),
                )
              ],
            )),
        appBar: AppBar(
          title: Text("Voluntários"),
          backgroundColor: Colors.orange,
        ));
  }

  void _inserir(List lista) async {
    String nome = lista[0];
    String descricao = lista[1];
    String data = lista[2];
    //String regiao = lista[3];
    // linha para incluir
    Map<String, dynamic> row = {
      database.DatabaseHelper.eventName: nome,
      database.DatabaseHelper.eventDescription: descricao,
      database.DatabaseHelper.eventDate: data
      //database.DatabaseHelper.eventRegion: regiao
    };
    final id = await dbHelper.insertEvent(row);
    print('linha inserida id: $id');
  }
}
