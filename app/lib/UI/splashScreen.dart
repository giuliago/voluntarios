import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'mainPage.dart';
import 'package:simple_animations/simple_animations.dart';
import 'navBar.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key, this.tela}) : super(key: key);
  final int tela;

  @override
  _LoadingScreen createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen> {
  final tween = MultiTrackTween([
    Track("color1").add(Duration(seconds: 1),
        ColorTween(begin: Colors.lightBlue, end: Colors.lightGreen)),
    Track("color2").add(Duration(seconds: 2),
        ColorTween(begin: Colors.lightGreen, end: Colors.lightBlue)),
  ]);

  Widget _splashScreen2() {
    return ControlledAnimation(
        playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
        builder: (context, animation) {
          return Stack(children: <Widget>[
            SplashScreen(
              seconds: 6,
              navigateAfterSeconds: NavBar(),
              loaderColor: Colors.lightGreen,
            ),
            ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animation["color1"], animation["color2"]],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds),
                child: Center(
                    child: ImageIcon(
                  AssetImage('images/bonecos.png'),
                  color: Colors.white,
                  size: 110.0,
                )))
          ]);
        });
  }

  Widget _splashScreen() {
    return ControlledAnimation(
        playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
        builder: (context, animation) {
          return Stack(children: <Widget>[
            SplashScreen(
              seconds: 3,
              navigateAfterSeconds: MainPage(),
              loaderColor: Colors.white,
            ),
            ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [animation["color1"], animation["color2"]],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds),
                child: Center(
                    child: ImageIcon(
                  AssetImage('images/bonecos.png'),
                  color: Colors.white,
                  size: 110.0,
                )))
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.tela == 1 ? _splashScreen2() : _splashScreen(),
    );
  }
}