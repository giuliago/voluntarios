﻿import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import './calendar.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class Profile extends StatelessWidget {
  Widget _buildProfile(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAvatar(context),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: 400,
        height: 240,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.lightBlue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 120,
                      height: 120,
                      child: Image(
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Giulianna Gonçalves',
                    style: TextStyle(
                        fontSize: 24, color: Colors.white70.withOpacity(0.8)),
                  )),
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 145),
                      child: Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.white70,
                      )),
                  Text('Brasília', style: TextStyle(color: Colors.white60))
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.edit,
                color: Colors.white70,
              ))
        ],
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white70,
        ),
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Voluntários',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildProfile(context),
    );
  }
}

/* place code inside a class

  _query() async {

    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // raw query
    List<Map> result = await db.rawQuery('SELECT * FROM tb_perfilusuario');

    // print the results
    result.forEach((row) =>  {
      element = {
        'nome' : row.ColumnName,
        'email' : row.ColumnEmail,
        'regiao' : row.ColumnRegiao}
    });
    // .then((_) => element); (?)
  }
*/
