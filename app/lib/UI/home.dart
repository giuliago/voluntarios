import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'package:voluntarios/UI/yourEvents.dart';
import './eventDetails.dart';
import 'package:path/path.dart';
import './events.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final dbHelper = database.DatabaseHelper.instance;

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final dbHelper = database.DatabaseHelper.instance;
  List _events = [];

  String nomeCookie = "";
  String regiaoCookie = "";

  setNomeCookie() async {
    getNomeCookie().then((val) => setState(() {
          nomeCookie = val;
        }));
  }

  getNomeCookie() async {
    final prefs = await SharedPreferences.getInstance();
    final nomeCookie = prefs.getString('nomeCookie') ?? 0;
    return nomeCookie;
  }

  setRegiaoCookie() async {
    getRegiaoCookie().then((val2) => setState(() {
          regiaoCookie = val2;
        }));
  }

  getRegiaoCookie() async {
    final prefs = await SharedPreferences.getInstance();
    final regiaoCookie = prefs.getString('regiaoCookie') ?? 0;
    return regiaoCookie;
  }

  listLength() async {
    _consultarEventos().then((valorList) => setState(() {
          //print(valorList);
          _events = valorList;
        }));
    //print("valor do List _events");
    //print(_events);
  }

  Widget _buildHome(BuildContext context) {
    listLength();
    setRegiaoCookie();
    setNomeCookie();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.cyan,
          bottom: PreferredSize(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 280, 20),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 50.0,
                  )),
              preferredSize: Size.fromHeight(40.0)),
          pinned: false,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Olá $nomeCookie, veja os eventos em $regiaoCookie',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Container(
              color: Colors.cyan,
              height: 210.0,
              child: _buildYourEvents(),
            ),
            Container(
                color: Colors.white,
                height: 80.0,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Veja os eventos que você participa!',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Events()));
                                    },
                                  text: 'Ver todos',
                                  style: TextStyle(
                                      color: Colors.lightGreen, fontSize: 17))
                            ])))),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: _buildEvents(),
            )
          ],
        )),
      ],
    );
  }

  Widget _buildCard(bool icone, double height, double width, int index) {
    var dataSplitted = _events[index]['data'];
    dataSplitted[0].split("T");
    return SizedBox(
        height: height,
        width: width,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                    'https://placeimg.com/640/480/any' /*_events[index]['picture']['large']*/,
                    height: 120,
                    fit: BoxFit.fill),
              ),
              ListTile(
                title: Text(_events[index] ?? ['nome']),
                trailing: Icon(Icons.calendar_today),
                subtitle: Text(_events[index] ?? [dataSplitted[0]]),
              ),
            ],
          ),
        ));
  }

  Widget _buildYourEvents() {
    return Row(children: <Widget>[
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                    //You need to make my child interactive
                    onTap: () {
                      var dataSplitted = _events[index]['data'];
                      dataSplitted[0].split("T");
                      String nome =
                          _events[index].toString() != null ? ['nome'] : 'Nada';
                      String data = _events[index].toString() != null
                          ? [dataSplitted[0]]
                          : 'Nada';
                      String descricao = _events[index].toString() != null
                          ? ['descricao']
                          : 'Nada';
                      String regiao = _events[index].toString() != null
                          ? ['regiao']
                          : 'Nada';
                      int idevento = _events[index].toString() != null
                          ? ['idevento']
                          : 'Nada';
                      final details =
                          Details(idevento, data, nome, descricao, regiao);
                      //Navigator.pop(context, details);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetails(details: details),
                        ),
                      );
                    },
                    child: _buildCard(true, 200, 220, index));
              }))
    ]);
  }

  Widget _buildEvents() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
              //You need to make my child interactive
              onTap: () {
                var dataSplitted = _events[index]['data'];
                dataSplitted[0].split("T");
                String nome =
                    _events[index].toString() != null ? ['nome'] : 'Nada';
                String data = _events[index].toString() != null
                    ? [dataSplitted[0]]
                    : 'Nada';
                String descricao =
                    _events[index].toString() != null ? ['descricao'] : 'Nada';
                String regiao =
                    _events[index].toString() != null ? ['regiao'] : 'Nada';
                int idevento =
                    _events[index].toString() != null ? ['idevento'] : 'Nada';
                final details =
                    Details(idevento, data, nome, descricao, regiao);
                //Navigator.pop(context, details);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetails(details: details),
                  ),
                );
              },
              child: _buildCard(true, 200, 220, index));
        });
  }

  //double tamanho = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildList() {
    //valida
    //final _events = _consultarEventos();
    return _events.length != 0
        ? RefreshIndicator(
            //return _events.length != 0 ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                //limita o tamanho da lista pra quantidade de eventos que há
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  var dataSplitted = _events[index]['data'];
                  dataSplitted[0].split("T");
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://placeimg.com/640/480/any' /*_events[index]['picture']['large']*/)),
                          title: Text(_events[index] ?? ['nome']),
                          subtitle: Text(_events[index] ?? [dataSplitted[0]]),
                          //trailing: Text(_age(_events[index])),
                        )
                      ],
                    ),
                  );
                }),
            //refresh list
            onRefresh: _getData,
          )
        : Center(child: CircularProgressIndicator());
  }

  //refresh dados do db
  Future<void> _getData() async {
    setState(() {
      //listLength();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //implementar builder dos icons
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.message,
                color: Colors.white70,
              ))
        ],
        leading: Icon(
          Icons.help,
          color: Colors.white70,
        ),
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Voluntários',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildHome(context),
    );
  }

  /*var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _buildHome();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _Home();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        child: _list(context, "oi"),
        onRefresh: refreshList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEvent(),
            ),
          );
        },
      ),
    );
  }*/
  _consultarEventos() async {
    final todasLinhasEventos = await dbHelper.queryEventos();
    List resultado = todasLinhasEventos.toList();
    print('Consulta todas os eventos:');
    todasLinhasEventos.forEach((row) => print(row));
    return resultado;
  }

  _consultarEventosInscritos() async {
    final todasLinhas = await dbHelper.queryEventosInscritos();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }
}
