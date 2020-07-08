import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  _Tutorial createState() => _Tutorial();
}

class _Tutorial extends State<Tutorial> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "VOLUNTÁRIOS",
        description:
            "Um aplicativo que facilita a divulgação de organizações e eventos voluntários. Aqui você pode começar seus eventos beneficentes e consegue encontrar facilmente formas de participar.",
        pathImage: "images/dica1.png",
        backgroundColor: Colors.cyan[400],
      ),
    );
    slides.add(
      new Slide(
        title: "ORGANIZAÇÕES",
        description:
            "Aqui você pode representar sua ONG criando um perfil e convidando voluntários para fazer parte. Assim todas essas pessoas são cadastradas automaticamente em seus eventos.",
        pathImage: "images/dica2.png",
        backgroundColor: Colors.lightGreen[400],
      ),
    );
    slides.add(
      new Slide(
        title: "EVENTOS",
        description:
            "Gerencie seus eventos, tenha formas fáceis de visualizar e uma timeline simples e intuitiva.",
        pathImage: "images/calendar.png",
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

  void onDonePress() {
    Navigator.pop(context);
  }

  void onSkipPress() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
