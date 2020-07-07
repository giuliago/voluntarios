import 'package:flutter/material.dart';
import 'package:voluntarios/UI/eventDetails.dart';
import 'package:voluntarios/UI/imageUploader.dart';
import 'package:voluntarios/UI/messages.dart';
import 'package:voluntarios/UI/yourEvents.dart';
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
  String dropdownValue = 'Brasília';
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
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
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
              Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
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
                      items: <String>['Brasília', 'São Paulo', 'Rio de Janeiro']
                          .map<DropdownMenuItem<String>>(
                              (String regiaoController) {
                        return DropdownMenuItem<String>(
                          value: regiaoController,
                          child: Text(regiaoController,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16.0)),
                        );
                      }).toList(),
                    ),
                  )),
              UploadImage(),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    height: 40.0,
                    width: 180,
                    child: RaisedButton(
                      onPressed: () {
                        final String nome = nomeController.text;
                        final String regiao = dropdownValue;
                        final String descricao = descriptionController.text;
                        data = _selectedDate;
                        final DateTime dataEvento = data;
                        var lista = [nome, descricao, dataEvento, regiao];
                        _inserir(lista);
                        _consultarEventos();
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.lightGreen, Colors.lightBlue],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Criar",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ))),
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
      ),
    );
  }

  void _inserir(List lista) async {
    String nome = lista[0];
    String descricao = lista[1];
    String data = lista[2].toIso8601String();
    String fk = 'NULL';
    String fk1 = 'NULL';
    int disponibilidade = 1;
    String regiao = lista[3];
    // linha para incluir
    Map<String, dynamic> row = {
      database.DatabaseHelper.eventName: nome,
      database.DatabaseHelper.eventDescription: descricao,
      database.DatabaseHelper.eventDate: data,
      database.DatabaseHelper.eventFK1: fk,
      database.DatabaseHelper.eventFK2: fk1,
      database.DatabaseHelper.eventDisponibility: disponibilidade,
      database.DatabaseHelper.eventRegion: regiao
    };
    final id = await dbHelper.insertEvent(row);
    print('linha inserida id: $id');
  }

  void _consultarEventos() async {
    final todosEventos =
        await dbHelper.queryEventos(); // Eventos são list<map<string,dynamic>>
    print('Consulta todos os eventos:');
    todosEventos.forEach((row) => print(row));
  }
}
