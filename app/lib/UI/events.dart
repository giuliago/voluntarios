import 'package:flutter/material.dart';
import './eventDetails.dart';

class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _Events createState() => _Events();
}

class _Events extends State<Events> {
  String dropdownValue = 'Ativos';

Widget _buildCard(BuildContext context){
  return ListView(
    children: <Widget>[
      Container(
        margin:EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                  child: Image.network(
                      'https://placeimg.com/640/480/any',
                      // width: 300,
                      height: 200,
                      fit:BoxFit.fill
                  ),
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
  );
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
       children: <Widget>[
         DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;          
        });
      },
      items: <String>['Ativos', 'Encerrados', 'Criados']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
    _buildCard(context)]
    )
    );
  }
}
