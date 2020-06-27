import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
/*import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';*/
 
class UploadImage extends StatelessWidget {
  /*UploadImage() : super();
 
  final String title = "Upload Image Demo";
 
  @override
  UploadImageState createState() => UploadImageState();
}
 
class UploadImageState extends State<UploadImage> {
  //
  static final String uploadEndPoint =
      'http://localhost/flutter_test/upload_image.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
 
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }
 
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
 
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }
 
  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
 
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }*/
 
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0)),
        child: Column(
          children: <Widget>[
            const Image(
              image: NetworkImage('https://fbcd.co/product-lg/e0be382e770d873f0ef4633a0a760900_resize.jpg'),
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              width: 400.0,
              height: 50.0,
              child: RaisedButton(
              padding: EdgeInsets.all(0.0),
              color: Colors.white70,
              /*onPressed: ,*/
              child: Text('Escolher imagem'),
              textColor: Colors.white,
            ),
            ),
          ],
        ),
      );
  }
}
