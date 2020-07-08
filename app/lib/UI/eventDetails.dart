import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voluntarios/UI/lists.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'package:voluntarios/UI/home.dart';
import './messages.dart';
import 'package:flutter/gestures.dart';

class EventDetails extends StatefulWidget {
  //_EventDetails createState() => _EventDetails();
  final Details details;

  EventDetails(this.details);

  State<StatefulWidget> createState() {
    return _EventDetails(this.details);
  }
}

class Details {
  final int idevento;
  final String data;
  final String nome;
  //final DateTime birthday;
  final String descricao;
  final String regiao;
  //final DateTime date;

  Details(
    this.idevento,
    this.data,
    this.nome,
    //this.birthday,
    this.descricao,
    this.regiao,
    //this.date,
  );

  @override
  String toString() {
    return 'Details{idevento: $idevento, Data: $data, Nome: $nome, descricao: $descricao, regiao: $regiao}';
  }
}

class _EventDetails extends State<EventDetails> {
  final Details details;
  _EventDetails(this.details);

  final dbHelper = database.DatabaseHelper.instance;
  //final Details details;
  //_EventDetails({this.details});
  Widget build(BuildContext context) {
    return Scaffold(
      //implementar builder dos icons
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
      body: Container(
        child: _showEvent(context),
      ),
    );
  }

  Widget _buildAvatar(
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

  Widget _buildInitialInfo(BuildContext context) {
    // String regiao = details.regiao;
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.cyan,
          width: 450,
          height: 320,
          child: Row(
            children: <Widget>[
              Padding(
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.grey[800],
                  size: 20,
                ),
                padding: EdgeInsets.fromLTRB(15, 120, 5.0, 0.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 120, 0, 0.0),
                child: Text(
                  details.data,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Padding(
                child: Icon(
                  Icons.location_on,
                  size: 20,
                  color: Colors.grey[800],
                ),
                padding: EdgeInsets.fromLTRB(115, 120, 0, 0),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 120, 0, 0),
                  child: Text(
                    details.regiao,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                  )),
            ],
          ),
        ),
        Image(
          image: NetworkImage('https://placeimg.com/640/480/any'),
          height: 180,
          width: 450,
          fit: BoxFit.fill,
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(125.0, 100.0, 125.0, 0),
            child: _buildAvatar(context, 100, 90, 90)),
        Center(
            child: Padding(
                padding: EdgeInsets.only(top: 250),
                child: Text(
                  details.nome,
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.black,
                  ),
                ))),
        Center(
            child: Padding(
                padding: EdgeInsets.only(top: 290),
                child: Text(
                  'Criado por: Fulano',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ))),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Container(
      height: 40.0,
      child: RaisedButton(
        onPressed: () {
          //validação pra home
          Navigator.pop(context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightGreen, Colors.lightBlue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Participar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showEvent(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildInitialInfo(context),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              details.descricao,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[900],
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListPeople()));
              },
              child: Text('Participantes (200)...',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.lightBlue))),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Expanded(
                  child: Row(children: <Widget>[
                SizedBox(
                    width: deviceWidth - 20,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildAvatar(context, 20, 400, 40);
                        }))
              ]))),
          Padding(
              padding: EdgeInsets.only(bottom: 10), child: _button(context)),
        ],
      ),
    );
  }

  _consultarEvento() async {
    final todasLinhas = await dbHelper.queryEventos();
    print('Consulta todas os eventos:');
    todasLinhas.forEach((row) => print(row));
    return todasLinhas;
  }
}
