import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voluntarios/UI/lists.dart';
import 'package:voluntarios/UI/yourEvents.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import './eventDetails.dart';
import 'package:path/path.dart';
import './events.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class OrganizationTab extends StatefulWidget {
  @override
  _OrganizationTab createState() => _OrganizationTab();
}

class _OrganizationTab extends State<OrganizationTab>
    with SingleTickerProviderStateMixin {
  int idusuarioCookie;
  TabController _controller;
  final dbHelper = database.DatabaseHelper.instance;
  List<dynamic> listaQuery = ['3', 'Nome', 'Descrição', 'Região'];

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
    );
    listLength();
    super.initState();
  }

//idusuarioCookie
  setidusuarioCookie() async {
    getidusuarioCookie().then((valID) => setState(() {
          idusuarioCookie = valID;
        }));
  }

  getidusuarioCookie() async {
    final prefs = await SharedPreferences.getInstance();
    final idusuarioCookie = prefs.getInt('idusuarioCookie');
    print(idusuarioCookie);
    return idusuarioCookie;
  }

  queryOrganization() async {
    final queryOrganizacao =
        await dbHelper.queryOrganizationTab(idusuarioCookie);
    print(idusuarioCookie);
    return queryOrganizacao;
  }

  setQueryOrganization() async {
    queryOrganization().then((valQuery) => setState(() {
          if (valQuery != null) {
            listaQuery = valQuery;
            print("print 1:");
            print(listaQuery);
          }
        }));
  }

  Widget _buildYourOrganization(BuildContext context) {
    return Column(
      children: <Widget>[_buildAvatarSets(context), _description(context)],
    );
  }

  Widget _buildOrganizations(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.cyan,
          bottom: PreferredSize(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 280, 20),
                  child: Icon(
                    Icons.business,
                    color: Colors.white70,
                    size: 50.0,
                  )),
              preferredSize: Size.fromHeight(40.0)),
          pinned: false,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Veja as organizações que você participa',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Container(
                width: 400,
                height: 350,
                child: _buildYourOrganizations(context)),
          ],
        )),
      ],
    );
  }

  Widget _buildYourOrganizations(BuildContext context) {
    return Expanded(
        child: SizedBox(
      width: 300,
      height: 100,
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://placeimg.com/640/480/any')),
                    title: Text('nome'),
                    subtitle: Text('Descrição aqui'),
                  )
                ],
              ),
            );
          }),
    ));
  }

  Widget _description(BuildContext context) {
    String descricaoOrganizacao = listaQuery[2];
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 220, 0),
            child: Text(
              'Descrição',
              style: TextStyle(fontSize: 20, color: Colors.lightGreen[700]),
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Organização',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black),
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
            padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
            child: Expanded(
                child: Row(children: <Widget>[
              SizedBox(
                  width: 330,
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildAvatar(context, 40, 40);
                      }))
            ]))),
        _buttonExcluir(context),
      ],
    );
  }

  Widget _buttonExcluir(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 30.0,
      width: 120,
      child: RaisedButton(
        color: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              //validação pra home
              builder: (context) => Home(),
            ),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        child: Text(
          "Excluir",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, double width, double height) {
    return Padding(
        padding: EdgeInsets.only(right: 5),
        child: ClipOval(
          child: new SizedBox(
            width: width,
            height: height,
            child: Image(
              image: NetworkImage('https://placeimg.com/640/480/any'),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }

  Widget _buildAvatarSets(BuildContext context) {
    String nomeOrganizacao = listaQuery[1];
    String regiaoOrganizacao = listaQuery[3];
    return Column(children: <Widget>[
      Container(
        width: 400,
        height: 220,
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
                  padding: EdgeInsets.only(top: 10),
                  child: _buildAvatar(context, 120, 120)),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Organização',
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setQueryOrganization();
    return Scaffold(
        body: Column(
          children: [
            TabBar(
              controller: _controller,
              tabs: [
                Tab(
                  text: "Sua Organização",
                  icon: Icon(Icons.group),
                ),
                Tab(
                  text: "Organizações",
                  icon: Icon(Icons.business),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  _buildYourOrganization(context),
                  _buildOrganizations(context),
                ],
              ),
            )
          ],
        ),
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
            Icons.help,
            color: Colors.white70,
          ),
          backgroundColor: Colors.cyan[700],
          title: Text(
            'Voluntários',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  String _nome(Map<dynamic, dynamic> user) {
    return user['tb_evento']['nome'];
  }

  String _descricao(Map<dynamic, dynamic> user) {
    return user['tb_evento']['descricao'];
  }

  String _data(Map<dynamic, dynamic> user) {
    var dataSplitted = user['tb_evento']['data'];
    dataSplitted[0].split("T");
    return dataSplitted[0];
  }

  List<dynamic> _events = [];
  double tamanho = 0;

  void listLength() async {
    _consultarEventosInscritos().then((valorList) => setState(() {
          _events = valorList;
        }));
  }

  Widget _buildList() {
    //valida
    //final _events = _consultarEventos();
    return _events.length != 0
        ? RefreshIndicator(
            //return _events.length != 0 ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(tamanho),
                //limita o tamanho da lista pra quantidade de eventos que há
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://placeimg.com/640/480/any' /*_events[index]['picture']['large']*/)),
                          title: Text(_nome(_events[index])),
                          subtitle: Text(_descricao(_events[index])),
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
      listLength();
    });
  }

  _consultarEventosInscritos() async {
    final todasLinhas = await dbHelper.queryEventosInscritos(idusuarioCookie);
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }
}

//idusuarioCookie
