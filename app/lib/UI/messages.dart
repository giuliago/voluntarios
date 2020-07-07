import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import './home.dart';

class Messages extends StatefulWidget {
  _Messages createState() => _Messages();
}

class _Messages extends State<Messages> {
  Widget _buildMessages(BuildContext context) {
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
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Messages()));
                    },
                    child: Card(
                        child: Column(children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://placeimg.com/640/480/any')),
                        title: Text('Organização'),
                        subtitle: Text('Convidou você para participar'),
                      )
                    ])));
              }),
        )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMessages(context),
      appBar: AppBar(
        centerTitle: true,
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
