﻿import 'package:flutter/material.dart';
import './eventDetails.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _Events createState() => _Events();
}

class _Events extends State<Events> {
  String dropdownValue = 'Ativos';

Widget _buildCard(BuildContext context){
  return ListView(
    children: <Widget>[
      Container(
        margin:EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetails(),
                  ),
                );
              },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                      'https://placeimg.com/640/480/any',
                      // width: 300,
                      height: 200,
                      fit:BoxFit.fill
                  ),
                ),
                ListTile(
                  title: Text('Evento Beneficiário'),
                  trailing: Icon(Icons.calendar_today),
                  subtitle: Text('24/04/2019'),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: _buildCard(context)
  );
  }
}
/* place code inside a class

  _query() async {

    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // raw query
    List<Map> result = await db.rawQuery('SELECT * FROM tb_evento WHERE disponibilidade=?', ['1']);

    // print the results
    result.forEach((row) =>  {
      element = {
        'nome' : row.ColumnName,
        'data' : row.ColumnDate,
        'descricao' : row.ColumnDescript}
    });
    // .then((_) => element); (?)
  }
*/
