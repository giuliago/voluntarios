import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:voluntarios/UI/mainPage.dart';
import 'package:voluntarios/UI/splashScreen.dart';
import 'UI/navBar.dart';
import 'UI/eventDetails.dart';
import 'UI/imageUploader.dart';
import 'UI/mainPage.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          accentColor: Colors.lightGreen,
          primaryColor: Colors.lightGreen,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: LoadingScreen(),
        routes: <String, WidgetBuilder>{
          '/details': (BuildContext context) => EventDetails(),
        });
  }
}
