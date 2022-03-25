import 'dart:io';

import 'package:flutter/material.dart';
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

class _HomePageState extends State<HomePage> {
  File? _image;

  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
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
        onPressed: () {},
        child: Text('Select'),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}
