import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:webview/frstBody.dart';

class SrjScreen extends StatefulWidget {
  const SrjScreen({super.key});

  @override
  State<SrjScreen> createState() => _SrjScreenState();
}

class _SrjScreenState extends State<SrjScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int index = 0;
  int tbindex = 0;

  List<String> tabs = [
    "Year",
    "6 month",
    "Last month",
    "This week",
  ];

  List<bool> tabClick = [];

  List<CardList> listCard = [
    CardList(
      title: "Insurance",
      ser: "#111199",
      date: "20 Nov,2021",
      paid: "300",
      color1: Color.fromARGB(255, 240, 241, 170),
      color2: Color.fromARGB(255, 235, 238, 90),
    ),
    CardList(
        title: "Tax",
        ser: "#111121",
        date: "20 Oct,2021",
        paid: "400",
        color1: Color.fromARGB(255, 186, 231, 235),
        color2: Color.fromARGB(255, 6, 145, 155)),
    CardList(
      title: "Tax2",
      ser: "#111122",
      date: "20 Sep,2021",
      paid: "200",
      color1: Color.fromARGB(255, 235, 192, 231),
      color2: Color.fromARGB(255, 224, 66, 211),
    ),
  ];

  changeBody(int tabIndex) {
    print("tabindex----$tabIndex");
    switch (tabIndex) {
      case 0:
        return FirstBody(
          listCard: listCard,
        );
      case 1:
        return customWidget("haiiii");
      case 2:
        return customWidget("hellooo");
        case 3:
        return customWidget("fzdfd");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _tabController!.animateTo(0);
    tabClick = List.generate(tabs.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          toolbarHeight: 90,
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(10),
          //   child: Container(
          //     height: 37,
          //     decoration: BoxDecoration(
          //         // color: Colors.grey[300],
          //         // borderRadius: BorderRadius.circular(
          //         //   10,
          //         // ),
          //         ),
          //     child: TabBar(
          //         onTap: (sindex) {
          //           setState(() {
          //             index = sindex;
          //           });
          //           print("index-----$index ----${_tabController!.index}");
          //         },
          //         automaticIndicatorColorAdjustment: true,
          //         // labelPadding: EdgeInsetsGeometry.lerp(1, 2, 3),
          //         labelColor: Colors.white,
          //         unselectedLabelColor: Colors.black,
          //         indicator: BoxDecoration(
          //           borderRadius: BorderRadius.circular(
          //             5,
          //           ),
          //           color: index == _tabController!.index
          //               ? Colors.black
          //               : Colors.grey[300],
          //         ),
          //         isScrollable: true,
          //         indicatorColor: Colors.transparent,
          //         controller: _tabController,
          //         tabs: tabs.map((e) {
          //           return Container(
          //             child: Tab(
          //               child: Text(
          //                 e.toString(),
          //                 style: TextStyle(),
          //               ),
          //             ),
          //           );
          //         }).toList()),
          //   ),
          // ),
          centerTitle: true,
          title: Text(
            "Statistics",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey[100],
          elevation: 0,
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera,
                  color: Colors.grey,
                ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                label: ' ',
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 35,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabClick =
                              List.generate(tabs.length, (index) => false);
                          tabClick[index] = true;
                          tbindex = index;
                        });

                        // changeBody(index);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: tabClick[index]
                                ? Colors.black
                                : Colors.grey[300],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        width: 90,
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                              color: tabClick[index]
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(child: changeBody(tbindex))
          ],
        )
        //  TabBarView(
        //   controller: _tabController,
        //   children: [
        //     firstTab(),
        //     customWidget("Hai"),
        //     customWidget("Hai"),
        //     customWidget("Hai"),
        //     customWidget("Hai"),
        //   ],
        // ),
        );
  }

  ///////////////////////////////////////////////////////////////////
  Widget customWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        color: Colors.yellow,
        child: Center(child: Text(text)),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////
//   Widget firstTab() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 45.0),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 170,
//             width: 170,

//             // decoration: const BoxDecoration(
//             //   gradient: LinearGradient(
//             //     begin: Alignment.topRight,
//             //     end: Alignment.bottomLeft,
//             //     colors: [
//             //       Color.fromARGB(255, 72, 190, 201),
//             //       Color.fromARGB(255, 226, 228, 119),
//             //     ],
//             //   ),
//             //   shape: BoxShape.circle,
//             // ),
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Color.fromARGB(255, 72, 190, 201),
//                   width: 15,
//                 )),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Income",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(
//                     "\$12354.22",
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 17, 17, 17),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 18.0),
//             child: Text(
//               "\$2789.22",
//               style: TextStyle(
//                   color: Color.fromARGB(255, 17, 17, 17),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25),
//             ),
//           ),
//           Text(
//             "Expenses",
//             style: TextStyle(color: Colors.grey),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 38.0, left: 18),
//             child: Row(
//               children: [
//                 Text(
//                   "Templates",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 18.0),
//                   child: Text(
//                     "recently Added",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           Container(
//             height: 190,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemCount: listCard.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   // height: 20,
//                   width: 200,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 18.0),
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 15),
//                               child: Text(
//                                 listCard[index].ser.toString(),
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 15, top: 2),
//                               child: Text(
//                                 listCard[index].title.toString(),
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 15, top: 4),
//                               child: Text(
//                                 listCard[index].date.toString(),
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 29.0),
//                               child: Container(
//                                 width: 190,
//                                 height: 50,
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   color: listCard[index].color2,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Text(
//                                         "Paid",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(
//                                         "\$${listCard[index].paid.toString()}",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.grey[800],
//                                             fontWeight: FontWeight.bold),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       color: listCard[index].color1,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
}

//////////////////////////////////////////////////
class CardList {
  String? title;
  String? ser;
  String? paid;
  String? date;
  Color? color1;
  Color? color2;

  CardList(
      {this.title, this.ser, this.paid, this.date, this.color1, this.color2});
}
