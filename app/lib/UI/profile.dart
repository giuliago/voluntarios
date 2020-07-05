import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import './home.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class Profile extends StatelessWidget {
  Widget _buildProfile(BuildContext context) {
    return Column(
      children: <Widget>[_buildAvatar(context), _description(context)],
    );
  }

  Widget _description(BuildContext context) {
    return Container(
        width: 320,
        height: 180,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 220, 0),
                child: Text(
                  'Descrição',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen[700]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ));
  }

  Widget _buildList(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Expanded(
                child: Row(children: <Widget>[
              SizedBox(
                  width: 400,
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildAvatarOrg(context, 20, 400, 40);
                      }))
            ]))));
  }

  Widget _organizations(BuildContext context) {
    return SizedBox(
        width: 320,
        height: 180,
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 220, 0),
                child: Text(
                  'Descrição',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen[700]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ));
  }

  Widget _buildAvatarOrg(
      BuildContext context, double radius, double width, double height) {
    return Padding(
        padding: EdgeInsets.only(right: 5),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.cyan,
          child: ClipOval(
            child: new SizedBox(
              width: width,
              height: height,
              child: Image(
                image: NetworkImage('https://placeimg.com/640/480/any'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ));
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
          Icons.message,
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
