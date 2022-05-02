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

List<List<String>> plantsInfo = [];
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

class GalleryPage extends StatelessWidget {
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
  _MySecondPageState createState() => _MySecondPageState("myNum.plantN");
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
  String serverIP = "http://35.160.71.50/api/soil/?soil=";
  String getReqLink = "";

  final imagePicker = ImagePicker();

  get futureAlbum1 => null;
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.gallery);

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
    var imageFile = FirebaseStorage.instance.ref().child(name).child("/.png");
    UploadTask task = imageFile.putFile(_image!);
    TaskSnapshot snapshot = await task;

    //for downloading
    url = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("images")
        .doc()
        .set({"imageUrl": url});
    print("This is the image URL");
    print(url);
    print("Full Link with server IP");
    var encoded = Uri.encodeFull(url);
    print(encoded);
    myNum.link = serverIP + encoded;
    print(myNum.link);
  }

  Future<String> getInfo() async {
    print("testing the link");
    print(myNum.link);
    await http.get(Uri.parse(myNum.link), headers: {
      "Authorization": "Token 87d61bd2475d7ee3ddf24cb148e84d8f1557b3f4"
    }).then((http.Response response) {
      print("Link");
      print(serverIP + url);
      final int statusCode = response.statusCode;

      var scores = jsonDecode(response.body);

      myNum.soil = scores[0]['soilName'];
      for (var i = 0; i < scores[0]['plants'].length; i++) {
        List<String> justList = [];
        justList.insert(0, scores[0]['plants'][i]['plantName']);
        justList.insert(1, scores[0]['plants'][i]['wateringLevel']);
        justList.insert(2, scores[0]['plants'][i]['fertilizers']);
        justList.insert(3, scores[0]['plants'][i]['wateringFrequency']);
        justList.insert(4, scores[0]['plants'][i]['plantImage']);
        plantsInfo.insert(i, justList);

        print("this is the plant");
      }
    });
    return "test";
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
            width: 500,
            child: Image.asset('assets/images/welcome2.jpg'),
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
                child: const Text('Import',
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
                  return Text(" ");
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

          await uploadFile();
          plantsInfo.clear();
          // sleep(Duration(seconds: 10));
          await getInfo();

          print(" Uploaded Successfully.");
          print(plantsInfo.length);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MySecondPage("app")),
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
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: plantsInfo.length,
          itemBuilder: (_, index) {
            print(index);
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(plantsInfo[index][4]),
                      fit: BoxFit.cover)),
              child: Container(
                margin: const EdgeInsets.only(top: 150, left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: plantsInfo[index][0],
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: "Watering Level: " + plantsInfo[index][1],
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: "Watering Frequency: " + plantsInfo[index][3],
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: "Fertilizers: " + plantsInfo[index][2],
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 120,
                          height: 65,
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(plantsInfo.length, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: 8,
                          height: index == indexDots ? 8 : 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? Colors.green[700]
                                  : Colors.white.withOpacity(0.8)),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
