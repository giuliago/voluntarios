import 'package:flutter/material.dart';
import 'package:voluntarios/UI/eventDetails.dart';
import 'package:voluntarios/UI/imageUploader.dart';
import 'package:flutter/cupertino.dart';
import 'calendar.dart';
//import 'package:sqflite/sqflite.dart'

class CreateEvent extends StatelessWidget {
  final maxLines = 8;

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

                DatePicker(firstDate: 2020, lastDate: 2022, stateVar: 1),

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

