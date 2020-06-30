import 'package:flutter/material.dart';
import 'package:voluntarios/UI/home.dart';
import './navBar.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image(
                  image: NetworkImage('https://placeimg.com/640/480/any'),
                  height: 200,
                  width: 450,
                  fit: BoxFit.fill,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(140.0, 120.0, 130.0, 10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange[800],
                      radius: 70,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 120.0,
                          height: 120.0,
                          child: Image(
                            image: NetworkImage(
                                'https://placeimg.com/640/480/any'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            Text(
              'Nome do evento',
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.black,
              ),
            ),
            Text(
              'Criado por: Fulano',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[900],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[900],
                    ),
                    /*children: <TextSpan>[
                            TextSpan(
                                text: 'bold',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' world!'),
                          ],*/
                  ),
                )),
            Row(
              children: <Widget>[
                Padding(
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.grey[800],
                  ),
                  padding: EdgeInsets.fromLTRB(70.0, 0, 10.0, 0.0),
                ),
                Text(
                  'Data do evento',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.grey[800],
                  ),
                  padding: EdgeInsets.fromLTRB(50.0, 0, 10.0, 0.0),
                ),
                Text(
                  'Brasília',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                    width: 400.0,
                    child: FlatButton(
                      child: Text(
                        'Participar do evento',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBar(),
                          ),
                        );
                      },
                      color: Colors.orange[700],
                    ))),
          ],
        ),
      )),
      appBar: AppBar(
        title: Text("Voluntários"),
        // Set the background color of the App Bar
        backgroundColor: Colors.orange,
      ),
    );
  }
}
