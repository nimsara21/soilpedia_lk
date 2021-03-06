// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soilpedia_lk/widgets/appLargeText.dart';
import 'package:soilpedia_lk/widgets/appText.dart';

class detailsPage extends StatefulWidget {
  const detailsPage({Key? key}) : super(key: key);

  @override
  _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  String currentAddress = 'Position';
  late Position currentposition;

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
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
                                _determinePosition();
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
                          Text(currentAddress),
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
}
