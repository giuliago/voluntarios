import 'package:flutter/material.dart';
import 'package:voluntarios/UI/eventDetails.dart';
import 'package:voluntarios/UI/imageUploader.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'calendar.dart';
import 'package:intl/intl.dart';
//import 'package:sqflite/sqflite.dart'

class CreateEvent extends StatefulWidget {
  _CreateEvent createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {
  DateTime _selectedDate;
  int firstDate;
  int lastDate;
  int stateVar;
  final maxLines = 8;
  final dbHelper = database.DatabaseHelper.instance;
  TextEditingController nomeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  DateTime data;

  void _pickDateDialog(BuildContext context) {
    showDatePicker(
            context: context,
            initialDatePickerMode: DatePickerMode.day,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(2020),
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2022)) //what will be the up to supported date in picker
        .then((pickedDate) {
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  Widget calendar(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Text('Data do evento'),
        subtitle: Text(
            _selectedDate == null //ternary expression to check if date is null
                ? 'Nenhuma data selecionada!'
                : 'Data: ${DateFormat.yMMMd().format(_selectedDate)}'),
        leading: Icon(Icons.calendar_today),
        onTap: () => _pickDateDialog(context),
      ),
    );
  }

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
                calendar(context),
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
                    String nome = nomeController.text;
                    String descricao = descriptionController.text;
                    data = _selectedDate;
                    final DateTime dataEvento = data;
                    var lista = [nome, descricao, dataEvento, 'Brasilia'];
                    print(lista);
                    _consultarEventos();
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
    String data = lista[2].toIso8601String();
    String fk = 'NULL';
    String fk1 = 'NULL';
    //String regiao = lista[3];
    // linha para incluir
    Map<String, dynamic> row = {
      database.DatabaseHelper.eventName: nome,
      database.DatabaseHelper.eventDescription: descricao,
      database.DatabaseHelper.eventDate: data,
      database.DatabaseHelper.eventFK1: fk,
      database.DatabaseHelper.eventFK2: fk1
      //database.DatabaseHelper.eventRegion: regiao
    };
    final id = await dbHelper.insertEvent(row);
    print('linha inserida id: $id');
  }

  void _consultarEventos() async {
    final todasEventos = await dbHelper.queryAllRows();
    print('Consulta todos os eventos:');
    todasEventos.forEach((row) => print(row));
  }
}
