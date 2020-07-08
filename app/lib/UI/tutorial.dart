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
        backgroundColor: Colors.lightGreen,
      ),
    );
    slides.add(
      new Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/photo_ruler.png",
        backgroundColor: Colors.amber,
      ),
    );
  }

  void onDonePress() {
    // TODO: go to next screen
  }

  void onSkipPress() {
    // TODO: go to next screen
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
