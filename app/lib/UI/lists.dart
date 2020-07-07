import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import './home.dart';
import 'messages.dart';

class ListPeople extends StatefulWidget {
  _ListPeople createState() => _ListPeople();
}

class _ListPeople extends State<ListPeople> {
  Widget _buildPeople(BuildContext context) {
    return Container(
        width: 400,
        height: 600,
        child: Expanded(
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
                            backgroundImage: NetworkImage(
                                'https://placeimg.com/640/480/any')),
                        title: Text('nome'),
                        subtitle: Text('Descrição'),
                      )
                    ],
                  ),
                );
              }),
        )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPeople(context),
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
    );
  }
}
