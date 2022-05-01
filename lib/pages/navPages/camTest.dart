import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:soilpedia_lk/main.dart';
import 'package:soilpedia_lk/pages/homePage.dart';

import '../../widgets/appLargeText.dart';
import '../../widgets/appText.dart';

Future<void> delay(int seconds) async {
  print("delaying");
  await Future.delayed(Duration(seconds: seconds));
  print("delay stopped");
}

class myNum {
  static late String plantN;
  static late String soil;
  static late String wateringLevel;
  static late String fertilizers;
  static late String wateringFrequency;
  static late String link;
  static late String currentLocation;
}

class CameraPage extends StatelessWidget {
  late String value;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse(myNum.link));

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
  final int plantId;
  final String soilName;
  final String plantName;

  const Album({
    required this.plantName,
    required this.plantId,
    required this.soilName,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      plantName: json['plantName'],
      plantId: json['plantId'],
      soilName: json['soilName'],
    );
  }
}

class HomePage extends StatefulWidget {
  late String value;

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class MySecondPage extends StatefulWidget {
  String value;
  MySecondPage(this.value);
  @override
  _MySecondPageState createState() => _MySecondPageState(myNum.plantN);
}

class _HomePageState extends State<HomePage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    print(futureAlbum);
    print(fetchAlbum());
  }

  File? _image;
  String url = "";
  String serverIP = "http://34.66.246.198/?img=";
  String getReqLink = "";

  final imagePicker = ImagePicker();

  get futureAlbum1 => null;
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

  void getInfo() async {
    http.get(
        Uri.parse('http://35.160.71.50/api/soil/?soil=45z79kkiish0y0xne0gs'),
        headers: {
          "Authorization": "Token 87d61bd2475d7ee3ddf24cb148e84d8f1557b3f4"
        }).then((http.Response response) {
      final int statusCode = response.statusCode;

      var scores = jsonDecode(response.body);
      for (var i = 0; i < scores[0]['plants'].length; i++) {
        myNum.plantN = scores[0]['plants'][2]['plantName'];
        myNum.wateringLevel = scores[0]['plants'][2]['wateringLevel'];
        myNum.fertilizers = scores[0]['plants'][2]['fertilizers'];
        myNum.wateringFrequency = scores[0]['plants'][2]['wateringFrequency'];
        myNum.soil = "soilType";

        print("this is the plant");
        print(scores[0]['plants'][2]['wateringFrequency']);
      }
    });
  }

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
    myNum.link = serverIP + url;
    getReqLink = serverIP +
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
                child: const Text('Scan',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )),
          Positioned(
            top: 5,
            left: -5,
            height: 470,
            width: 420,
            child: _image == null
                ? const Center(
                    child: Text('Press the button to capture the image'),
                  )
                : Image.file(_image!),
          ),
          Positioned(
            top: 100,
            child: FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // myNum.yo = snapshot.data!.soilName;

                  return const Text("Press Select to continue");
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Fluttertoast.showToast(msg: "Uploading File");
          Fluttertoast.showToast(msg: "Retrieving Information");

          uploadFile();
          getInfo();
          await delay(4);

          print(" Uploaded Successfully.");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MySecondPage(myNum.plantN)),
          );
        },
        child: const Text('Select'),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}

class _MySecondPageState extends State<MySecondPage> {
  String value;
  _MySecondPageState(this.value);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/welcome2.jpg"),
                      fit: BoxFit.cover)),
            )),
            Positioned(
                left: 40,
                top: 70,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                      color: Colors.green[100],
                    )
                  ],
                )),
            Positioned(
                top: 315,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppLargeText(
                            text: myNum.soil,
                            color: Colors.black87,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          Text(myLocation.current),
                        ],
                      ),
                      SizedBox(height: 6),
                      AppLargeText(
                        text: myNum.plantN,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(height: 6),
                      AppText(
                          text: "Fertilizers: " +
                              myNum.fertilizers +
                              " \nWatering Level: " +
                              myNum.wateringLevel +
                              " \nWatering Frequency: " +
                              myNum.wateringFrequency,
                          color: Colors.black)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
