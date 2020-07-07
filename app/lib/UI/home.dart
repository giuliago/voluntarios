import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'package:intl/date_symbol_data_local.dart';
import 'package:voluntarios/UI/yourEvents.dart';
import './eventDetails.dart';
import 'package:path/path.dart';
import './events.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'messages.dart';

class Home extends StatefulWidget {
  final dbHelper = database.DatabaseHelper.instance;

  @override
  State<StatefulWidget> createState() {
    Intl.defaultLocale = "pt_BR";
    initializeDateFormatting('pt_BR', null);
    return _Home();
  }
}

class _Home extends State<Home> {
  final dbHelper = database.DatabaseHelper.instance;
  List _events = [
    929299,
    '20/02/2021',
    'Nome Evento',
    'Description',
    'Brasília'
  ];

  List _eventsInscritos = [
    929299,
    '20/02/2021',
    'Nome Evento',
    'Description',
    'Brasília'
  ];

  String nomeCookie = "";
  String regiaoCookie = "";
  int idusuarioCookie;

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
    final regiaoCookie = prefs.getString('regiaoCookie');
    return regiaoCookie;
  }

  setidusuarioCookie() async {
    getidusuarioCookie().then((valID) => setState(() {
          idusuarioCookie = valID;
        }));
  }

  getidusuarioCookie() async {
    final prefs = await SharedPreferences.getInstance();
    idusuarioCookie = prefs.getInt('idusuarioCookie');
    print(idusuarioCookie);
    return idusuarioCookie;
  }

  listLength() async {
    print("Enter listLength: ");
    print(_events);
    _consultarEventos().then((valorList) => setState(() {
          print("Enter setState: ");
          //print(valorList);
          _events = valorList;
          print("Enter insert _events: ");
          print(_events);
        }));
    //print("valor do List _events");
    //print(_events);
  }

  listLengthInscrito() async {
    _consultarEventosInscritos().then((valorListInscritos) => setState(() {
          //print(valorList);
          _eventsInscritos = valorListInscritos;
        }));
    //print("valor do List _events");
    //print(print("Enter listLength: ");_events);
  }

  Widget _buildHome(BuildContext context) {
    setidusuarioCookie();
    setRegiaoCookie();
    setNomeCookie();
    listLength();
    listLengthInscrito();
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

  Widget _buildCard(
      bool icone, double height, double width, int index, String listas) {
    if (listas.contains("_eventsInscritos")) {
      var dataSplitted = _eventsInscritos[index]['data'].toString();
      var data = dataSplitted.substring(0, 10).replaceAll(RegExp('-'), '/');
      String dataF = "$data";
      //var dataSplitted = _events[index]['data'];
      //DateFormat formatter = DateFormat('dd-MM-yyyy');
      //String formatted = formatter.format(dataSplitted);
      //String dataF = "$formatted";
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
                  title: Text(_eventsInscritos[index]['nome'].toString()),
                  trailing: Icon(Icons.calendar_today),
                  subtitle: Text(dataF),
                ),
              ],
            ),
          ));
    } else {
      var dataSplitted = _events[index]['data'].toString();
      var data = dataSplitted.substring(0, 10).replaceAll(RegExp('-'), '/');
      String dataF = "$data";
      //var dataSplitted = _events[index]['data'];
      //DateFormat formatter = DateFormat('dd-MM-yyyy');
      //String formatted = formatter.format(dataSplitted);
      //String dataF = "$formatted";
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
                  title: Text(_events[index]['nome'].toString()),
                  trailing: Icon(Icons.calendar_today),
                  subtitle: Text(dataF),
                ),
              ],
            ),
          ));
    }
  }

  Widget _buildYourEvents() {
    return Row(children: <Widget>[
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _eventsInscritos.length,
              itemBuilder: (BuildContext context, int index) {
                String listas;
                listas = "_eventsInscritos";
                return new GestureDetector(
                    //You need to make my child interactive
                    onTap: () {
                      var dataSplitted =
                          _eventsInscritos[index]['data'].toString();
                      var data = dataSplitted
                          .substring(0, 10)
                          .replaceAll(RegExp('-'), '/');
                      String dataF = "$data";
                      String nome = _eventsInscritos[index]['nome'].toString();
                      debugPrint('Nome $nome');

                      String descricao =
                          _eventsInscritos[index]['descricao'].toString();
                      String regiao =
                          _eventsInscritos[index]['regiao'].toString();
                      int idevento =
                          _eventsInscritos[index]['idevento'].toInt();
                      final details =
                          Details(idevento, dataF, nome, descricao, regiao);
                      //Navigator.pop(context, details);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetails(details: details),
                        ),
                      );
                    },
                    child: _buildCard(true, 200, 220, index, listas));
              }))
    ]);
  }

  Widget _buildEvents() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _events.length,
        itemBuilder: (BuildContext context, int index) {
          String listas = "_events";
          return new InkWell(
              //You need to make my child interactive
              onTap: () {
                String nome = _events[index]['nome'].toString();
                debugPrint('Nome $nome');
                var dataSplitted = _events[index]['data'].toString();
                var data =
                    dataSplitted.substring(0, 10).replaceAll(RegExp('-'), '/');
                String dataF = "$data";

                String descricao = _events[index]['descricao'].toString();
                String regiao = _events[index]['regiao'].toString();
                int idevento = _events[index]['idevento'].toInt();
                final details =
                    Details(idevento, dataF, nome, descricao, regiao);
                //Navigator.pop(context, details);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetails(details: details),
                  ),
                );
              },
              child: _buildCard(true, 200, 220, index, listas));
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
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm', 'pt_BR')
                          .format(dataSplitted[0]);
                  debugPrint('date formatted: $formattedDate');
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://placeimg.com/640/480/any' /*_events[index]['picture']['large']*/)),
                          title: Text(_events[index] ?? ['nome']),
                          subtitle:
                              Text(_events[index][formattedDate].toString()),
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

  /*var refreshKey = GlobalKey<RefreshIndicatorState>(); */

/*
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
    final todasLinhasEventos = await dbHelper.queryEventosRegiao(regiaoCookie);
    List resultado = todasLinhasEventos.toList();
    /*print('Consulta todas os eventos:');
    todasLinhasEventos.forEach((row) => print(row));*/
    return resultado;
    todasLinhasEventos.forEach((row) => print(row));
  }

  _consultarEventosInscritos() async {
    final todasLinhasInscritos =
        await dbHelper.queryEventosInscritos(idusuarioCookie);
    List resultado = todasLinhasInscritos.toList();
    return resultado;
  }
}
