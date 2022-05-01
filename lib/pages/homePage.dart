import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soilpedia_lk/screen/home_screen.dart';
import 'package:soilpedia_lk/utils/colors.dart';
import 'package:soilpedia_lk/widgets/appLargeText.dart';

import '../screen/side_bar.dart';

List a = [
  "https://images.unsplash.com/photo-1518994603110-1912b3272afd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=724&q=80",
  "https://images.unsplash.com/photo-1586281010691-f9da4be5b1f7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  "https://images.unsplash.com/photo-1515150144380-bca9f1650ed9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      "https://images.unsplash.com/photo-1566088339830-15dbac2fcc97?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  "https://images.unsplash.com/photo-1586892184525-fc1cccaced39?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  "https://images.unsplash.com/photo-1601985705806-5b9a71f6004f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
];

List b = [
  "https://images.unsplash.com/photo-1621459557554-60a70d3d61ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  "https://images.unsplash.com/photo-1558746572-9098b044338a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=729&q=80",
  "https://images.unsplash.com/photo-1532978678576-8e855616398d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
];

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(length: 3, vsync: this);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: hexStringToColor("#2C7744"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: Row(
              children: [
                // Icon(
                //   Icons.menu,
                //   size: 30,
                //   color: Colors.black,
                // ),
                Expanded(child: Container()),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(
              text: "SoilpediaLK",
              color: Colors.cyan,
              size: 40,
            ),
          ),
          const SizedBox(height: 30),
          //topbar
          Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 30, right: 20),
                controller: _controller,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(
                    text: "Plants",
                  ),
                  Tab(text: "Soils"),
                  Tab(text: "Recent Searches"),
                ],
              )),
          const SizedBox(height: 33),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 5),
            height: 300,
            width: double.maxFinite,
            child: TabBarView(
              controller: _controller,
              children: [
                ListView.builder(
                  itemCount: a.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(a[index]),
                              fit: BoxFit.cover)),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: b.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(b[index]),
                              fit: BoxFit.cover)),
                    );
                  },
                ),
                const Text("")
              ],
            ),
          ),
          // Container(
          //     padding: const EdgeInsets.only(left: 110, top: 10),
          //     child: ElevatedButton(
          //       style: ButtonStyle(
          //         backgroundColor:
          //             MaterialStateProperty.all<Color>(Colors.green),
          //       ),
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => CameraPage()));
          //       },
          //       child: Text('Scan Using Camera',
          //           style: TextStyle(fontSize: 20, color: Colors.white)),
          //     )),
        ],
      ),
    );
  }
}
