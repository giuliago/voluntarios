import 'package:flutter/material.dart';
import './eventDetails.dart';
import 'package:path/path.dart';
import './createEvent.dart';

class Home extends StatelessWidget {
  Widget _buildCard(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                      child: Image.network('https://placeimg.com/640/480/any',
                          // width: 300,
                          height: 200,
                          fit: BoxFit.fill),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCard(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
  }
}
