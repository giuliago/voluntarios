import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImage createState() => _UploadImage();
}

class _UploadImage extends State<UploadImage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}*/

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Column(
        children: <Widget>[
          _image == null
              ? Image.asset('images/camera.png', fit: BoxFit.fitWidth)
              : Image.file(_image),
          SizedBox(
            width: 400.0,
            height: 50.0,
            child: RaisedButton(
              padding: EdgeInsets.all(0.0),
              color: Colors.white70,
              onPressed: getImage,
              child: Text('Escolher imagem'),
            ),
          ),
        ],
      ),
    );
  }
}
