// ignore_for_file: unnecessary_import, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soilpedia_lk/widgets/appLargeText.dart';
import 'package:soilpedia_lk/widgets/appText.dart';
import 'package:soilpedia_lk/widgets/responsiveButton.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "welcome2.jpg",
    "welcome1.jpg",
    "welcome3.jpg",
  ];

  List texts = [
    "SoilpediaLK is an application that helps user...",
    "Use your camera to easily capture",
    "Get instant results and plant suggetions"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/" + images[index]),
                      fit: BoxFit.cover)),
              child: Container(
                margin: const EdgeInsets.only(top: 150, left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "Welcome to SoilpediaLK"),
                        AppText(
                          text: texts[index],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                              text:
                                  "SoilpeidaLK is an app that helps you to..."),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ResponsiveButton(
                          width: 150,
                        )
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots) {
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
