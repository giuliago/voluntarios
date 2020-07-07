import 'package:flutter/material.dart';
import 'package:voluntarios/UI/createEvent.dart';
import 'eventDetails.dart';
import 'messages.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class YourEvents extends StatefulWidget {
  YourEvents({Key key}) : super(key: key);

  @override
  _Events createState() => _Events();
}

class _Events extends State<YourEvents> {
  int flag = 0;

  Widget _buildEventPage(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.cyan,
          bottom: PreferredSize(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 280, 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateEvent()));
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.white70,
                      size: 60.0,
                    )),
              ),
              preferredSize: Size.fromHeight(0.0)),
          pinned: false,
          expandedHeight: 140.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Criar evento',
                style: TextStyle(color: Colors.white, fontSize: 26)),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Container(
              width: 400,
              height: 100,
              child: Center(
                  child: Text('Veja seus eventos criados!',
                      style: TextStyle(fontSize: 20))),
            ),
            Container(width: 400, height: 220, child: _buildEvents(context)),
          ],
        )),
      ],
    );
  }

  Widget _buildEvents(BuildContext context) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetails(),
                        ),
                      );
                    },
                    child: _buildCard(context));
              }))
    ]);
  }

  Widget _buildCard(BuildContext context) {
    return SizedBox(
        width: 240,
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
                child: Image.network('https://placeimg.com/640/480/any',
                    height: 120, fit: BoxFit.fill),
              ),
              ListTile(
                title: Text('Evento Beneficente'),
                trailing: Icon(Icons.calendar_today),
                subtitle: Text('24/04/2019'),
              ),
            ],
          ),
        ));
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
        body: _buildEventPage(context));
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
