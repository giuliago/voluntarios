import 'package:flutter/material.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class CreateEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.airport_shuttle,
              size: 160.0,
              color: Colors.blue,
            ),
            Text("Third Tab")
          ],
        ),
      ),
    );
  }
}

  /* Place it inside the class
  _insert() async {
    Database db = await DatabaseHelper.instance.database;
  
    //raw insert
    
      int idevento = //value obtained from the button
      String date = //value obtained from the button
      String name = //value obtained from the button
      String description = //value obtained from the button
      int disp = //value obtained from the button
      int idorganizacao = //value obtained from the static value
      int idusuario = //value obtained from the static value
      int id = await db.rawInsert(
        'INSERT INTO ${DatabaseHelper.tb_evento}'
              '(${DatabaseHelper.columnIdEvent}, ${DatabaseHelper.columnDate}, ${DatabaseHelper.columnIdName}
              , ${DatabaseHelper.columnDescript}, ${DatabaseHelper.columnDisponib}
              , ${DatabaseHelper.columnFkEvent1}, ${DatabaseHelper.columnFkEvent2}) '
              'VALUES(?, ?, ?, ?, ?, ?)', [idevento, date, name, description, disp, idorganizacao, idusuario]);
      print(await db.query(DatabaseHelper.tb_evento))
  }
  */

