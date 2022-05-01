// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:soilpedia_lk/widgets/appLargeText.dart';
import 'package:soilpedia_lk/widgets/appText.dart';

class detailsPage extends StatefulWidget {
  const detailsPage({Key? key}) : super(key: key);

  @override
  _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  String currentAddress = 'Position';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }

  @override
  Widget build(BuildContext context) {
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
              decoration: BoxDecoration(
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
                      icon: Icon(Icons.menu),
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
                  decoration: BoxDecoration(
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
                            text: "Plant Name",
                            color: Colors.black87,
                            size: 30,
                          ),
                          TextButton(
                              onPressed: () {
                                
                              },
                              child: Text('Get Location')),
                          AppLargeText(text: ""),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          Text("currentAddress"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppLargeText(
                        text: "Description",
                        color: Colors.lightBlue,
                      ),
                      AppText(
                          text:
                              "If possible, your potting soil should be tailored to the particular type of plant you are growing.  African violets and ferns prefer soil with a high humus content, which can be achieved by adding leaf mold or shredded bark. Many kinds of orchids are happiest growing in nothing but fir bark or sphagnum moss.",
                          color: Colors.black)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

