import 'package:flutter/material.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart';
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

