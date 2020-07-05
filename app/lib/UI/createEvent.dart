import 'package:flutter/material.dart';
import 'package:voluntarios/UI/eventDetails.dart';
import 'package:voluntarios/UI/imageUploader.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart';
import 'package:flutter/cupertino.dart';
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
}

/* Colocar dentro da classe
  _insert() async {
    Database db = await DatabaseHelper.instance.database;
  
    //raw insert
    
      int idevento = //valor obtido pelo botão
      String date = //valor obtido pelo botão
      String name = //valor obtido pelo botão
      String description = //valor obtido pelo botão
      int disp = //valor obtido pelo botão
      int idorganizacao = //valor obtido pelo valor estático
      int idusuario = //valor obtido pelo valor estático
      int id = await db.rawInsert(
        'INSERT INTO ${DatabaseHelper.tb_evento}'
              '(${DatabaseHelper.columnIdEvent}, ${DatabaseHelper.columnDate}, ${DatabaseHelper.columnIdName}
              , ${DatabaseHelper.columnDescript}, ${DatabaseHelper.columnDisponib}
              , ${DatabaseHelper.columnFkEvent1}, ${DatabaseHelper.columnFkEvent2}) '
              'VALUES(?, ?, ?, ?, ?, ?)', [idevento, date, name, description, disp, idorganizacao, idusuario]);
      print(await db.query(DatabaseHelper.tb_evento))
  }
  */
