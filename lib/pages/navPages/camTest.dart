// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:soilpedia_lk/main.dart';

void main() {
  runApp(CameraPage());
}

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Future<Album> fetchAlbum(String encodedUrl) async {
  final response = await http.get(Uri.parse(encodedUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int soilId;

  const Album({
    required this.soilId,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      soilId: json['soilId'],
    );
  }
}

class _HomePageState extends State<HomePage> {
  File? _image;
  String url = "";
  String link = "http://34.66.246.198/?img=";
  String enc = "";

  final imagePicker = ImagePicker();

  get futureAlbum => null;
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  // uploadFile(String text, File file) async {
  //   String name = DateTime.now().millisecondsSinceEpoch.toString();
  //   var imageFile = FirebaseStorage.instance.ref().child(name).child("/.jpg");
  //   UploadTask task = imageFile.putFile(_image!);
  //   TaskSnapshot snapshot = await task;

  //   //for downloading
  //   url = await snapshot.ref.getDownloadURL();
  //   await FirebaseFirestore.instance
  //       .collection("images")
  //       .doc()
  //       .set({"imageUrl": url});

  //   print(url);
  // }

  uploadFile() async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile = FirebaseStorage.instance.ref().child(name).child("/.jpg");
    UploadTask task = imageFile.putFile(_image!);
    TaskSnapshot snapshot = await task;

    //for downloading
    url = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("images")
        .doc()
        .set({"imageUrl": url});

    print(url);
    enc = link +
        "https%3A%2F%2Ffirebasestorage.googleapis.com%2Fv0%2Fb%2Fsign-in-page-1ebaa.appspot.com%2Fo%2F1648985227598%252F.jpg%3Falt%3Dmedia%26token%3Df60ba203-1059-4b27-a4b9-d34ac2249c66";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SoilpediaLK',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 2.0,
            color: Colors.green[50],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Stack(
        children: [
          Positioned(
              child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("snapshot.data!.title");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )),
          Positioned(
            child: Image.asset('assets/images/pic1.jpg'),
          ),
          Positioned(
              top: 480,
              left: 126,
              width: 150,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: getImage,
                child: Text('Scan',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )),
          Positioned(
            top: 5,
            left: -5,
            height: 470,
            width: 420,
            child: _image == null
                ? Center(
                    child: Text('Press the button to capture the image'),
                  )
                : Image.file(_image!),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadFile();
          print(" yooooooooooooooooooooooo");

          late Future<Album> futureAlbum;
          @override
          void initState() {
            super.initState();
            futureAlbum = fetchAlbum(enc);
          }
        },
        child: Text('Select'),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}
