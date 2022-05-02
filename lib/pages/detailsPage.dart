// ignore_for_file: unnecessary_import, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soilpedia_lk/pages/navPages/mainPage.dart';
import 'package:soilpedia_lk/reusable/reusable.dart';
import 'package:soilpedia_lk/screen/signin_screen.dart';
import 'package:soilpedia_lk/widgets/appLargeText.dart';
import 'package:soilpedia_lk/widgets/appText.dart';
import 'package:soilpedia_lk/widgets/responsiveButton.dart';

import '../utils/colors.dart';

class detailsPage extends StatefulWidget {
  const detailsPage({Key? key}) : super(key: key);

  @override
  _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  List images = [
    "https://images.unsplash.com/photo-1503903587778-5124b6d043b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1473081556163-2a17de81fc97?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1543076499-a6133cb932fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  ];

  List texts = [
    "We are a group of Level 5 Computer Science Students following the SDGP module",
    "Code Ninja | SDGP CS-15",
    "Maneth Pirisyala, Nimsara Nanyakkara, Amaanie Yoosuf, Dinun Ranasinghe, Gihan Athulathmudali",
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
                      image: NetworkImage(images[index]), fit: BoxFit.cover)),
              child: Container(
                margin: const EdgeInsets.only(top: 150, left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "About Us"),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: texts[index],
                          ),
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
                      children: List.generate(images.length, (indexDots) {
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
