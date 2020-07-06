import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voluntarios/UI/yourEvents.dart';
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
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
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
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
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
      ],
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
}
