import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview/controller.dart';
import 'package:webview/tokenListClass.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  Color color1 = Color.fromRGBO(244, 110, 49, 1);
  Color color2 = Color.fromRGBO(54, 54, 54, 1);
  // Alignment hhf = Alignment.topLeft;
  int _start = 10;
  int i = 0;
  int selectedTile = 0;
  // List<bool> selectedList = [];
  Timer? timer;
  FlutterTts flutterTts = FlutterTts();
  double volume = 1.0;
  double tileHeight = 0.0;
  int? tileCount;
  double tileWidth = 0.0;
  // bool showToken = true;
  double pitch = 1.0;
  double speechrate = 0.5;
  List<String> languages = [];
  String? langCode = "en-IN";
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<String> updateList = [];
  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speak("Welcome to city clinic", "init", 0);
    Provider.of<Controller>(context, listen: false).getSettings(context);

    Provider.of<Controller>(context, listen: false).getQueueList(context, 0);

    // selectedList = List.generate(
    //     Provider.of<Controller>(context, listen: false).queuetList.length,
    //     (index) => false);
    getQueueList();
    // callToken();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding;
    //  Timer.periodic(const Duration(minutes: 2), (timer) async {

    //  });
    double topPadding = 8;
    // int totPadding = 2 * botomPadding;

    Size size = MediaQuery.of(context).size;
    // if (Provider.of<Controller>(context, listen: false).tileCount == null) {
    //   tileCount = 3;
    // } else {
    //   Provider.of<Controller>(context, listen: false).tileCount!;
    // }

    // tileHeight =
    //     ((size.height - padding.top - (size.height * 0.13)) / tileCount!) - 4;
    // tileWidth=(size.width*0.6);
    print(
        "height----${size.height}-----kToolbarHeight-------$kToolbarHeight-----padding--${padding.top}");
    return Scaffold(
      body: SafeArea(child: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.tileCount == null) {
            tileCount = 3;
          } else {
            tileCount = value.tileCount;
          }
          tileHeight = ((size.height - padding.top - (size.height * 0.13)) /
                  tileCount!) -
              0.5;
          if (value.isLoading) {
            return SpinKitCircle(
              color: Colors.black,
            );
          } else {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 37, 37, 37),
                    // color:
                    //     parseColor(value.settings[0]["theme_clr"].toString()),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  height: size.height * 0.13,
                  child: ListTile(
                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.showToken == 1
                            ? Container(
                                width: size.width * 0.12,
                                child: Text(
                                  "Token",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: value.fontsize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          width: value.showToken == 1
                              ? size.width * 0.68
                              : size.width * 0.80,
                          child: Text(
                            "Name",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: value.fontsize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.15,
                          child: Text(
                            "Room No",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: value.fontsize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                value.isLoading
                    ? SpinKitCircle(
                        color: Colors.black,
                      )
                    : Expanded(
                        child: ListView.builder(
                          key: listKey,
                          shrinkWrap: true,
                          // itemCount: 3,
                          itemCount:
                              value.tileCount == null ? 3 : value.tileCount!,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            // _speak(value.queuetList[index]["msg"], "speak", index);
                            return Padding(
                              padding: const EdgeInsets.all(0.25),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: value.queuetList.length > index &&
                                            value.quelistReady &&
                                            value.selectedTile[index]
                                        ? Colors.red
                                        : index % 2 == 0
                                            ? parseColor(value.settings[0]
                                                    ["theme_clr"]
                                                .toString())
                                            : Colors.grey[300]
                                    // parseColor(value.settings[0]
                                    //         ["theme_clr"]
                                    //     .toString())
                                    ),
                                height: tileHeight,
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        value.showToken == 1
                                            ? Container(
                                                alignment: Alignment.topLeft,
                                                width: size.width * 0.12,
                                                child: Text(
                                                  value.queuetList.length <=
                                                          index
                                                      ? ""
                                                      : value.queuetList[index]
                                                          ["queue_token"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // tokenList[index].tokenNum.toString(),
                                                  style: GoogleFonts.aBeeZee(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    fontSize: value.fontsize,
                                                    fontWeight: FontWeight.bold,
                                                    color: value.queuetList
                                                                    .length >
                                                                index &&
                                                            value
                                                                .quelistReady &&
                                                            value.selectedTile[
                                                                index]
                                                        ? Colors.white
                                                        : index % 2 == 0
                                                            ? Colors.white
                                                            : parseColor(
                                                                value
                                                                    .settings[0]
                                                                        [
                                                                        "theme_clr"]
                                                                    .toString(),
                                                              ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          width: value.showToken == 1
                                              ? size.width * 0.68
                                              : size.width * 0.80,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            textAlign: TextAlign.start,
                                            value.queuetList.length <= index
                                                ? ""
                                                : value.queuetList[index]
                                                        ["patient_name"]
                                                    .toString()
                                                    .toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            // tokenList[index].name.toString(),
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: value.fontsize,
                                              fontWeight: FontWeight.bold,
                                              color: value.queuetList.length >
                                                          index &&
                                                      value.quelistReady &&
                                                      value.selectedTile[index]
                                                  ? Colors.white
                                                  : index % 2 == 0
                                                      ? Colors.white
                                                      : parseColor(
                                                          value.settings[0]
                                                                  ["theme_clr"]
                                                              .toString(),
                                                        ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 0.15,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            value.queuetList.length <= index
                                                ? ""
                                                : value.queuetList[index]
                                                        ["cab_id"]
                                                    .toString()
                                                    .toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: value.fontsize,
                                              fontWeight: FontWeight.bold,
                                              color: value.queuetList.length >
                                                          index &&
                                                      value.quelistReady &&
                                                      value.selectedTile[index]
                                                  ? Colors.white
                                                  : index % 2 == 0
                                                      ? Colors.white
                                                      : parseColor(
                                                          value.settings[0]
                                                                  ["theme_clr"]
                                                              .toString(),
                                                        ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            );
          }
        },
      )),
    );
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechrate);
    await flutterTts.setLanguage(langCode!);
    // flutterTts.getVoices();
  }

  void _speak(String text, String start, int i) async {
    initSetting();

    if (start != "init") {
      Provider.of<Controller>(context, listen: false).setColor(i, true);

      print(
          "zdsd----${Provider.of<Controller>(context, listen: false).selectedTile}");
    }

    await flutterTts.speak(text);
  }

  //////////////////////////////////////////
  void getQueueList() async {
    String str = "";
    Timer.periodic(Duration(seconds: 7), (timer) {
      // Provider.of<Controller>(context, listen: false).setColor(i, false);

      if (Provider.of<Controller>(context, listen: false).quelistReady) {
        if (i <
            Provider.of<Controller>(context, listen: false).queuetList.length) {
          selectedTile = selectedTile + 1;

          // Provider.of<Controller>(context, listen: false).setColor(i);
          print(
              "dszdszds---${Provider.of<Controller>(context, listen: false).queuetList[i]["msg"]}-------${Provider.of<Controller>(context, listen: false).queuetList[i]["voice_status"].runtimeType}");
          if (Provider.of<Controller>(context, listen: false).queuetList[i]
                  ["voice_status"] ==
              "0") {
            _speak(
                Provider.of<Controller>(context, listen: false).queuetList[i]
                    ["msg"],
                "speak",
                i);
          }

          updateList.add(Provider.of<Controller>(context, listen: false)
              .queuetList[i]["queue_id"]);
          // Future.delayed(const Duration(milliseconds: 500), () {
          //   Provider.of<Controller>(context, listen: false)
          //       .getQueueList(context, i);
          // });

          // Provider.of<Controller>(context, listen: false).setColor(i, false);

          i = i + 1;

          // });
        } else {
          str = updateList.join(",");
          print("str-----$str");

          Provider.of<Controller>(context, listen: false)
              .updateList(context, str);
          Provider.of<Controller>(context, listen: false)
              .getQueueList(context, i);
          updateList.clear();
          i = 0;
          selectedTile = 0;
          // _start--;
        }
      }
    });
  }
  ////////////////////////////////////////////////
}
