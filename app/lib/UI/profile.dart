import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:voluntarios/UI/splashScreen.dart';
import './home.dart';
import 'editProfile.dart';
import 'package:async/async.dart';
//import 'DB/database_helper.dart';
//import 'package:sqflite/sqflite.dart'

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  String nomeCookie = "";
  String regiaoCookie = "";
  String emailCookie = "";

  Widget _buildProfile(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAvatar(context),
        _description(context),
        _info(context),
        //se não for o proprio perfil, mudar a info para esse:
        //convidar(context)
      ],
    );
  }

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

  setEmailCookie() async {
    getEmailCookie().then((val3) => setState(() {
          emailCookie = val3;
        }));
  }

  getEmailCookie() async {
    final prefs = await SharedPreferences.getInstance();
    final emailCookie = prefs.getString('emailCookie') ?? 0;
    return emailCookie;
  }

  Widget _description(BuildContext context) {
    return Container(
        width: 320,
        height: 180,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 220, 0),
                child: Text(
                  'Descrição',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen[700]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ));
  }

  Widget _info(BuildContext context) {
    setEmailCookie();
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text(
                'Informações pessoais',
                style: TextStyle(fontSize: 16, color: Colors.lightGreen[700]),
              )),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Icon(
                    Icons.email,
                    size: 20,
                    color: Colors.grey[500],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '$emailCookie',
                    style: TextStyle(color: Colors.grey[500]),
                  )),
            ],
          ),
          _buttonLogout(context)
        ],
      ),
    ));
  }

  void logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoadingScreen()),
        ModalRoute.withName('/LoginPage'));
  }

  Widget _buttonLogout(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 30.0,
      width: 120,
      child: RaisedButton(
        color: Colors.red,
        onPressed: () {
          logoutUser(context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        child: Text(
          "Sair",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _convidar(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Deseja convidar para sua organização?',
            style: TextStyle(fontSize: 14),
          )),
      Container(
        height: 40.0,
        width: 180,
        child: RaisedButton(
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
      )
    ]));
  }

/*  Widget _buildList(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Expanded(
                child: Row(children: <Widget>[
              SizedBox(
                  width: 400,
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildAvatarOrg(context, 20, 400, 40);
                      }))
            ]))));
  }*/

/*  Widget _organizations(BuildContext context) {
    return SizedBox(
        width: 320,
        height: 180,
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 220, 0),
                child: Text(
                  'Descrição',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen[700]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ));
  }*/

  /*Widget _buildAvatarOrg(
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
  }*/

  Widget _buildAvatar(BuildContext context) {
    setRegiaoCookie();
    setNomeCookie();
    return Stack(children: <Widget>[
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
                  padding: EdgeInsets.only(top: 20),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 120,
                      height: 120,
                      child: Image(
                        image: NetworkImage('https://placeimg.com/640/480/any'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '$nomeCookie',
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
                  Text('$regiaoCookie', style: TextStyle(color: Colors.white60))
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.edit,
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
      body: _buildProfile(context),
    );
  }
}
