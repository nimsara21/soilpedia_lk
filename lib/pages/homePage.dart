// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soilpedia_lk/screen/home_screen.dart';
import 'package:soilpedia_lk/widgets/appLargeText.dart';

import '../screen/side_bar.dart';

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
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70, left: 20),
            child: Row(
              children: [
                // Icon(
                //   Icons.menu,
                //   size: 30,
                //   color: Colors.black,
                // ),
                Expanded(child: Container()),

                Container(
                  child: IconButton(
                    icon: const Icon(Icons.person),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                  ),
                  margin: const EdgeInsets.only(right: 28),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                )
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
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: const DecorationImage(
                              image: AssetImage("assets/images/welcome1.jpg"),
                              fit: BoxFit.cover)),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: const DecorationImage(
                              image: AssetImage("assets/images/welcome2.jpg"),
                              fit: BoxFit.cover)),
                    );
                  },
                ),
                const Text("Amo Amo SoilPedia LK")
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
